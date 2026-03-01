# frozen_string_literal: true

module MQ
  module REST
    module Admin
      # Configuration for synchronous polling operations.
      #
      # @!attribute [r] timeout_seconds
      #   @return [Float] maximum time to wait for the target state
      # @!attribute [r] poll_interval_seconds
      #   @return [Float] time between status polls
      SyncConfig = Data.define(:timeout_seconds, :poll_interval_seconds) do
        # @param timeout_seconds [Float] maximum wait time (default: 30.0)
        # @param poll_interval_seconds [Float] polling interval (default: 1.0)
        def initialize(timeout_seconds: 30.0, poll_interval_seconds: 1.0)
          unless timeout_seconds.positive?
            raise ArgumentError,
                  "timeout_seconds must be positive, got #{timeout_seconds}"
          end

          unless poll_interval_seconds.positive?
            raise ArgumentError,
                  "poll_interval_seconds must be positive, got #{poll_interval_seconds}"
          end

          super
        end
      end

      # Result of a synchronous start/stop/restart operation.
      #
      # @!attribute [r] operation
      #   @return [Symbol] +:started+, +:stopped+, or +:restarted+
      # @!attribute [r] polls
      #   @return [Integer] number of status polling iterations
      # @!attribute [r] elapsed_seconds
      #   @return [Float] total elapsed time in seconds
      SyncResult = Data.define(:operation, :polls, :elapsed_seconds)

      # @return [Set<String>] status values indicating a running state
      RUNNING_VALUES = %w[RUNNING running].to_set.freeze

      # @return [Set<String>] status values indicating a stopped state
      STOPPED_VALUES = %w[STOPPED stopped].to_set.freeze

      # Configuration for a specific MQ object type used by sync operations.
      #
      # @!attribute [r] start_qualifier
      #   @return [String] MQSC qualifier for the START command
      # @!attribute [r] stop_qualifier
      #   @return [String] MQSC qualifier for the STOP command
      # @!attribute [r] status_qualifier
      #   @return [String] MQSC qualifier for the DISPLAY status command
      # @!attribute [r] status_keys
      #   @return [Array<String>] attribute keys to check for status values
      # @!attribute [r] empty_means_stopped
      #   @return [Boolean] whether an empty status response means stopped
      ObjectTypeConfig = Data.define(
        :start_qualifier, :stop_qualifier, :status_qualifier,
        :status_keys, :empty_means_stopped
      )

      # @return [ObjectTypeConfig] configuration for channel sync operations
      CHANNEL_CONFIG = ObjectTypeConfig.new(
        start_qualifier: 'CHANNEL', stop_qualifier: 'CHANNEL',
        status_qualifier: 'CHSTATUS', status_keys: %w[channel_status STATUS],
        empty_means_stopped: true
      ).freeze

      # @return [ObjectTypeConfig] configuration for listener sync operations
      LISTENER_CONFIG = ObjectTypeConfig.new(
        start_qualifier: 'LISTENER', stop_qualifier: 'LISTENER',
        status_qualifier: 'LSSTATUS', status_keys: %w[status STATUS],
        empty_means_stopped: false
      ).freeze

      # @return [ObjectTypeConfig] configuration for service sync operations
      SERVICE_CONFIG = ObjectTypeConfig.new(
        start_qualifier: 'SERVICE', stop_qualifier: 'SERVICE',
        status_qualifier: 'SVSTATUS', status_keys: %w[status STATUS],
        empty_means_stopped: false
      ).freeze

      # Synchronous start/stop/restart operations with status polling.
      #
      # Issues the start or stop command, then polls the status endpoint
      # until the target state is reached or a timeout occurs.
      # Included by {Session}.
      module Sync
        # Start a channel and wait for it to reach RUNNING status.
        #
        # @param name [String] the channel name
        # @param config [SyncConfig, nil] polling configuration
        # @return [SyncResult] the operation result
        # @raise [TimeoutError] if the channel does not start within the timeout
        def start_channel_sync(name, config: nil)
          start_and_poll(name, CHANNEL_CONFIG, config)
        end

        # Stop a channel and wait for it to reach STOPPED status.
        #
        # @param name [String] the channel name
        # @param config [SyncConfig, nil] polling configuration
        # @return [SyncResult] the operation result
        # @raise [TimeoutError] if the channel does not stop within the timeout
        def stop_channel_sync(name, config: nil)
          stop_and_poll(name, CHANNEL_CONFIG, config)
        end

        # Restart a channel (stop then start) and wait for RUNNING status.
        #
        # @param name [String] the channel name
        # @param config [SyncConfig, nil] polling configuration
        # @return [SyncResult] the combined operation result
        # @raise [TimeoutError] if the channel does not reach the target state
        def restart_channel(name, config: nil)
          do_restart(name, CHANNEL_CONFIG, config)
        end

        # Start a listener and wait for it to reach RUNNING status.
        #
        # @param name [String] the listener name
        # @param config [SyncConfig, nil] polling configuration
        # @return [SyncResult] the operation result
        # @raise [TimeoutError] if the listener does not start within the timeout
        def start_listener_sync(name, config: nil)
          start_and_poll(name, LISTENER_CONFIG, config)
        end

        # Stop a listener and wait for it to reach STOPPED status.
        #
        # @param name [String] the listener name
        # @param config [SyncConfig, nil] polling configuration
        # @return [SyncResult] the operation result
        # @raise [TimeoutError] if the listener does not stop within the timeout
        def stop_listener_sync(name, config: nil)
          stop_and_poll(name, LISTENER_CONFIG, config)
        end

        # Restart a listener (stop then start) and wait for RUNNING status.
        #
        # @param name [String] the listener name
        # @param config [SyncConfig, nil] polling configuration
        # @return [SyncResult] the combined operation result
        # @raise [TimeoutError] if the listener does not reach the target state
        def restart_listener(name, config: nil)
          do_restart(name, LISTENER_CONFIG, config)
        end

        # Start a service and wait for it to reach RUNNING status.
        #
        # @param name [String] the service name
        # @param config [SyncConfig, nil] polling configuration
        # @return [SyncResult] the operation result
        # @raise [TimeoutError] if the service does not start within the timeout
        def start_service_sync(name, config: nil)
          start_and_poll(name, SERVICE_CONFIG, config)
        end

        # Stop a service and wait for it to reach STOPPED status.
        #
        # @param name [String] the service name
        # @param config [SyncConfig, nil] polling configuration
        # @return [SyncResult] the operation result
        # @raise [TimeoutError] if the service does not stop within the timeout
        def stop_service_sync(name, config: nil)
          stop_and_poll(name, SERVICE_CONFIG, config)
        end

        # Restart a service (stop then start) and wait for RUNNING status.
        #
        # @param name [String] the service name
        # @param config [SyncConfig, nil] polling configuration
        # @return [SyncResult] the combined operation result
        # @raise [TimeoutError] if the service does not reach the target state
        def restart_service(name, config: nil)
          do_restart(name, SERVICE_CONFIG, config)
        end

        private

        def start_and_poll(name, obj_config, config)
          sync_config = config || SyncConfig.new
          mqsc_command(
            command: 'START', mqsc_qualifier: obj_config.start_qualifier,
            name: name, request_parameters: nil, response_parameters: nil
          )
          polls = 0
          start_time = clock_now
          loop do
            sleep_interval(sync_config.poll_interval_seconds)
            status_rows = mqsc_command(
              command: 'DISPLAY', mqsc_qualifier: obj_config.status_qualifier,
              name: name, request_parameters: nil, response_parameters: ['all']
            )
            polls += 1
            if status?(status_rows, obj_config.status_keys, RUNNING_VALUES)
              elapsed = clock_now - start_time
              return SyncResult.new(operation: :started, polls: polls, elapsed_seconds: elapsed)
            end
            elapsed = clock_now - start_time
            next unless elapsed >= sync_config.timeout_seconds

            raise TimeoutError.new(
              "#{obj_config.start_qualifier} '#{name}' did not reach RUNNING within #{sync_config.timeout_seconds}s",
              name: name, operation: 'start', elapsed: elapsed
            )
          end
        end

        def stop_and_poll(name, obj_config, config)
          sync_config = config || SyncConfig.new
          mqsc_command(
            command: 'STOP', mqsc_qualifier: obj_config.stop_qualifier,
            name: name, request_parameters: nil, response_parameters: nil
          )
          polls = 0
          start_time = clock_now
          loop do
            sleep_interval(sync_config.poll_interval_seconds)
            status_rows = mqsc_command(
              command: 'DISPLAY', mqsc_qualifier: obj_config.status_qualifier,
              name: name, request_parameters: nil, response_parameters: ['all']
            )
            polls += 1
            if obj_config.empty_means_stopped && status_rows.empty?
              elapsed = clock_now - start_time
              return SyncResult.new(operation: :stopped, polls: polls, elapsed_seconds: elapsed)
            end
            if status?(status_rows, obj_config.status_keys, STOPPED_VALUES)
              elapsed = clock_now - start_time
              return SyncResult.new(operation: :stopped, polls: polls, elapsed_seconds: elapsed)
            end
            elapsed = clock_now - start_time
            next unless elapsed >= sync_config.timeout_seconds

            raise TimeoutError.new(
              "#{obj_config.stop_qualifier} '#{name}' did not reach STOPPED within #{sync_config.timeout_seconds}s",
              name: name, operation: 'stop', elapsed: elapsed
            )
          end
        end

        def do_restart(name, obj_config, config)
          stop_result = stop_and_poll(name, obj_config, config)
          start_result = start_and_poll(name, obj_config, config)
          SyncResult.new(
            operation: :restarted,
            polls: stop_result.polls + start_result.polls,
            elapsed_seconds: stop_result.elapsed_seconds + start_result.elapsed_seconds
          )
        end

        def status?(rows, status_keys, target_values)
          rows.any? do |row|
            status_keys.any? do |key|
              value = row[key]
              value.is_a?(String) && target_values.include?(value)
            end
          end
        end

        # Overridable for testing
        def clock_now
          Process.clock_gettime(Process::CLOCK_MONOTONIC)
        end

        # Overridable for testing
        def sleep_interval(seconds)
          sleep(seconds)
        end
      end
    end
  end
end
