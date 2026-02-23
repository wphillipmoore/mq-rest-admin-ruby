# frozen_string_literal: true

require 'base64'
require 'json'

module MQ
  module REST
    module Admin
      DEFAULT_RESPONSE_PARAMETERS = ['all'].freeze
      DEFAULT_CSRF_TOKEN = 'local'
      GATEWAY_HEADER = 'ibm-mq-rest-gateway-qmgr'

      DEFAULT_MAPPING_QUALIFIERS = {
        'QUEUE' => 'queue',
        'QLOCAL' => 'queue',
        'QREMOTE' => 'queue',
        'QALIAS' => 'queue',
        'QMODEL' => 'queue',
        'QMSTATUS' => 'qmstatus',
        'QSTATUS' => 'qstatus',
        'CHANNEL' => 'channel',
        'QMGR' => 'qmgr'
      }.freeze

      class Session
        include Commands
        include Ensure
        include Sync

        attr_reader :qmgr_name, :gateway_qmgr
        attr_accessor :last_response_payload, :last_response_text, :last_http_status, :last_command_payload

        def initialize(
          rest_base_url,
          qmgr_name,
          credentials:,
          gateway_qmgr: nil,
          verify_tls: true,
          timeout_seconds: 30.0,
          map_attributes: true,
          mapping_strict: true,
          mapping_overrides: nil,
          mapping_overrides_mode: MAPPING_OVERRIDE_MERGE,
          csrf_token: DEFAULT_CSRF_TOKEN,
          transport: nil
        )
          @rest_base_url = rest_base_url.chomp('/')
          @qmgr_name = qmgr_name
          @gateway_qmgr = gateway_qmgr
          @verify_tls = verify_tls
          @timeout_seconds = timeout_seconds
          @map_attributes = map_attributes
          @mapping_strict = mapping_strict
          @csrf_token = csrf_token
          @credentials = credentials

          @mapping_data = resolve_mapping_data(mapping_overrides, mapping_overrides_mode)
          @transport = resolve_transport(credentials, transport)

          @ltpa_token = nil
          if credentials.is_a?(LTPAAuth)
            @ltpa_token = Admin.perform_ltpa_login(
              @transport, @rest_base_url, credentials,
              csrf_token: @csrf_token,
              timeout_seconds: @timeout_seconds,
              verify_tls: @verify_tls
            )
          end

          @last_response_payload = nil
          @last_response_text = nil
          @last_http_status = nil
          @last_command_payload = nil
        end

        private

        def mqsc_command(command:, mqsc_qualifier:, name:, request_parameters:, response_parameters:, where: nil)
          command_upper = command.strip.upcase
          qualifier_upper = mqsc_qualifier.strip.upcase
          norm_request = request_parameters ? request_parameters.to_h : {}
          norm_response = normalize_response_parameters(response_parameters, is_display: command_upper == 'DISPLAY')
          do_map = @map_attributes
          mapping_qualifier = resolve_mapping_qualifier(command_upper, qualifier_upper)

          if do_map
            norm_request = Mapping.map_request_attributes(
              mapping_qualifier, norm_request,
              strict: @mapping_strict, mapping_data: @mapping_data
            )
            norm_response = map_response_parameters(
              command_upper, qualifier_upper, mapping_qualifier, norm_response
            )
          end

          if where && !where.strip.empty?
            mapped_where = where
            if do_map
              mapped_where = map_where_keyword(
                where, mapping_qualifier,
                strict: @mapping_strict, mapping_data: @mapping_data
              )
            end
            norm_request['WHERE'] = mapped_where
          end

          payload = build_command_payload(
            command: command_upper, qualifier: qualifier_upper,
            name: name, request_parameters: norm_request,
            response_parameters: norm_response
          )
          @last_command_payload = payload.dup

          transport_response = @transport.post_json(
            build_mqsc_url, payload,
            headers: build_headers,
            timeout_seconds: @timeout_seconds,
            verify_tls: @verify_tls
          )
          @last_http_status = transport_response.status_code
          @last_response_text = transport_response.body

          response_payload = parse_response_payload(transport_response.body)
          @last_response_payload = response_payload
          raise_for_command_errors(response_payload, transport_response.status_code)

          command_response = extract_command_response(response_payload)
          parameter_objects = command_response.map do |item|
            params = item['parameters']
            params.is_a?(Hash) ? params.dup : {}
          end

          parameter_objects = flatten_nested_objects(parameter_objects)

          if do_map
            normalized = parameter_objects.map { |item| normalize_response_attributes(item) }
            return Mapping.map_response_list(
              mapping_qualifier, normalized,
              strict: @mapping_strict, mapping_data: @mapping_data
            )
          end

          parameter_objects
        end

        def build_mqsc_url
          "#{@rest_base_url}/admin/action/qmgr/#{@qmgr_name}/mqsc"
        end

        def build_headers
          headers = { 'Accept' => 'application/json' }
          if @credentials.is_a?(BasicAuth)
            headers['Authorization'] = build_basic_auth_header(
              @credentials.username, @credentials.password
            )
          elsif @credentials.is_a?(LTPAAuth) && @ltpa_token
            headers['Cookie'] = "#{LTPA_COOKIE_NAME}=#{@ltpa_token}"
          end
          headers['ibm-mq-rest-csrf-token'] = @csrf_token unless @csrf_token.nil?
          headers[GATEWAY_HEADER] = @gateway_qmgr unless @gateway_qmgr.nil?
          headers
        end

        def build_basic_auth_header(username, password)
          token = Base64.strict_encode64("#{username}:#{password}")
          "Basic #{token}"
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

        def raise_for_command_errors(payload, status_code)
          overall_cc = extract_optional_int(payload['overallCompletionCode'])
          overall_rc = extract_optional_int(payload['overallReasonCode'])
          has_overall = has_error_codes?(overall_cc, overall_rc)

          command_issues = []
          command_response = payload['commandResponse']
          if command_response.is_a?(Array)
            command_response.each_with_index do |item, idx|
              next unless item.is_a?(Hash)

              cc = extract_optional_int(item['completionCode'])
              rc = extract_optional_int(item['reasonCode'])
              next unless has_error_codes?(cc, rc)

              command_issues << "index=#{idx} completionCode=#{cc} reasonCode=#{rc}"
            end
          end

          return unless has_overall || !command_issues.empty?

          lines = ['MQ REST command failed.']
          lines << "overallCompletionCode=#{overall_cc} overallReasonCode=#{overall_rc}" if has_overall
          unless command_issues.empty?
            lines << 'commandResponse:'
            lines.concat(command_issues)
          end
          raise CommandError.new(
            lines.join("\n"),
            payload: payload, status_code: status_code
          )
        end

        def extract_optional_int(value)
          value.is_a?(Integer) ? value : nil
        end

        def has_error_codes?(completion_code, reason_code)
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

        def resolve_mapping_qualifier(command, mqsc_qualifier)
          command_map = get_command_map(@mapping_data)
          command_key = "#{command} #{mqsc_qualifier}"
          command_definition = command_map[command_key]
          if command_definition.is_a?(Hash)
            qualifier = command_definition['qualifier']
            return qualifier if qualifier.is_a?(String)
          end
          fallback = DEFAULT_MAPPING_QUALIFIERS[mqsc_qualifier]
          return fallback unless fallback.nil?

          mqsc_qualifier.downcase
        end

        def get_command_map(mapping_data)
          commands = mapping_data['commands']
          commands.is_a?(Hash) ? commands : {}
        end

        def map_response_parameters(command, mqsc_qualifier, mapping_qualifier, response_parameters)
          return response_parameters if all_response_parameters?(response_parameters)

          macros = get_response_parameter_macros(command, mqsc_qualifier, mapping_data: @mapping_data)
          macro_lookup = macros.each_with_object({}) { |m, h| h[m.downcase] = m }

          qualifier_entry = get_qualifier_entry(mapping_qualifier, mapping_data: @mapping_data)
          if qualifier_entry.nil?
            raise MappingError, build_unknown_qualifier_issue(mapping_qualifier) if @mapping_strict

            return response_parameters
          end

          combined_map = build_snake_to_mqsc_map(qualifier_entry)
          mapped, issues = map_response_parameter_names(
            response_parameters, macro_lookup, combined_map, mapping_qualifier
          )

          raise MappingError, issues if @mapping_strict && !issues.empty?

          mapped
        end

        def get_response_parameter_macros(command, mqsc_qualifier, mapping_data:)
          command_key = "#{command} #{mqsc_qualifier}"
          commands = get_command_map(mapping_data)
          entry = commands[command_key]
          return [] unless entry.is_a?(Hash)

          macros = entry['response_parameter_macros']
          return [] unless macros.is_a?(Array)

          macros.select { |m| m.is_a?(String) }
        end

        def build_unknown_qualifier_issue(qualifier)
          [MappingIssue.new(direction: 'request', reason: 'unknown_qualifier', attribute_name: '*',
                            qualifier: qualifier)]
        end

        def build_snake_to_mqsc_map(qualifier_entry)
          request_key_map = qualifier_entry['request_key_map'] || {}
          response_key_map = qualifier_entry['response_key_map'] || {}

          response_lookup = {}
          if response_key_map.is_a?(Hash)
            response_key_map.each do |mqsc_key, snake_key|
              next unless mqsc_key.is_a?(String) && snake_key.is_a?(String)

              response_lookup[snake_key] ||= mqsc_key
            end
          end

          combined = response_lookup.dup
          if request_key_map.is_a?(Hash)
            request_key_map.each do |key, value|
              next unless key.is_a?(String) && value.is_a?(String)

              combined[key] = value
            end
          end
          combined
        end

        def map_where_keyword(where, mapping_qualifier, strict:, mapping_data:)
          parts = where.strip.split(nil, 2)
          keyword = parts[0]
          rest = parts[1] || ''

          qualifier_entry = get_qualifier_entry(mapping_qualifier, mapping_data: mapping_data)
          if qualifier_entry.nil?
            raise MappingError, build_unknown_qualifier_issue(mapping_qualifier) if strict

            return where
          end

          combined_map = build_snake_to_mqsc_map(qualifier_entry)
          mapped_keyword = combined_map[keyword]

          if mapped_keyword.nil?
            if strict
              raise MappingError, [
                MappingIssue.new(
                  direction: 'request', reason: 'unknown_key',
                  attribute_name: keyword, qualifier: mapping_qualifier
                )
              ]
            end
            mapped_keyword = keyword
          end

          rest.empty? ? mapped_keyword : "#{mapped_keyword} #{rest}"
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

        def resolve_mapping_data(overrides, mode)
          if overrides
            MappingMerge.validate_mapping_overrides(overrides)
            if mode == MAPPING_OVERRIDE_REPLACE
              MappingMerge.validate_mapping_overrides_complete(MAPPING_DATA, overrides)
              return MappingMerge.replace_mapping_data(overrides)
            end
            return MappingMerge.merge_mapping_data(MAPPING_DATA, overrides)
          end
          MAPPING_DATA
        end

        def resolve_transport(credentials, transport)
          if credentials.is_a?(CertificateAuth) && transport.nil?
            return NetHTTPTransport.new(
              client_cert: credentials.cert_path,
              client_key: credentials.key_path
            )
          end
          transport || NetHTTPTransport.new
        end
      end
    end
  end
end
