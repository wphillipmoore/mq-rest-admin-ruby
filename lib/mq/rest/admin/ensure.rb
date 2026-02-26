# frozen_string_literal: true

module MQ
  module REST
    module Admin
      # Result of an idempotent ensure operation.
      #
      # @!attribute [r] action
      #   @return [Symbol] +:unchanged+, +:created+, or +:updated+
      # @!attribute [r] changed
      #   @return [Array<String>] attribute names that were changed (empty if unchanged/created)
      EnsureResult = Data.define(:action, :changed) do
        # @param action [Symbol] the action taken
        # @param changed [Array<String>] changed attribute names
        def initialize(action:, changed: [])
          super(action: action, changed: changed.freeze)
        end
      end

      # Idempotent object configuration methods.
      #
      # Each +ensure_*+ method checks the current state of an MQ object and
      # creates, updates, or leaves it unchanged to match the desired state.
      # Included by {Session}.
      module Ensure
        # Ensure the queue manager attributes match the desired state.
        #
        # @param request_parameters [Hash{String => Object}, nil] desired attributes
        # @return [EnsureResult] the action taken and any changed attributes
        # @raise [CommandError] if the MQSC command fails
        def ensure_qmgr(request_parameters: nil)
          params = request_parameters ? request_parameters.to_h : {}
          return EnsureResult.new(action: :unchanged) if params.empty?

          current_objects = mqsc_command(
            command: 'DISPLAY', mqsc_qualifier: 'QMGR',
            name: nil, request_parameters: nil, response_parameters: ['all']
          )

          current = current_objects.first || {}
          changed = {}
          params.each do |key, desired|
            current_value = current[key]
            changed[key] = desired unless values_match?(desired, current_value)
          end

          return EnsureResult.new(action: :unchanged) if changed.empty?

          mqsc_command(
            command: 'ALTER', mqsc_qualifier: 'QMGR',
            name: nil, request_parameters: changed, response_parameters: nil
          )
          EnsureResult.new(action: :updated, changed: changed.keys)
        end

        # Ensure a local queue exists with the desired attributes.
        #
        # @param name [String] the queue name
        # @param request_parameters [Hash{String => Object}, nil] desired attributes
        # @return [EnsureResult] the action taken
        # @raise [CommandError] if the MQSC command fails
        def ensure_qlocal(name, request_parameters: nil)
          ensure_object(
            name: name, request_parameters: request_parameters,
            display_qualifier: 'QUEUE', define_qualifier: 'QLOCAL', alter_qualifier: 'QLOCAL'
          )
        end

        # Ensure a remote queue exists with the desired attributes.
        #
        # @param name [String] the queue name
        # @param request_parameters [Hash{String => Object}, nil] desired attributes
        # @return [EnsureResult] the action taken
        # @raise [CommandError] if the MQSC command fails
        def ensure_qremote(name, request_parameters: nil)
          ensure_object(
            name: name, request_parameters: request_parameters,
            display_qualifier: 'QUEUE', define_qualifier: 'QREMOTE', alter_qualifier: 'QREMOTE'
          )
        end

        # Ensure an alias queue exists with the desired attributes.
        #
        # @param name [String] the queue name
        # @param request_parameters [Hash{String => Object}, nil] desired attributes
        # @return [EnsureResult] the action taken
        # @raise [CommandError] if the MQSC command fails
        def ensure_qalias(name, request_parameters: nil)
          ensure_object(
            name: name, request_parameters: request_parameters,
            display_qualifier: 'QUEUE', define_qualifier: 'QALIAS', alter_qualifier: 'QALIAS'
          )
        end

        # Ensure a model queue exists with the desired attributes.
        #
        # @param name [String] the queue name
        # @param request_parameters [Hash{String => Object}, nil] desired attributes
        # @return [EnsureResult] the action taken
        # @raise [CommandError] if the MQSC command fails
        def ensure_qmodel(name, request_parameters: nil)
          ensure_object(
            name: name, request_parameters: request_parameters,
            display_qualifier: 'QUEUE', define_qualifier: 'QMODEL', alter_qualifier: 'QMODEL'
          )
        end

        # Ensure a channel exists with the desired attributes.
        #
        # @param name [String] the channel name
        # @param request_parameters [Hash{String => Object}, nil] desired attributes
        # @return [EnsureResult] the action taken
        # @raise [CommandError] if the MQSC command fails
        def ensure_channel(name, request_parameters: nil)
          ensure_object(
            name: name, request_parameters: request_parameters,
            display_qualifier: 'CHANNEL', define_qualifier: 'CHANNEL', alter_qualifier: 'CHANNEL'
          )
        end

        # Ensure an authentication information object exists with the desired attributes.
        #
        # @param name [String] the authinfo name
        # @param request_parameters [Hash{String => Object}, nil] desired attributes
        # @return [EnsureResult] the action taken
        # @raise [CommandError] if the MQSC command fails
        def ensure_authinfo(name, request_parameters: nil)
          ensure_object(
            name: name, request_parameters: request_parameters,
            display_qualifier: 'AUTHINFO', define_qualifier: 'AUTHINFO', alter_qualifier: 'AUTHINFO'
          )
        end

        # Ensure a listener exists with the desired attributes.
        #
        # @param name [String] the listener name
        # @param request_parameters [Hash{String => Object}, nil] desired attributes
        # @return [EnsureResult] the action taken
        # @raise [CommandError] if the MQSC command fails
        def ensure_listener(name, request_parameters: nil)
          ensure_object(
            name: name, request_parameters: request_parameters,
            display_qualifier: 'LISTENER', define_qualifier: 'LISTENER', alter_qualifier: 'LISTENER'
          )
        end

        # Ensure a namelist exists with the desired attributes.
        #
        # @param name [String] the namelist name
        # @param request_parameters [Hash{String => Object}, nil] desired attributes
        # @return [EnsureResult] the action taken
        # @raise [CommandError] if the MQSC command fails
        def ensure_namelist(name, request_parameters: nil)
          ensure_object(
            name: name, request_parameters: request_parameters,
            display_qualifier: 'NAMELIST', define_qualifier: 'NAMELIST', alter_qualifier: 'NAMELIST'
          )
        end

        # Ensure a process exists with the desired attributes.
        #
        # @param name [String] the process name
        # @param request_parameters [Hash{String => Object}, nil] desired attributes
        # @return [EnsureResult] the action taken
        # @raise [CommandError] if the MQSC command fails
        def ensure_process(name, request_parameters: nil)
          ensure_object(
            name: name, request_parameters: request_parameters,
            display_qualifier: 'PROCESS', define_qualifier: 'PROCESS', alter_qualifier: 'PROCESS'
          )
        end

        # Ensure a service exists with the desired attributes.
        #
        # @param name [String] the service name
        # @param request_parameters [Hash{String => Object}, nil] desired attributes
        # @return [EnsureResult] the action taken
        # @raise [CommandError] if the MQSC command fails
        def ensure_service(name, request_parameters: nil)
          ensure_object(
            name: name, request_parameters: request_parameters,
            display_qualifier: 'SERVICE', define_qualifier: 'SERVICE', alter_qualifier: 'SERVICE'
          )
        end

        # Ensure a topic exists with the desired attributes.
        #
        # @param name [String] the topic name
        # @param request_parameters [Hash{String => Object}, nil] desired attributes
        # @return [EnsureResult] the action taken
        # @raise [CommandError] if the MQSC command fails
        def ensure_topic(name, request_parameters: nil)
          ensure_object(
            name: name, request_parameters: request_parameters,
            display_qualifier: 'TOPIC', define_qualifier: 'TOPIC', alter_qualifier: 'TOPIC'
          )
        end

        # Ensure a subscription exists with the desired attributes.
        #
        # @param name [String] the subscription name
        # @param request_parameters [Hash{String => Object}, nil] desired attributes
        # @return [EnsureResult] the action taken
        # @raise [CommandError] if the MQSC command fails
        def ensure_sub(name, request_parameters: nil)
          ensure_object(
            name: name, request_parameters: request_parameters,
            display_qualifier: 'SUB', define_qualifier: 'SUB', alter_qualifier: 'SUB'
          )
        end

        # Ensure a storage class exists with the desired attributes.
        #
        # @param name [String] the storage class name
        # @param request_parameters [Hash{String => Object}, nil] desired attributes
        # @return [EnsureResult] the action taken
        # @raise [CommandError] if the MQSC command fails
        def ensure_stgclass(name, request_parameters: nil)
          ensure_object(
            name: name, request_parameters: request_parameters,
            display_qualifier: 'STGCLASS', define_qualifier: 'STGCLASS', alter_qualifier: 'STGCLASS'
          )
        end

        # Ensure a communication information object exists with the desired attributes.
        #
        # @param name [String] the comminfo name
        # @param request_parameters [Hash{String => Object}, nil] desired attributes
        # @return [EnsureResult] the action taken
        # @raise [CommandError] if the MQSC command fails
        def ensure_comminfo(name, request_parameters: nil)
          ensure_object(
            name: name, request_parameters: request_parameters,
            display_qualifier: 'COMMINFO', define_qualifier: 'COMMINFO', alter_qualifier: 'COMMINFO'
          )
        end

        # Ensure a CF structure exists with the desired attributes.
        #
        # @param name [String] the CF structure name
        # @param request_parameters [Hash{String => Object}, nil] desired attributes
        # @return [EnsureResult] the action taken
        # @raise [CommandError] if the MQSC command fails
        def ensure_cfstruct(name, request_parameters: nil)
          ensure_object(
            name: name, request_parameters: request_parameters,
            display_qualifier: 'CFSTRUCT', define_qualifier: 'CFSTRUCT', alter_qualifier: 'CFSTRUCT'
          )
        end

        private

        def ensure_object(name:, request_parameters:, display_qualifier:, define_qualifier:, alter_qualifier:)
          current_objects = begin
            mqsc_command(
              command: 'DISPLAY', mqsc_qualifier: display_qualifier,
              name: name, request_parameters: nil, response_parameters: ['all']
            )
          rescue CommandError
            []
          end

          params = request_parameters ? request_parameters.to_h : {}

          if current_objects.empty?
            mqsc_command(
              command: 'DEFINE', mqsc_qualifier: define_qualifier,
              name: name, request_parameters: params.empty? ? nil : params,
              response_parameters: nil
            )
            return EnsureResult.new(action: :created)
          end

          return EnsureResult.new(action: :unchanged) if params.empty?

          current = current_objects.first
          changed = {}
          params.each do |key, desired|
            current_value = current[key]
            changed[key] = desired unless values_match?(desired, current_value)
          end

          return EnsureResult.new(action: :unchanged) if changed.empty?

          mqsc_command(
            command: 'ALTER', mqsc_qualifier: alter_qualifier,
            name: name, request_parameters: changed, response_parameters: nil
          )
          EnsureResult.new(action: :updated, changed: changed.keys)
        end

        def values_match?(desired, current)
          return false if current.nil?

          desired.to_s.strip.upcase == current.to_s.strip.upcase
        end
      end
    end
  end
end
