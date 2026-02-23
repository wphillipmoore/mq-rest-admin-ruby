# frozen_string_literal: true

require 'test_helper'

module MQ
  module REST
    module Admin
      class MappingIssueTest < Minitest::Test
        def test_mapping_issue_defaults
          issue = MappingIssue.new(direction: 'request', reason: 'unknown_key', attribute_name: 'foo')

          assert_equal 'request', issue.direction
          assert_equal 'unknown_key', issue.reason
          assert_equal 'foo', issue.attribute_name
          assert_nil issue.attribute_value
          assert_nil issue.object_index
          assert_nil issue.qualifier
        end

        def test_mapping_issue_all_fields
          issue = MappingIssue.new(
            direction: 'response', reason: 'unknown_value',
            attribute_name: 'bar', attribute_value: 'baz',
            object_index: 2, qualifier: 'queue'
          )

          assert_equal 'response', issue.direction
          assert_equal 'baz', issue.attribute_value
          assert_equal 2, issue.object_index
          assert_equal 'queue', issue.qualifier
        end

        def test_mapping_issue_to_payload
          issue = MappingIssue.new(
            direction: 'request', reason: 'unknown_key',
            attribute_name: 'x', attribute_value: 42, qualifier: 'qmgr'
          )
          payload = issue.to_payload

          assert_equal 'request', payload['direction']
          assert_equal 'unknown_key', payload['reason']
          assert_equal 'x', payload['attribute_name']
          assert_equal 42, payload['attribute_value']
          assert_nil payload['object_index']
          assert_equal 'qmgr', payload['qualifier']
        end

        def test_mapping_issue_to_payload_nil_value
          issue = MappingIssue.new(
            direction: 'request', reason: 'unknown_key',
            attribute_name: 'x'
          )
          payload = issue.to_payload

          assert_nil payload['attribute_value']
        end

        def test_mapping_issue_frozen
          issue = MappingIssue.new(direction: 'request', reason: 'unknown_key', attribute_name: 'x')

          assert_predicate issue, :frozen?
        end
      end

      class MappingTest < Minitest::Test
        def setup
          @mapping_data = {
            'qualifiers' => {
              'test_qualifier' => {
                'request_key_map' => { 'snake_name' => 'MQSC_NAME' },
                'request_value_map' => { 'snake_name' => { 'snake_val' => 'MQSC_VAL' } },
                'request_key_value_map' => {
                  'compound_attr' => {
                    'opt_a' => { 'key' => 'MQSC_KEY_A', 'value' => 'MQSC_VALUE_A' }
                  }
                },
                'response_key_map' => { 'MQSC_NAME' => 'snake_name', 'MQSC_OTHER' => 'other_name' },
                'response_value_map' => { 'MQSC_NAME' => { 'MQSC_VAL' => 'snake_val' } }
              }
            }
          }
        end

        def test_map_request_key
          result = Mapping.map_request_attributes(
            'test_qualifier', { 'snake_name' => 'raw_value' },
            strict: false, mapping_data: @mapping_data
          )

          assert_equal 'raw_value', result['MQSC_NAME']
          refute result.key?('snake_name')
        end

        def test_map_request_value
          result = Mapping.map_request_attributes(
            'test_qualifier', { 'snake_name' => 'snake_val' },
            strict: false, mapping_data: @mapping_data
          )

          assert_equal 'MQSC_VAL', result['MQSC_NAME']
        end

        def test_map_request_key_value_map
          result = Mapping.map_request_attributes(
            'test_qualifier', { 'compound_attr' => 'opt_a' },
            strict: false, mapping_data: @mapping_data
          )

          assert_equal 'MQSC_VALUE_A', result['MQSC_KEY_A']
          refute result.key?('compound_attr')
        end

        def test_map_request_key_value_map_unknown_value
          result = Mapping.map_request_attributes(
            'test_qualifier', { 'compound_attr' => 'unknown_opt' },
            strict: false, mapping_data: @mapping_data
          )

          assert_equal 'unknown_opt', result['compound_attr']
        end

        def test_map_request_key_value_map_non_string
          result = Mapping.map_request_attributes(
            'test_qualifier', { 'compound_attr' => 123 },
            strict: false, mapping_data: @mapping_data
          )

          assert_equal 123, result['compound_attr']
        end

        def test_map_request_unknown_key_strict
          assert_raises(MappingError) do
            Mapping.map_request_attributes(
              'test_qualifier', { 'unknown_key' => 'val' },
              strict: true, mapping_data: @mapping_data
            )
          end
        end

        def test_map_request_unknown_key_non_strict
          result = Mapping.map_request_attributes(
            'test_qualifier', { 'unknown_key' => 'val' },
            strict: false, mapping_data: @mapping_data
          )

          assert_equal 'val', result['unknown_key']
        end

        def test_map_request_unknown_qualifier_strict
          assert_raises(MappingError) do
            Mapping.map_request_attributes(
              'nonexistent', { 'key' => 'val' },
              strict: true, mapping_data: @mapping_data
            )
          end
        end

        def test_map_request_unknown_qualifier_non_strict
          result = Mapping.map_request_attributes(
            'nonexistent', { 'key' => 'val' },
            strict: false, mapping_data: @mapping_data
          )

          assert_equal 'val', result['key']
        end

        def test_map_response_key
          result = Mapping.map_response_attributes(
            'test_qualifier', { 'MQSC_NAME' => 'raw' },
            strict: false, mapping_data: @mapping_data
          )

          assert_equal 'raw', result['snake_name']
        end

        def test_map_response_value
          result = Mapping.map_response_attributes(
            'test_qualifier', { 'MQSC_NAME' => 'MQSC_VAL' },
            strict: false, mapping_data: @mapping_data
          )

          assert_equal 'snake_val', result['snake_name']
        end

        def test_map_response_unknown_value_strict
          assert_raises(MappingError) do
            Mapping.map_response_attributes(
              'test_qualifier', { 'MQSC_NAME' => 'UNKNOWN' },
              strict: true, mapping_data: @mapping_data
            )
          end
        end

        def test_map_response_unknown_value_non_strict
          result = Mapping.map_response_attributes(
            'test_qualifier', { 'MQSC_NAME' => 'UNKNOWN' },
            strict: false, mapping_data: @mapping_data
          )

          assert_equal 'UNKNOWN', result['snake_name']
        end

        def test_map_response_list
          objects = [
            { 'MQSC_NAME' => 'MQSC_VAL' },
            { 'MQSC_OTHER' => 'raw' }
          ]
          result = Mapping.map_response_list(
            'test_qualifier', objects,
            strict: false, mapping_data: @mapping_data
          )

          assert_equal 2, result.length
          assert_equal 'snake_val', result[0]['snake_name']
          assert_equal 'raw', result[1]['other_name']
        end

        def test_map_response_list_strict_error
          objects = [{ 'UNKNOWN_KEY' => 'val' }]
          assert_raises(MappingError) do
            Mapping.map_response_list(
              'test_qualifier', objects,
              strict: true, mapping_data: @mapping_data
            )
          end
        end

        def test_map_response_list_unknown_qualifier_strict
          assert_raises(MappingError) do
            Mapping.map_response_list(
              'nonexistent', [{ 'k' => 'v' }],
              strict: true, mapping_data: @mapping_data
            )
          end
        end

        def test_map_response_list_unknown_qualifier_non_strict
          result = Mapping.map_response_list(
            'nonexistent', [{ 'k' => 'v' }],
            strict: false, mapping_data: @mapping_data
          )

          assert_equal [{ 'k' => 'v' }], result
        end

        def test_map_response_unknown_qualifier_strict
          assert_raises(MappingError) do
            Mapping.map_response_attributes(
              'nonexistent', { 'k' => 'v' },
              strict: true, mapping_data: @mapping_data
            )
          end
        end

        def test_map_response_unknown_qualifier_non_strict
          result = Mapping.map_response_attributes(
            'nonexistent', { 'k' => 'v' },
            strict: false, mapping_data: @mapping_data
          )

          assert_equal({ 'k' => 'v' }, result)
        end

        def test_map_value_list
          data = {
            'qualifiers' => {
              'q' => {
                'response_key_map' => { 'NAMES' => 'names' },
                'response_value_map' => { 'NAMES' => { 'A' => 'a', 'B' => 'b' } }
              }
            }
          }
          result = Mapping.map_response_attributes(
            'q', { 'NAMES' => %w[A B] },
            strict: false, mapping_data: data
          )

          assert_equal %w[a b], result['names']
        end

        def test_map_value_list_unknown_value
          data = {
            'qualifiers' => {
              'q' => {
                'response_key_map' => { 'NAMES' => 'names' },
                'response_value_map' => { 'NAMES' => { 'A' => 'a' } }
              }
            }
          }
          result = Mapping.map_response_attributes(
            'q', { 'NAMES' => %w[A UNKNOWN] },
            strict: false, mapping_data: data
          )

          assert_equal %w[a UNKNOWN], result['names']
        end

        def test_map_value_list_non_string_items
          data = {
            'qualifiers' => {
              'q' => {
                'response_key_map' => { 'NUMS' => 'nums' },
                'response_value_map' => { 'NUMS' => { '1' => 'one' } }
              }
            }
          }
          result = Mapping.map_response_attributes(
            'q', { 'NUMS' => [42, '1'] },
            strict: false, mapping_data: data
          )

          assert_equal [42, 'one'], result['nums']
        end

        def test_map_non_string_value_passes_through
          data = {
            'qualifiers' => {
              'q' => {
                'response_key_map' => { 'NUM' => 'num' },
                'response_value_map' => { 'NUM' => { '0' => 'zero' } }
              }
            }
          }
          result = Mapping.map_response_attributes(
            'q', { 'NUM' => 42 },
            strict: false, mapping_data: data
          )

          assert_equal 42, result['num']
        end

        def test_map_request_unknown_value_strict
          assert_raises(MappingError) do
            Mapping.map_request_attributes(
              'test_qualifier', { 'snake_name' => 'NONEXISTENT' },
              strict: true, mapping_data: @mapping_data
            )
          end
        end

        def test_uses_default_mapping_data
          # This tests that when mapping_data is nil, the global MAPPING_DATA is used.
          # We just verify it doesn't crash with the default data.
          result = Mapping.map_request_attributes(
            'queue', { 'description' => 'test' }, strict: false
          )

          assert_kind_of Hash, result
        end

        def test_no_qualifiers_in_data
          result = Mapping.map_request_attributes(
            'queue', { 'key' => 'val' },
            strict: false, mapping_data: {}
          )

          assert_equal({ 'key' => 'val' }, result)
        end

        def test_no_qualifiers_in_data_strict
          assert_raises(MappingError) do
            Mapping.map_request_attributes(
              'queue', { 'key' => 'val' },
              strict: true, mapping_data: {}
            )
          end
        end

        def test_mapping_issue_serialize_complex_values
          issue = MappingIssue.new(
            direction: 'request', reason: 'unknown_value',
            attribute_name: 'x', attribute_value: { 'nested' => [1, 2] }
          )
          payload = issue.to_payload

          assert_equal({ 'nested' => [1, 2] }, payload['attribute_value'])
        end

        def test_mapping_issue_serialize_non_serializable
          issue = MappingIssue.new(
            direction: 'request', reason: 'unknown_value',
            attribute_name: 'x', attribute_value: Object.new
          )
          payload = issue.to_payload

          assert_kind_of String, payload['attribute_value']
        end

        def test_map_response_list_with_object_index_in_issues
          objects = [
            { 'UNKNOWN' => 'val' }
          ]
          err = assert_raises(MappingError) do
            Mapping.map_response_list(
              'test_qualifier', objects,
              strict: true, mapping_data: @mapping_data
            )
          end
          assert_equal 0, err.issues[0].object_index
        end

        def test_key_value_map_strict_unknown_value
          err = assert_raises(MappingError) do
            Mapping.map_request_attributes(
              'test_qualifier', { 'compound_attr' => 'bad_opt' },
              strict: true, mapping_data: @mapping_data
            )
          end
          assert_equal 'unknown_value', err.issues[0].reason
        end

        def test_key_value_map_non_string_strict
          err = assert_raises(MappingError) do
            Mapping.map_request_attributes(
              'test_qualifier', { 'compound_attr' => 999 },
              strict: true, mapping_data: @mapping_data
            )
          end
          assert_equal 'unknown_value', err.issues[0].reason
        end

        def test_serialize_value_array
          issue = MappingIssue.new(
            direction: 'request', reason: 'unknown_value',
            attribute_name: 'x', attribute_value: [1, 'two', { 'k' => 'v' }]
          )
          payload = issue.to_payload

          assert_equal [1, 'two', { 'k' => 'v' }], payload['attribute_value']
        end

        def test_get_key_map_non_hash
          # When qualifier_data has a non-Hash key_map, it should return empty
          data = {
            'qualifiers' => {
              'test_q' => {
                'request_key_map' => 'not_a_hash',
                'request_value_map' => 'not_a_hash'
              }
            }
          }
          result = Mapping.map_request_attributes(
            'test_q', { 'key' => 'val' },
            strict: false, mapping_data: data
          )
          # Key should pass through since key_map isn't a Hash
          assert_equal 'val', result['key']
        end

        def test_get_value_map_non_hash
          data = {
            'qualifiers' => {
              'test_q' => {
                'response_key_map' => { 'KEY' => 'key' },
                'response_value_map' => 'not_a_hash'
              }
            }
          }
          result = Mapping.map_response_attributes(
            'test_q', { 'KEY' => 'VAL' },
            strict: false, mapping_data: data
          )
          # Value should pass through since value_map isn't a Hash
          assert_equal 'VAL', result['key']
        end

        def test_map_value_list_strict_unknown
          data = {
            'qualifiers' => {
              'q' => {
                'response_key_map' => { 'X' => 'x' },
                'response_value_map' => { 'X' => { 'A' => 'a' } }
              }
            }
          }
          err = assert_raises(MappingError) do
            Mapping.map_response_attributes(
              'q', { 'X' => %w[A Z] },
              strict: true, mapping_data: data
            )
          end
          assert_equal 'unknown_value', err.issues[0].reason
          assert_equal 'Z', err.issues[0].attribute_value
        end
      end
    end
  end
end
