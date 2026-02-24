# frozen_string_literal: true

require 'test_helper'

module MQ
  module REST
    module Admin
      class ErrorsTest < Minitest::Test
        def test_error_is_standard_error
          assert_kind_of StandardError, Error.new('test')
        end

        def test_transport_error_attributes
          err = TransportError.new('failed', url: 'https://example.com')

          assert_equal 'failed', err.message
          assert_equal 'https://example.com', err.url
          assert_kind_of Error, err
        end

        def test_response_error_with_text
          err = ResponseError.new('bad json', response_text: '{invalid')

          assert_equal 'bad json', err.message
          assert_equal '{invalid', err.response_text
          assert_kind_of Error, err
        end

        def test_response_error_without_text
          err = ResponseError.new('bad json')

          assert_nil err.response_text
        end

        def test_auth_error_attributes
          err = AuthError.new('denied', url: 'https://example.com', status_code: 401)

          assert_equal 'denied', err.message
          assert_equal 'https://example.com', err.url
          assert_equal 401, err.status_code
          assert_kind_of Error, err
        end

        def test_auth_error_without_status
          err = AuthError.new('denied', url: 'https://example.com')

          assert_nil err.status_code
        end

        def test_command_error_attributes
          err = CommandError.new('failed', payload: { 'key' => 'value' }, status_code: 400)

          assert_equal 'failed', err.message
          assert_equal({ 'key' => 'value' }, err.payload)
          assert_equal 400, err.status_code
          assert_kind_of Error, err
        end

        def test_command_error_without_status
          err = CommandError.new('failed', payload: {})

          assert_nil err.status_code
        end

        def test_timeout_error_attributes
          err = TimeoutError.new('timed out', name: 'MY.CHANNEL', operation: 'start', elapsed: 30.5)

          assert_equal 'timed out', err.message
          assert_equal 'MY.CHANNEL', err.name
          assert_equal 'start', err.operation
          assert_in_delta 30.5, err.elapsed
          assert_kind_of Error, err
        end

        def test_mapping_error_with_issues
          issues = [
            MappingIssue.new(direction: 'request', reason: 'unknown_key', attribute_name: 'foo',
                             qualifier: 'queue')
          ]
          err = MappingError.new(issues)

          assert_equal 1, err.issues.length
          assert_includes err.message, '1 issue(s)'
          assert_includes err.message, 'foo'
          assert_kind_of Error, err
        end

        def test_mapping_error_with_custom_message
          err = MappingError.new([], message: 'custom')

          assert_equal 'custom', err.message
        end

        def test_mapping_error_empty_issues
          err = MappingError.new([])

          assert_includes err.message, 'no issues reported'
        end

        def test_mapping_error_to_payload
          issues = [
            MappingIssue.new(direction: 'response', reason: 'unknown_value',
                             attribute_name: 'bar', attribute_value: 'baz',
                             object_index: 1, qualifier: 'channel')
          ]
          err = MappingError.new(issues)
          payload = err.to_payload

          assert_equal 1, payload.length
          assert_equal 'response', payload[0]['direction']
          assert_equal 'unknown_value', payload[0]['reason']
          assert_equal 'bar', payload[0]['attribute_name']
          assert_equal 'baz', payload[0]['attribute_value']
          assert_equal 1, payload[0]['object_index']
          assert_equal 'channel', payload[0]['qualifier']
        end

        def test_mapping_error_issues_frozen
          issues = [MappingIssue.new(direction: 'request', reason: 'unknown_key', attribute_name: 'x')]
          err = MappingError.new(issues)

          assert_predicate err.issues, :frozen?
        end

        def test_mapping_error_message_with_value_and_index
          issues = [
            MappingIssue.new(
              direction: 'response', reason: 'unknown_value',
              attribute_name: 'attr', attribute_value: 'val',
              object_index: 2, qualifier: 'queue'
            )
          ]
          err = MappingError.new(issues)

          assert_includes err.message, 'index=2'
          assert_includes err.message, 'qualifier=queue'
          assert_includes err.message, 'value="val"'
        end

        def test_mapping_error_message_nil_index_and_qualifier
          issues = [
            MappingIssue.new(direction: 'request', reason: 'unknown_key', attribute_name: 'x')
          ]
          err = MappingError.new(issues)

          assert_includes err.message, 'index=-'
          assert_includes err.message, 'qualifier=-'
          assert_includes err.message, 'value=-'
        end
      end
    end
  end
end
