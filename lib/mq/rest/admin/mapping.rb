# frozen_string_literal: true

module MQ
  module REST
    module Admin
      # Single mapping issue recorded during attribute translation.
      #
      # Each issue captures the direction, reason, and context for an
      # attribute that could not be mapped between snake_case and MQSC formats.
      #
      # @!attribute [r] direction
      #   @return [String] +"request"+ or +"response"+
      # @!attribute [r] reason
      #   @return [String] the reason for the mapping failure (e.g. +"unknown_key"+)
      # @!attribute [r] attribute_name
      #   @return [String] the attribute name that failed mapping
      # @!attribute [r] attribute_value
      #   @return [Object, nil] the attribute value, if relevant
      # @!attribute [r] object_index
      #   @return [Integer, nil] the index within a collection response
      # @!attribute [r] qualifier
      #   @return [String, nil] the MQSC qualifier involved
      MappingIssue = Data.define(:direction, :reason, :attribute_name, :attribute_value, :object_index, :qualifier) do
        # @param direction [String] +"request"+ or +"response"+
        # @param reason [String] the failure reason
        # @param attribute_name [String] the attribute name
        # @param attribute_value [Object, nil] the attribute value
        # @param object_index [Integer, nil] index within a collection
        # @param qualifier [String, nil] the MQSC qualifier
        def initialize(direction:, reason:, attribute_name:, attribute_value: nil, object_index: nil, qualifier: nil)
          super
        end

        # Serialize this issue to a hash suitable for JSON output.
        #
        # @return [Hash{String => Object}] the serialized issue
        def to_payload # steep:ignore UndeclaredMethodDefinition
          {
            'direction' => direction, # steep:ignore NoMethod
            'reason' => reason, # steep:ignore NoMethod
            'attribute_name' => attribute_name, # steep:ignore NoMethod
            'attribute_value' => serialize_value(attribute_value), # steep:ignore NoMethod
            'object_index' => object_index, # steep:ignore NoMethod
            'qualifier' => qualifier # steep:ignore NoMethod
          }
        end

        private

        def serialize_value(value) # steep:ignore UndeclaredMethodDefinition
          case value
          when nil then nil
          when String, Integer, Float, true, false then value
          when Array then value.map { |v| serialize_value(v) } # steep:ignore NoMethod
          when Hash then value.transform_values { |v| serialize_value(v) } # steep:ignore NoMethod
          else value.inspect
          end
        end
      end

      # Attribute mapping between snake_case Ruby names and MQSC attribute names.
      #
      # Provides bidirectional translation of request and response attributes
      # using the mapping data loaded from +mapping-data.json+.
      module Mapping
        module_function

        # Map snake_case request attributes to MQSC attribute names and values.
        #
        # @param qualifier [String] the mapping qualifier (e.g. +"queue"+)
        # @param attributes [Hash{String => Object}] snake_case request attributes
        # @param strict [Boolean] raise {MappingError} on unknown attributes
        # @param mapping_data [Hash{String => Object}, nil] custom mapping data
        # @return [Hash{String => Object}] mapped MQSC attributes
        # @raise [MappingError] if strict mode is enabled and mapping issues occur
        def map_request_attributes(qualifier, attributes, strict: true, mapping_data: nil)
          qualifier_data = get_qualifier_data(qualifier, mapping_data: mapping_data)
          if qualifier_data.nil?
            return handle_unknown_qualifier(qualifier, attributes, direction: 'request', strict: strict)
          end

          map_attributes(
            qualifier: qualifier,
            attributes: attributes,
            key_map: get_key_map(qualifier_data, 'request_key_map'),
            key_value_map: get_key_value_map(qualifier_data, 'request_key_value_map'),
            value_map: get_value_map(qualifier_data, 'request_value_map'),
            direction: 'request',
            strict: strict
          )
        end

        # Map MQSC response attributes to snake_case Ruby names and values.
        #
        # @param qualifier [String] the mapping qualifier (e.g. +"queue"+)
        # @param attributes [Hash{String => Object}] MQSC response attributes
        # @param strict [Boolean] raise {MappingError} on unknown attributes
        # @param mapping_data [Hash{String => Object}, nil] custom mapping data
        # @return [Hash{String => Object}] mapped snake_case attributes
        # @raise [MappingError] if strict mode is enabled and mapping issues occur
        def map_response_attributes(qualifier, attributes, strict: true, mapping_data: nil)
          qualifier_data = get_qualifier_data(qualifier, mapping_data: mapping_data)
          if qualifier_data.nil?
            return handle_unknown_qualifier(qualifier, attributes, direction: 'response', strict: strict)
          end

          map_attributes(
            qualifier: qualifier,
            attributes: attributes,
            key_map: get_key_map(qualifier_data, 'response_key_map'),
            key_value_map: {},
            value_map: get_value_map(qualifier_data, 'response_value_map'),
            direction: 'response',
            strict: strict
          )
        end

        # Map an array of MQSC response objects to snake_case.
        #
        # @param qualifier [String] the mapping qualifier
        # @param objects [Array<Hash{String => Object}>] MQSC response objects
        # @param strict [Boolean] raise {MappingError} on unknown attributes
        # @param mapping_data [Hash{String => Object}, nil] custom mapping data
        # @return [Array<Hash{String => Object}>] mapped snake_case objects
        # @raise [MappingError] if strict mode is enabled and mapping issues occur
        def map_response_list(qualifier, objects, strict: true, mapping_data: nil)
          qualifier_data = get_qualifier_data(qualifier, mapping_data: mapping_data)
          if qualifier_data.nil?
            return handle_unknown_qualifier_list(qualifier, objects, direction: 'response', strict: strict)
          end

          key_map = get_key_map(qualifier_data, 'response_key_map')
          value_map = get_value_map(qualifier_data, 'response_value_map')
          mapped_objects = []
          issues = []

          objects.each_with_index do |attributes, object_index|
            mapped, attr_issues = map_attributes_internal(
              qualifier: qualifier,
              attributes: attributes,
              key_map: key_map,
              key_value_map: {},
              value_map: value_map,
              direction: 'response',
              object_index: object_index
            )
            mapped_objects << mapped
            issues.concat(attr_issues)
          end

          raise MappingError, issues if strict && !issues.empty?

          mapped_objects
        end

        # --- Private helpers ---

        def get_qualifier_data(qualifier, mapping_data: nil)
          data = mapping_data || MAPPING_DATA
          qualifiers = data['qualifiers']
          return nil unless qualifiers.is_a?(Hash)

          qualifiers[qualifier]
        end

        def get_key_map(qualifier_data, map_name)
          key_map = qualifier_data[map_name]
          key_map.is_a?(Hash) ? key_map : {}
        end

        def get_value_map(qualifier_data, map_name)
          value_map = qualifier_data[map_name]
          value_map.is_a?(Hash) ? value_map : {}
        end

        def get_key_value_map(qualifier_data, map_name)
          kvm = qualifier_data[map_name]
          kvm.is_a?(Hash) ? kvm : {}
        end

        def handle_unknown_qualifier(qualifier, attributes, direction:, strict:)
          return attributes.to_h unless strict

          issues = [
            MappingIssue.new(
              direction: direction, reason: 'unknown_qualifier',
              attribute_name: '*', qualifier: qualifier
            )
          ]
          raise MappingError, issues
        end

        def handle_unknown_qualifier_list(qualifier, objects, direction:, strict:)
          return objects.map(&:to_h) unless strict

          issues = [
            MappingIssue.new(
              direction: direction, reason: 'unknown_qualifier',
              attribute_name: '*', qualifier: qualifier
            )
          ]
          raise MappingError, issues
        end

        def map_attributes(qualifier:, attributes:, key_map:, key_value_map:, value_map:, direction:, strict:)
          mapped, issues = map_attributes_internal(
            qualifier: qualifier, attributes: attributes,
            key_map: key_map, key_value_map: key_value_map,
            value_map: value_map, direction: direction, object_index: nil
          )
          raise MappingError, issues if strict && !issues.empty?

          mapped
        end

        def map_attributes_internal(qualifier:, attributes:, key_map:, key_value_map:, value_map:, direction:,
                                    object_index:)
          mapped = {}
          issues = []

          attributes.each do |attr_name, attr_value|
            kvm_result = map_key_value_attribute(
              attr_name, attr_value, key_value_map,
              direction: direction, object_index: object_index, qualifier: qualifier
            )
            if kvm_result
              mapped[kvm_result[0]] = kvm_result[1]
              issues << kvm_result[2] if kvm_result[2]
              next
            end
            map_single_attribute(
              attr_name, attr_value, mapped, issues,
              key_map: key_map, value_map: value_map,
              qualifier: qualifier, direction: direction, object_index: object_index
            )
          end

          [mapped, issues]
        end

        def map_key_value_attribute(attr_name, attr_value, key_value_map, direction:, object_index:, qualifier:)
          return nil unless direction == 'request'

          kvm_for_key = key_value_map[attr_name]
          return nil unless kvm_for_key && !kvm_for_key.empty?

          if attr_value.is_a?(String)
            mapping = kvm_for_key[attr_value]
            return [mapping['key'], mapping['value'], nil] if mapping && mapping['key'] && mapping['value']
          end

          issue = MappingIssue.new(
            direction: direction, reason: 'unknown_value',
            attribute_name: attr_name, attribute_value: attr_value,
            object_index: object_index, qualifier: qualifier
          )
          [attr_name, attr_value, issue]
        end

        def map_single_attribute(attr_name, attr_value, mapped, issues, key_map:, value_map:, qualifier:,
                                 direction:, object_index:)
          mapped_key = key_map[attr_name]
          if mapped_key.nil?
            issues << MappingIssue.new(
              direction: direction, reason: 'unknown_key',
              attribute_name: attr_name, attribute_value: attr_value,
              object_index: object_index, qualifier: qualifier
            )
            mapped[attr_name] = attr_value
            return
          end
          mapped_value, value_issues = map_value(
            qualifier: qualifier, attribute_name: attr_name,
            attribute_value: attr_value, value_map: value_map,
            direction: direction, object_index: object_index
          )
          mapped[mapped_key] = mapped_value
          issues.concat(value_issues)
        end

        def map_value(qualifier:, attribute_name:, attribute_value:, value_map:, direction:, object_index:)
          value_mappings = value_map[attribute_name]
          return [attribute_value, []] unless value_mappings && !value_mappings.empty?

          if attribute_value.is_a?(String)
            mapped = value_mappings[attribute_value]
            if mapped.nil?
              return [
                attribute_value,
                [MappingIssue.new(
                  direction: direction, reason: 'unknown_value',
                  attribute_name: attribute_name, attribute_value: attribute_value,
                  object_index: object_index, qualifier: qualifier
                )]
              ]
            end
            return [mapped, []]
          end

          if attribute_value.is_a?(Array)
            return map_value_list(
              qualifier: qualifier, attribute_name: attribute_name,
              attribute_values: attribute_value, value_mappings: value_mappings,
              direction: direction, object_index: object_index
            )
          end

          [attribute_value, []]
        end

        def map_value_list(qualifier:, attribute_name:, attribute_values:, value_mappings:, direction:, object_index:)
          mapped_values = []
          issues = []

          attribute_values.each do |val|
            if val.is_a?(String)
              mapped = value_mappings[val]
              if mapped.nil?
                issues << MappingIssue.new(
                  direction: direction, reason: 'unknown_value',
                  attribute_name: attribute_name, attribute_value: val,
                  object_index: object_index, qualifier: qualifier
                )
                mapped_values << val
              else
                mapped_values << mapped
              end
            else
              mapped_values << val
            end
          end

          [mapped_values, issues]
        end

        private_class_method :get_qualifier_data, :get_key_map, :get_value_map, :get_key_value_map,
                             :handle_unknown_qualifier, :handle_unknown_qualifier_list,
                             :map_attributes, :map_attributes_internal,
                             :map_key_value_attribute, :map_single_attribute,
                             :map_value, :map_value_list
      end
    end
  end
end
