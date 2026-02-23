# frozen_string_literal: true

module MQ
  module REST
    module Admin
      # Single mapping issue recorded during attribute translation.
      MappingIssue = Data.define(:direction, :reason, :attribute_name, :attribute_value, :object_index, :qualifier) do
        def initialize(direction:, reason:, attribute_name:, attribute_value: nil, object_index: nil, qualifier: nil)
          super
        end

        def to_payload
          {
            'direction' => direction,
            'reason' => reason,
            'attribute_name' => attribute_name,
            'attribute_value' => serialize_value(attribute_value),
            'object_index' => object_index,
            'qualifier' => qualifier
          }
        end

        private

        def serialize_value(value)
          case value
          when nil then nil
          when String, Integer, Float, true, false then value
          when Array then value.map { |v| serialize_value(v) }
          when Hash then value.transform_values { |v| serialize_value(v) }
          else value.inspect
          end
        end
      end

      module Mapping
        module_function

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
            if direction == 'request'
              kvm_for_key = key_value_map[attr_name]
              if kvm_for_key && !kvm_for_key.empty?
                if attr_value.is_a?(String)
                  mapping = kvm_for_key[attr_value]
                  if mapping && mapping['key'] && mapping['value']
                    mapped[mapping['key']] = mapping['value']
                    next
                  end
                end
                issues << MappingIssue.new(
                  direction: direction, reason: 'unknown_value',
                  attribute_name: attr_name, attribute_value: attr_value,
                  object_index: object_index, qualifier: qualifier
                )
                mapped[attr_name] = attr_value
                next
              end
            end

            mapped_key = key_map[attr_name]
            if mapped_key.nil?
              issues << MappingIssue.new(
                direction: direction, reason: 'unknown_key',
                attribute_name: attr_name, attribute_value: attr_value,
                object_index: object_index, qualifier: qualifier
              )
              mapped[attr_name] = attr_value
              next
            end

            mapped_value, value_issues = map_value(
              qualifier: qualifier, attribute_name: attr_name,
              attribute_value: attr_value, value_map: value_map,
              direction: direction, object_index: object_index
            )
            mapped[mapped_key] = mapped_value
            issues.concat(value_issues)
          end

          [mapped, issues]
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
                             :map_attributes, :map_attributes_internal, :map_value, :map_value_list
      end
    end
  end
end
