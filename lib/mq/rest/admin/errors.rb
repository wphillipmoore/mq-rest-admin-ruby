# frozen_string_literal: true

module MQ
  module REST
    module Admin
      # Base error for all MQ REST session failures.
      #
      # All mq-rest-admin exceptions inherit from this class, so
      # +rescue MQ::REST::Admin::Error+ catches every error raised by the library.
      class Error < StandardError; end

      # Raised when the transport fails to reach the MQ REST endpoint.
      #
      # This typically indicates a network-level problem such as a connection
      # refusal, DNS failure, or TLS handshake error.
      class TransportError < Error
        # @return [String] the URL that could not be reached
        attr_reader :url

        # @param message [String] human-readable error description
        # @param url [String] the URL that could not be reached
        def initialize(message, url:)
          super(message)
          @url = url
        end
      end

      # Raised when the MQ REST response is malformed or unexpected.
      #
      # This indicates the server returned a response that could not be
      # parsed as valid JSON or did not conform to the expected
      # runCommandJSON response structure.
      class ResponseError < Error
        # @return [String, nil] the raw response body, if available
        attr_reader :response_text

        # @param message [String] human-readable error description
        # @param response_text [String, nil] the raw response body
        def initialize(message, response_text: nil)
          super(message)
          @response_text = response_text
        end
      end

      # Raised when authentication with the MQ REST API fails.
      #
      # This indicates the server rejected credentials or a required
      # authentication token could not be obtained.
      class AuthError < Error
        # @return [String] the authentication URL
        attr_reader :url

        # @return [Integer, nil] the HTTP status code, if available
        attr_reader :status_code

        # @param message [String] human-readable error description
        # @param url [String] the authentication URL
        # @param status_code [Integer, nil] the HTTP status code
        def initialize(message, url:, status_code: nil)
          super(message)
          @url = url
          @status_code = status_code
        end
      end

      # Raised when the MQ REST response indicates MQSC command failure.
      #
      # The server returned a valid JSON response, but the completion or
      # reason codes indicate the MQSC command did not succeed.
      class CommandError < Error
        # @return [Hash{String => Object}] the full response payload
        attr_reader :payload

        # @return [Integer, nil] the HTTP status code, if available
        attr_reader :status_code

        # @param message [String] human-readable error description
        # @param payload [Hash{String => Object}] the response payload
        # @param status_code [Integer, nil] the HTTP status code
        def initialize(message, payload:, status_code: nil)
          super(message)
          @payload = payload.to_h
          @status_code = status_code
        end
      end

      # Raised when a synchronous operation exceeds its timeout.
      #
      # This indicates that a start, stop, or restart operation did not
      # reach the expected state within the configured timeout period.
      class TimeoutError < Error
        # @return [String] the object name being operated on
        attr_reader :name

        # @return [String] the operation that timed out (e.g. +"start"+, +"stop"+)
        attr_reader :operation

        # @return [Float] the elapsed time in seconds before timeout
        attr_reader :elapsed

        # @param message [String] human-readable error description
        # @param name [String] the object name
        # @param operation [String] the operation that timed out
        # @param elapsed [Float] elapsed seconds before timeout
        def initialize(message, name:, operation:, elapsed:)
          super(message)
          @name = name
          @operation = operation
          @elapsed = elapsed
        end
      end

      # Raised when attribute mapping fails in strict mode.
      #
      # Contains one or more {MappingIssue} instances describing
      # exactly which attributes could not be mapped and why.
      class MappingError < Error
        # @return [Array<MappingIssue>] the mapping issues encountered
        attr_reader :issues

        # @param issues [Array<MappingIssue>] the mapping issues
        # @param message [String, nil] optional custom message
        def initialize(issues, message: nil)
          @issues = issues.freeze
          super(message || build_message)
        end

        # Serialize all issues to an array of hashes.
        #
        # @return [Array<Hash{String => Object}>] serialized issue payloads
        def to_payload
          @issues.map(&:to_payload)
        end

        private

        def build_message
          return 'Mapping failed with no issues reported.' if @issues.empty?

          issue_lines = @issues.map do |issue|
            index_label = issue.object_index.nil? ? '-' : issue.object_index.to_s
            qualifier_label = issue.qualifier || '-'
            value_label = issue.attribute_value.nil? ? '-' : issue.attribute_value.inspect
            [
              "index=#{index_label}",
              "qualifier=#{qualifier_label}",
              "direction=#{issue.direction}",
              "reason=#{issue.reason}",
              "attribute=#{issue.attribute_name}",
              "value=#{value_label}"
            ].join(' | ')
          end
          "Mapping failed with #{@issues.length} issue(s):\n#{issue_lines.join("\n")}"
        end
      end
    end
  end
end
