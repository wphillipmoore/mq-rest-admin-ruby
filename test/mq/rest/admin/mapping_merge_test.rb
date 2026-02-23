# frozen_string_literal: true

require 'test_helper'

module MQ
  module REST
    module Admin
      class MappingMergeTest < Minitest::Test
        def test_validate_valid_overrides
          overrides = {
            'commands' => { 'DISPLAY QUEUE' => { 'qualifier' => 'queue' } },
            'qualifiers' => {
              'queue' => { 'request_key_map' => { 'a' => 'A' } }
            }
          }
          MappingMerge.validate_mapping_overrides(overrides)
        end

        def test_validate_invalid_top_level_key
          assert_raises(ArgumentError) do
            MappingMerge.validate_mapping_overrides({ 'invalid' => {} })
          end
        end

        def test_validate_commands_not_hash
          assert_raises(TypeError) do
            MappingMerge.validate_mapping_overrides({ 'commands' => 'bad' })
          end
        end

        def test_validate_command_entry_not_hash
          assert_raises(TypeError) do
            MappingMerge.validate_mapping_overrides({ 'commands' => { 'X' => 'bad' } })
          end
        end

        def test_validate_qualifiers_not_hash
          assert_raises(TypeError) do
            MappingMerge.validate_mapping_overrides({ 'qualifiers' => 'bad' })
          end
        end

        def test_validate_qualifier_entry_not_hash
          assert_raises(TypeError) do
            MappingMerge.validate_mapping_overrides({ 'qualifiers' => { 'q' => 'bad' } })
          end
        end

        def test_validate_qualifier_invalid_sub_key
          assert_raises(ArgumentError) do
            MappingMerge.validate_mapping_overrides({
                                                      'qualifiers' => { 'q' => { 'invalid_key' => {} } }
                                                    })
          end
        end

        def test_validate_qualifier_sub_value_not_hash
          assert_raises(TypeError) do
            MappingMerge.validate_mapping_overrides({
                                                      'qualifiers' => { 'q' => { 'request_key_map' => 'bad' } }
                                                    })
          end
        end

        def test_validate_empty_overrides
          MappingMerge.validate_mapping_overrides({})
        end

        def test_validate_nil_sections
          MappingMerge.validate_mapping_overrides({ 'commands' => nil, 'qualifiers' => nil })
        end

        def test_merge_commands
          base = {
            'commands' => { 'DISPLAY QUEUE' => { 'qualifier' => 'queue' } },
            'qualifiers' => {}
          }
          overrides = {
            'commands' => {
              'DISPLAY QUEUE' => { 'extra' => 'data' },
              'NEW CMD' => { 'qualifier' => 'new' }
            }
          }
          result = MappingMerge.merge_mapping_data(base, overrides)

          assert_equal 'queue', result['commands']['DISPLAY QUEUE']['qualifier']
          assert_equal 'data', result['commands']['DISPLAY QUEUE']['extra']
          assert_equal 'new', result['commands']['NEW CMD']['qualifier']
        end

        def test_merge_qualifiers
          base = {
            'commands' => {},
            'qualifiers' => {
              'queue' => {
                'request_key_map' => { 'a' => 'A' }
              }
            }
          }
          overrides = {
            'qualifiers' => {
              'queue' => {
                'request_key_map' => { 'b' => 'B' }
              }
            }
          }
          result = MappingMerge.merge_mapping_data(base, overrides)

          assert_equal 'A', result['qualifiers']['queue']['request_key_map']['a']
          assert_equal 'B', result['qualifiers']['queue']['request_key_map']['b']
        end

        def test_merge_new_qualifier
          base = { 'commands' => {}, 'qualifiers' => {} }
          overrides = {
            'qualifiers' => {
              'new_q' => { 'request_key_map' => { 'x' => 'X' } }
            }
          }
          result = MappingMerge.merge_mapping_data(base, overrides)

          assert_equal 'X', result['qualifiers']['new_q']['request_key_map']['x']
        end

        def test_merge_does_not_mutate_base
          base = {
            'commands' => { 'X' => { 'a' => 1 } },
            'qualifiers' => { 'q' => { 'request_key_map' => { 'a' => 'A' } } }
          }
          original_base = Marshal.load(Marshal.dump(base))
          MappingMerge.merge_mapping_data(base, {
                                            'commands' => { 'X' => { 'b' => 2 } },
                                            'qualifiers' => { 'q' => { 'request_key_map' => { 'b' => 'B' } } }
                                          })

          assert_equal original_base, base
        end

        def test_merge_with_non_hash_entries_skipped
          base = { 'commands' => {}, 'qualifiers' => {} }
          # Non-hash entries should be skipped gracefully
          overrides = { 'commands' => { 'X' => 'not_a_hash' } }
          result = MappingMerge.merge_mapping_data(base, overrides)

          refute result['commands'].key?('X')
        end

        def test_merge_qualifier_non_hash_sub_value_skipped
          base = { 'qualifiers' => { 'q' => { 'request_key_map' => { 'a' => 'A' } } } }
          overrides = { 'qualifiers' => { 'q' => { 'request_key_map' => 'not_hash' } } }
          result = MappingMerge.merge_mapping_data(base, overrides)
          # Non-hash sub_value is skipped, original preserved
          assert_equal 'A', result['qualifiers']['q']['request_key_map']['a']
        end

        def test_merge_non_hash_override_sections_skipped
          base = { 'commands' => {}, 'qualifiers' => {} }
          result = MappingMerge.merge_mapping_data(base, { 'commands' => 'bad' })

          assert_empty(result['commands'])
        end

        def test_merge_qualifier_non_hash_entry_skipped
          base = { 'qualifiers' => {} }
          result = MappingMerge.merge_mapping_data(base, { 'qualifiers' => { 'q' => 'bad' } })

          refute result['qualifiers'].key?('q')
        end

        def test_merge_base_commands_nil
          base = { 'qualifiers' => {} }
          overrides = { 'commands' => { 'X' => { 'a' => 1 } } }
          result = MappingMerge.merge_mapping_data(base, overrides)

          assert_equal({ 'a' => 1 }, result['commands']['X'])
        end

        def test_merge_base_qualifiers_nil
          base = { 'commands' => {} }
          overrides = { 'qualifiers' => { 'q' => { 'request_key_map' => { 'a' => 'A' } } } }
          result = MappingMerge.merge_mapping_data(base, overrides)

          assert_equal 'A', result['qualifiers']['q']['request_key_map']['a']
        end

        def test_merge_new_sub_key_in_qualifier
          base = { 'qualifiers' => { 'q' => { 'request_key_map' => { 'a' => 'A' } } } }
          overrides = { 'qualifiers' => { 'q' => { 'response_key_map' => { 'B' => 'b' } } } }
          result = MappingMerge.merge_mapping_data(base, overrides)

          assert_equal 'A', result['qualifiers']['q']['request_key_map']['a']
          assert_equal 'b', result['qualifiers']['q']['response_key_map']['B']
        end

        def test_replace_mapping_data
          overrides = { 'commands' => { 'X' => { 'q' => 'test' } }, 'qualifiers' => {} }
          result = MappingMerge.replace_mapping_data(overrides)

          assert_equal overrides, result
          # Verify deep copy
          result['commands']['X']['q'] = 'modified'

          assert_equal 'test', overrides['commands']['X']['q']
        end

        def test_validate_complete_success
          base = {
            'commands' => { 'A' => {}, 'B' => {} },
            'qualifiers' => { 'q1' => {}, 'q2' => {} }
          }
          overrides = {
            'commands' => { 'A' => {}, 'B' => {} },
            'qualifiers' => { 'q1' => {}, 'q2' => {} }
          }
          MappingMerge.validate_mapping_overrides_complete(base, overrides)
        end

        def test_validate_complete_missing_commands
          base = { 'commands' => { 'A' => {}, 'B' => {} }, 'qualifiers' => {} }
          overrides = { 'commands' => { 'A' => {} }, 'qualifiers' => {} }
          err = assert_raises(ArgumentError) do
            MappingMerge.validate_mapping_overrides_complete(base, overrides)
          end
          assert_includes err.message, 'commands: B'
        end

        def test_validate_complete_missing_qualifiers
          base = { 'commands' => {}, 'qualifiers' => { 'q1' => {}, 'q2' => {} } }
          overrides = { 'commands' => {}, 'qualifiers' => { 'q1' => {} } }
          err = assert_raises(ArgumentError) do
            MappingMerge.validate_mapping_overrides_complete(base, overrides)
          end
          assert_includes err.message, 'qualifiers: q2'
        end

        def test_validate_complete_no_overrides_sections
          base = { 'commands' => { 'A' => {} }, 'qualifiers' => { 'q' => {} } }
          err = assert_raises(ArgumentError) do
            MappingMerge.validate_mapping_overrides_complete(base, {})
          end
          assert_includes err.message, 'commands: A'
          assert_includes err.message, 'qualifiers: q'
        end

        def test_validate_complete_base_no_commands
          base = { 'qualifiers' => { 'q' => {} } }
          overrides = { 'qualifiers' => { 'q' => {} } }
          MappingMerge.validate_mapping_overrides_complete(base, overrides)
        end

        def test_validate_complete_base_no_qualifiers
          base = { 'commands' => { 'A' => {} } }
          overrides = { 'commands' => { 'A' => {} } }
          MappingMerge.validate_mapping_overrides_complete(base, overrides)
        end
      end
    end
  end
end
