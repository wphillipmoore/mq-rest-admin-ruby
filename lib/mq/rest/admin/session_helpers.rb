# frozen_string_literal: true

require 'base64'
require 'json'

module MQ
  module REST
    module Admin
      # Pure-function helpers extracted from {Session} to reduce class length.
      #
      # All methods are private instance methods that do not depend on Session
      # instance state — they operate only on their arguments and return values.
      # Included by {Session}.
      module SessionHelpers
        private

        def build_basic_auth_header(username, password)
          token = Base64.strict_encode64("#{username}:#{password}")
          "Basic #{token}"
        end

        def normalize_response_parameters(response_parameters, is_display: true)
          if response_parameters.nil?
            return is_display ? DEFAULT_RESPONSE_PARAMETERS.dup : []
          end

          params = response_parameters.to_a
          return DEFAULT_RESPONSE_PARAMETERS.dup if all_response_parameters?(params)

          params
        end

        def all_response_parameters?(response_parameters)
          response_parameters.any? { |p| p.downcase == 'all' }
        end

        def parse_response_payload(response_text)
          decoded = JSON.parse(response_text)
          unless decoded.is_a?(Hash)
            raise ResponseError.new('Response payload was not a JSON object.', response_text: response_text)
          end

          decoded
        rescue JSON::ParserError
          raise ResponseError.new('Response body was not valid JSON.', response_text: response_text)
        end

        def extract_command_response(payload)
          command_response = payload['commandResponse']
          return [] if command_response.nil?

          raise ResponseError, 'Response commandResponse was not a list.' unless command_response.is_a?(Array)

          command_response.each do |item|
            raise ResponseError, 'Response commandResponse item was not an object.' unless item.is_a?(Hash)
          end
          command_response
        end

        def extract_optional_int(value)
          value.is_a?(Integer) ? value : nil
        end

        def error_codes?(completion_code, reason_code)
          (completion_code && completion_code != 0) || (reason_code && reason_code != 0)
        end

        def flatten_nested_objects(parameter_objects)
          flattened = []
          parameter_objects.each do |item|
            objects = item['objects']
            if objects.is_a?(Array)
              shared = item.except('objects')
              objects.each do |nested|
                flattened << shared.merge(nested) if nested.is_a?(Hash)
              end
            else
              flattened << item
            end
          end
          flattened
        end

        def normalize_response_attributes(attributes)
          attributes.transform_keys(&:upcase)
        end

        def build_command_payload(command:, qualifier:, name:, request_parameters:, response_parameters:)
          payload = {
            'type' => 'runCommandJSON',
            'command' => command,
            'qualifier' => qualifier
          }
          payload['name'] = name if name && !name.empty?
          payload['parameters'] = request_parameters unless request_parameters.empty?
          payload['responseParameters'] = response_parameters unless response_parameters.empty?
          payload
        end

        def get_command_map(mapping_data)
          commands = mapping_data['commands']
          commands.is_a?(Hash) ? commands : {}
        end

        def get_response_parameter_macros(command, mqsc_qualifier, mapping_data:)
          command_key = "#{command} #{mqsc_qualifier}"
          commands = get_command_map(mapping_data)
          entry = commands[command_key]
          return [] unless entry.is_a?(Hash)

          macros = entry['response_parameter_macros']
          return [] unless macros.is_a?(Array)

          macros.grep(String)
        end

        def build_unknown_qualifier_issue(qualifier)
          [MappingIssue.new(direction: 'request', reason: 'unknown_qualifier', attribute_name: '*',
                            qualifier: qualifier)]
        end

        def map_response_parameter_names(response_parameters, macro_lookup, combined_map, mapping_qualifier)
          mapped = []
          issues = []
          response_parameters.each do |name|
            macro_key = macro_lookup[name.downcase]
            if macro_key
              mapped << macro_key
              next
            end
            mapped_key = combined_map[name]
            if mapped_key.nil?
              issues << MappingIssue.new(
                direction: 'request', reason: 'unknown_key',
                attribute_name: name, qualifier: mapping_qualifier
              )
              mapped << name
              next
            end
            mapped << mapped_key
          end
          [mapped, issues]
        end

        def get_qualifier_entry(qualifier, mapping_data:)
          qualifiers = mapping_data['qualifiers']
          return nil unless qualifiers.is_a?(Hash)

          qualifiers[qualifier]
        end
      end
    end
  end
end
