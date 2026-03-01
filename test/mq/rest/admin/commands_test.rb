# frozen_string_literal: true

require 'test_helper'

module MQ
  module REST
    module Admin
      class CommandsTest < Minitest::Test
        # -- Singleton DISPLAY (returns Hash or nil) --

        def test_display_qmgr_returns_hash
          session, = Admin.build_test_session(
            responses: [
              TransportResponse.new(
                status_code: 200,
                body: Admin.build_response([{ 'DESCR' => 'QM1' }]),
                headers: {}
              )
            ]
          )
          result = session.display_qmgr

          assert_equal({ 'DESCR' => 'QM1' }, result)
        end

        def test_display_qmgr_returns_nil_when_empty
          session, = Admin.build_test_session(
            responses: [
              TransportResponse.new(status_code: 200, body: Admin.build_response, headers: {})
            ]
          )

          assert_nil session.display_qmgr
        end

        def test_display_qmstatus
          session, = Admin.build_test_session(
            responses: [
              TransportResponse.new(
                status_code: 200,
                body: Admin.build_response([{ 'STATUS' => 'RUNNING' }]),
                headers: {}
              )
            ]
          )
          result = session.display_qmstatus

          assert_equal 'RUNNING', result['STATUS']
        end

        def test_display_cmdserv
          session, = Admin.build_test_session(
            responses: [
              TransportResponse.new(
                status_code: 200,
                body: Admin.build_response([{ 'STATUS' => 'ENABLED' }]),
                headers: {}
              )
            ]
          )
          result = session.display_cmdserv

          assert_equal 'ENABLED', result['STATUS']
        end

        # -- Wildcard DISPLAY (returns Array) --

        def test_display_queue_list
          session, transport = Admin.build_test_session(
            responses: [
              TransportResponse.new(
                status_code: 200,
                body: Admin.build_response([{ 'QUEUE' => 'Q1' }, { 'QUEUE' => 'Q2' }]),
                headers: {}
              )
            ]
          )
          result = session.display_queue

          assert_equal 2, result.length
          # Verify name defaults to "*"
          payload = transport.calls[0][:payload]

          assert_equal '*', payload['name']
        end

        def test_display_queue_with_name
          session, transport = Admin.build_test_session(
            responses: [
              TransportResponse.new(
                status_code: 200,
                body: Admin.build_response([{ 'QUEUE' => 'MY.Q' }]),
                headers: {}
              )
            ]
          )
          session.display_queue(name: 'MY.Q')

          assert_equal 'MY.Q', transport.calls[0][:payload]['name']
        end

        def test_display_queue_with_where
          session, transport = Admin.build_test_session(
            responses: [
              TransportResponse.new(
                status_code: 200, body: Admin.build_response, headers: {}
              )
            ]
          )
          session.display_queue(where: 'CURDEPTH GT 0')

          assert_equal 'CURDEPTH GT 0', transport.calls[0][:payload]['parameters']['WHERE']
        end

        def test_display_channel_wildcard
          session, transport = Admin.build_test_session(
            responses: [
              TransportResponse.new(
                status_code: 200,
                body: Admin.build_response([{ 'CHANNEL' => 'CH1' }]),
                headers: {}
              )
            ]
          )
          result = session.display_channel

          assert_equal 1, result.length
          assert_equal '*', transport.calls[0][:payload]['name']
        end

        # -- List DISPLAY (returns Array, required name) --

        def test_display_qstatus
          session, = Admin.build_test_session(
            responses: [
              TransportResponse.new(
                status_code: 200,
                body: Admin.build_response([{ 'QUEUE' => 'Q1', 'CURDEPTH' => '5' }]),
                headers: {}
              )
            ]
          )
          result = session.display_qstatus('Q1')

          assert_equal 1, result.length
          assert_equal '5', result[0]['CURDEPTH']
        end

        # -- Mutation with required name --

        def test_define_qlocal
          session, transport = Admin.build_test_session(
            responses: [
              TransportResponse.new(status_code: 200, body: Admin.build_response, headers: {})
            ]
          )
          result = session.define_qlocal('MY.Q', request_parameters: { 'MAXDEPTH' => '5000' })

          assert_nil result
          assert_equal 'DEFINE', transport.calls[0][:payload]['command']
          assert_equal 'QLOCAL', transport.calls[0][:payload]['qualifier']
          assert_equal 'MY.Q', transport.calls[0][:payload]['name']
        end

        def test_delete_queue
          session, transport = Admin.build_test_session(
            responses: [
              TransportResponse.new(status_code: 200, body: Admin.build_response, headers: {})
            ]
          )
          result = session.delete_queue('MY.Q')

          assert_nil result
          assert_equal 'DELETE', transport.calls[0][:payload]['command']
        end

        # -- Mutation with optional name --

        def test_alter_authinfo
          session, transport = Admin.build_test_session(
            responses: [
              TransportResponse.new(status_code: 200, body: Admin.build_response, headers: {})
            ]
          )
          result = session.alter_authinfo(name: 'MY.AUTH')

          assert_nil result
          assert_equal 'ALTER', transport.calls[0][:payload]['command']
          assert_equal 'AUTHINFO', transport.calls[0][:payload]['qualifier']
          assert_equal 'MY.AUTH', transport.calls[0][:payload]['name']
        end

        def test_alter_qmgr
          session, transport = Admin.build_test_session(
            responses: [
              TransportResponse.new(status_code: 200, body: Admin.build_response, headers: {})
            ]
          )
          result = session.alter_qmgr(request_parameters: { 'DESCR' => 'test' })

          assert_nil result
          assert_equal 'ALTER', transport.calls[0][:payload]['command']
          assert_equal 'QMGR', transport.calls[0][:payload]['qualifier']
        end

        def test_alter_qlocal
          session, transport = Admin.build_test_session(
            responses: [
              TransportResponse.new(status_code: 200, body: Admin.build_response, headers: {})
            ]
          )
          result = session.alter_qlocal(name: 'MY.Q')

          assert_nil result
          assert_equal 'ALTER', transport.calls[0][:payload]['command']
          assert_equal 'QLOCAL', transport.calls[0][:payload]['qualifier']
          assert_equal 'MY.Q', transport.calls[0][:payload]['name']
        end

        def test_alter_qlocal_without_name
          session, transport = Admin.build_test_session(
            responses: [
              TransportResponse.new(status_code: 200, body: Admin.build_response, headers: {})
            ]
          )
          result = session.alter_qlocal

          assert_nil result
          assert_nil transport.calls[0][:payload]['name']
        end

        def test_alter_qremote
          session, transport = Admin.build_test_session(
            responses: [
              TransportResponse.new(status_code: 200, body: Admin.build_response, headers: {})
            ]
          )
          result = session.alter_qremote(name: 'MY.Q')

          assert_nil result
          assert_equal 'ALTER', transport.calls[0][:payload]['command']
          assert_equal 'QREMOTE', transport.calls[0][:payload]['qualifier']
        end

        def test_alter_qalias
          session, transport = Admin.build_test_session(
            responses: [
              TransportResponse.new(status_code: 200, body: Admin.build_response, headers: {})
            ]
          )
          result = session.alter_qalias(name: 'MY.Q')

          assert_nil result
          assert_equal 'ALTER', transport.calls[0][:payload]['command']
          assert_equal 'QALIAS', transport.calls[0][:payload]['qualifier']
        end

        def test_alter_qmodel
          session, transport = Admin.build_test_session(
            responses: [
              TransportResponse.new(status_code: 200, body: Admin.build_response, headers: {})
            ]
          )
          result = session.alter_qmodel(name: 'MY.Q')

          assert_nil result
          assert_equal 'ALTER', transport.calls[0][:payload]['command']
          assert_equal 'QMODEL', transport.calls[0][:payload]['qualifier']
        end

        # -- Mutation with no name --

        def test_archive_log
          session, transport = Admin.build_test_session(
            responses: [
              TransportResponse.new(status_code: 200, body: Admin.build_response, headers: {})
            ]
          )
          result = session.archive_log

          assert_nil result
          assert_equal 'ARCHIVE', transport.calls[0][:payload]['command']
          assert_equal 'LOG', transport.calls[0][:payload]['qualifier']
        end

        # -- Verify all 148 commands are defined --

        def test_all_commands_defined
          expected_count = 152
          actual_count = Commands.instance_methods(false).length

          assert_equal expected_count, actual_count,
                       "Expected #{expected_count} commands, got #{actual_count}"
        end

        # -- Spot check a few more methods exist --

        def test_start_channel_exists
          assert Commands.instance_method(:start_channel)
        end

        def test_stop_listener_exists
          assert Commands.instance_method(:stop_listener)
        end

        def test_refresh_security_exists
          assert Commands.instance_method(:refresh_security)
        end

        def test_display_conn_exists
          assert Commands.instance_method(:display_conn)
        end

        def test_set_chlauth_exists
          assert Commands.instance_method(:set_chlauth)
        end

        # -- Request and response parameters forwarding --

        def test_request_parameters_forwarded
          session, transport = Admin.build_test_session(
            responses: [
              TransportResponse.new(status_code: 200, body: Admin.build_response, headers: {})
            ]
          )
          session.define_qlocal('Q1', request_parameters: { 'MAXDEPTH' => '1000' })

          assert_equal({ 'MAXDEPTH' => '1000' }, transport.calls[0][:payload]['parameters'])
        end

        def test_response_parameters_forwarded
          session, transport = Admin.build_test_session(
            responses: [
              TransportResponse.new(
                status_code: 200,
                body: Admin.build_response([{ 'DESCR' => 'test' }]),
                headers: {}
              )
            ]
          )
          session.display_qmgr(response_parameters: %w[DESCR MAXDEPTH])

          assert_equal %w[DESCR MAXDEPTH], transport.calls[0][:payload]['responseParameters']
        end
      end
    end
  end
end
