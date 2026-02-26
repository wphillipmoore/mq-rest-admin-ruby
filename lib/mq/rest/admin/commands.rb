# frozen_string_literal: true

# This file is generated. Do not edit manually.
# Generated from pymqrest commands.py

module MQ
  module REST
    module Admin
      # MQSC command methods generated from the pymqrest command definitions.
      #
      # Each method corresponds to an MQSC command and delegates to the
      # private +mqsc_command+ method on {Session}. Included by {Session}.
      module Commands
        # Execute the MQSC +DISPLAY QMGR+ command.
        #
        # @param request_parameters [Hash{String => Object}, nil] request attributes
        # @param response_parameters [Array<String>, nil] response attributes to return
        # @return [Hash{String => Object}, nil] parameter hash, or nil if empty
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def display_qmgr(request_parameters: nil, response_parameters: nil)
          objects = mqsc_command(
            command: 'DISPLAY', mqsc_qualifier: 'QMGR',
            name: nil, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          objects.empty? ? nil : objects[0]
        end

        # Execute the MQSC +DISPLAY QMSTATUS+ command.
        #
        # @param request_parameters [Hash{String => Object}, nil] request attributes
        # @param response_parameters [Array<String>, nil] response attributes to return
        # @return [Hash{String => Object}, nil] parameter hash, or nil if empty
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def display_qmstatus(request_parameters: nil, response_parameters: nil)
          objects = mqsc_command(
            command: 'DISPLAY', mqsc_qualifier: 'QMSTATUS',
            name: nil, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          objects.empty? ? nil : objects[0]
        end

        # Execute the MQSC +DISPLAY CMDSERV+ command.
        #
        # @param request_parameters [Hash{String => Object}, nil] request attributes
        # @param response_parameters [Array<String>, nil] response attributes to return
        # @return [Hash{String => Object}, nil] parameter hash, or nil if empty
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def display_cmdserv(request_parameters: nil, response_parameters: nil)
          objects = mqsc_command(
            command: 'DISPLAY', mqsc_qualifier: 'CMDSERV',
            name: nil, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          objects.empty? ? nil : objects[0]
        end

        # Execute the MQSC +DISPLAY QUEUE+ command.
        #
        # @param name [String, nil] object name or pattern, defaults to +"*"+
        # @param request_parameters [Hash{String => Object}, nil] request attributes
        # @param response_parameters [Array<String>, nil] response attributes to return
        # @param where [String, nil] filter expression
        # @return [Array<Hash{String => Object}>] parameter hashes
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def display_queue(name: nil, request_parameters: nil, response_parameters: nil, where: nil)
          mqsc_command(
            command: 'DISPLAY', mqsc_qualifier: 'QUEUE',
            name: name || '*', request_parameters: request_parameters,
            response_parameters: response_parameters, where: where
          )
        end

        # Execute the MQSC +DISPLAY CHANNEL+ command.
        #
        # @param name [String, nil] object name or pattern, defaults to +"*"+
        # @param request_parameters [Hash{String => Object}, nil] request attributes
        # @param response_parameters [Array<String>, nil] response attributes to return
        # @param where [String, nil] filter expression
        # @return [Array<Hash{String => Object}>] parameter hashes
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def display_channel(name: nil, request_parameters: nil, response_parameters: nil, where: nil)
          mqsc_command(
            command: 'DISPLAY', mqsc_qualifier: 'CHANNEL',
            name: name || '*', request_parameters: request_parameters,
            response_parameters: response_parameters, where: where
          )
        end

        # Execute the MQSC +DEFINE QLOCAL+ command.
        #
        # @param name [String] the object name to define
        # @param request_parameters [Hash{String => Object}, nil] object attributes
        # @param response_parameters [Array<String>, nil] response attributes
        # @return [nil]
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def define_qlocal(name, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'DEFINE', mqsc_qualifier: 'QLOCAL',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        # Execute the MQSC +DEFINE QREMOTE+ command.
        #
        # @param name [String] the object name to define
        # @param request_parameters [Hash{String => Object}, nil] object attributes
        # @param response_parameters [Array<String>, nil] response attributes
        # @return [nil]
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def define_qremote(name, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'DEFINE', mqsc_qualifier: 'QREMOTE',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        # Execute the MQSC +DEFINE QALIAS+ command.
        #
        # @param name [String] the object name to define
        # @param request_parameters [Hash{String => Object}, nil] object attributes
        # @param response_parameters [Array<String>, nil] response attributes
        # @return [nil]
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def define_qalias(name, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'DEFINE', mqsc_qualifier: 'QALIAS',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        # Execute the MQSC +DEFINE QMODEL+ command.
        #
        # @param name [String] the object name to define
        # @param request_parameters [Hash{String => Object}, nil] object attributes
        # @param response_parameters [Array<String>, nil] response attributes
        # @return [nil]
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def define_qmodel(name, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'DEFINE', mqsc_qualifier: 'QMODEL',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        # Execute the MQSC +DELETE QUEUE+ command.
        #
        # @param name [String] the object name to delete
        # @param request_parameters [Hash{String => Object}, nil] request attributes
        # @param response_parameters [Array<String>, nil] response attributes
        # @return [nil]
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def delete_queue(name, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'DELETE', mqsc_qualifier: 'QUEUE',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        # Execute the MQSC +DEFINE CHANNEL+ command.
        #
        # @param name [String] the object name to define
        # @param request_parameters [Hash{String => Object}, nil] object attributes
        # @param response_parameters [Array<String>, nil] response attributes
        # @return [nil]
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def define_channel(name, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'DEFINE', mqsc_qualifier: 'CHANNEL',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        # Execute the MQSC +DELETE CHANNEL+ command.
        #
        # @param name [String] the object name to delete
        # @param request_parameters [Hash{String => Object}, nil] request attributes
        # @param response_parameters [Array<String>, nil] response attributes
        # @return [nil]
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def delete_channel(name, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'DELETE', mqsc_qualifier: 'CHANNEL',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        # Execute the MQSC +ALTER AUTHINFO+ command.
        #
        # @param name [String, nil] object name
        # @param request_parameters [Hash{String => Object}, nil] request attributes
        # @param response_parameters [Array<String>, nil] response attributes
        # @return [nil]
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def alter_authinfo(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'ALTER', mqsc_qualifier: 'AUTHINFO',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        # Execute the MQSC +ALTER BUFFPOOL+ command.
        #
        # @param name [String, nil] object name
        # @param request_parameters [Hash{String => Object}, nil] request attributes
        # @param response_parameters [Array<String>, nil] response attributes
        # @return [nil]
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def alter_buffpool(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'ALTER', mqsc_qualifier: 'BUFFPOOL',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        # Execute the MQSC +ALTER CFSTRUCT+ command.
        #
        # @param name [String, nil] object name
        # @param request_parameters [Hash{String => Object}, nil] request attributes
        # @param response_parameters [Array<String>, nil] response attributes
        # @return [nil]
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def alter_cfstruct(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'ALTER', mqsc_qualifier: 'CFSTRUCT',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        # Execute the MQSC +ALTER CHANNEL+ command.
        #
        # @param name [String, nil] object name
        # @param request_parameters [Hash{String => Object}, nil] request attributes
        # @param response_parameters [Array<String>, nil] response attributes
        # @return [nil]
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def alter_channel(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'ALTER', mqsc_qualifier: 'CHANNEL',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        # Execute the MQSC +ALTER COMMINFO+ command.
        #
        # @param name [String, nil] object name
        # @param request_parameters [Hash{String => Object}, nil] request attributes
        # @param response_parameters [Array<String>, nil] response attributes
        # @return [nil]
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def alter_comminfo(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'ALTER', mqsc_qualifier: 'COMMINFO',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        # Execute the MQSC +ALTER LISTENER+ command.
        #
        # @param name [String, nil] object name
        # @param request_parameters [Hash{String => Object}, nil] request attributes
        # @param response_parameters [Array<String>, nil] response attributes
        # @return [nil]
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def alter_listener(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'ALTER', mqsc_qualifier: 'LISTENER',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        # Execute the MQSC +ALTER NAMELIST+ command.
        #
        # @param name [String, nil] object name
        # @param request_parameters [Hash{String => Object}, nil] request attributes
        # @param response_parameters [Array<String>, nil] response attributes
        # @return [nil]
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def alter_namelist(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'ALTER', mqsc_qualifier: 'NAMELIST',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        # Execute the MQSC +ALTER PROCESS+ command.
        #
        # @param name [String, nil] object name
        # @param request_parameters [Hash{String => Object}, nil] request attributes
        # @param response_parameters [Array<String>, nil] response attributes
        # @return [nil]
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def alter_process(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'ALTER', mqsc_qualifier: 'PROCESS',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        # Execute the MQSC +ALTER PSID+ command.
        #
        # @param name [String, nil] object name
        # @param request_parameters [Hash{String => Object}, nil] request attributes
        # @param response_parameters [Array<String>, nil] response attributes
        # @return [nil]
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def alter_psid(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'ALTER', mqsc_qualifier: 'PSID',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        # Execute the MQSC +ALTER QMGR+ command.
        #
        # @param request_parameters [Hash{String => Object}, nil] request attributes
        # @param response_parameters [Array<String>, nil] response attributes
        # @return [nil]
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def alter_qmgr(request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'ALTER', mqsc_qualifier: 'QMGR',
            name: nil, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        # Execute the MQSC +ALTER SECURITY+ command.
        #
        # @param name [String, nil] object name
        # @param request_parameters [Hash{String => Object}, nil] request attributes
        # @param response_parameters [Array<String>, nil] response attributes
        # @return [nil]
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def alter_security(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'ALTER', mqsc_qualifier: 'SECURITY',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        # Execute the MQSC +ALTER SERVICE+ command.
        #
        # @param name [String, nil] object name
        # @param request_parameters [Hash{String => Object}, nil] request attributes
        # @param response_parameters [Array<String>, nil] response attributes
        # @return [nil]
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def alter_service(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'ALTER', mqsc_qualifier: 'SERVICE',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        # Execute the MQSC +ALTER SMDS+ command.
        #
        # @param name [String, nil] object name
        # @param request_parameters [Hash{String => Object}, nil] request attributes
        # @param response_parameters [Array<String>, nil] response attributes
        # @return [nil]
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def alter_smds(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'ALTER', mqsc_qualifier: 'SMDS',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        # Execute the MQSC +ALTER STGCLASS+ command.
        #
        # @param name [String, nil] object name
        # @param request_parameters [Hash{String => Object}, nil] request attributes
        # @param response_parameters [Array<String>, nil] response attributes
        # @return [nil]
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def alter_stgclass(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'ALTER', mqsc_qualifier: 'STGCLASS',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        # Execute the MQSC +ALTER SUB+ command.
        #
        # @param name [String, nil] object name
        # @param request_parameters [Hash{String => Object}, nil] request attributes
        # @param response_parameters [Array<String>, nil] response attributes
        # @return [nil]
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def alter_sub(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'ALTER', mqsc_qualifier: 'SUB',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        # Execute the MQSC +ALTER TOPIC+ command.
        #
        # @param name [String, nil] object name
        # @param request_parameters [Hash{String => Object}, nil] request attributes
        # @param response_parameters [Array<String>, nil] response attributes
        # @return [nil]
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def alter_topic(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'ALTER', mqsc_qualifier: 'TOPIC',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        # Execute the MQSC +ALTER TRACE+ command.
        #
        # @param name [String, nil] object name
        # @param request_parameters [Hash{String => Object}, nil] request attributes
        # @param response_parameters [Array<String>, nil] response attributes
        # @return [nil]
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def alter_trace(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'ALTER', mqsc_qualifier: 'TRACE',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        # Execute the MQSC +ARCHIVE LOG+ command.
        #
        # @param name [String, nil] object name
        # @param request_parameters [Hash{String => Object}, nil] request attributes
        # @param response_parameters [Array<String>, nil] response attributes
        # @return [nil]
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def archive_log(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'ARCHIVE', mqsc_qualifier: 'LOG',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        # Execute the MQSC +BACKUP CFSTRUCT+ command.
        #
        # @param name [String, nil] object name
        # @param request_parameters [Hash{String => Object}, nil] request attributes
        # @param response_parameters [Array<String>, nil] response attributes
        # @return [nil]
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def backup_cfstruct(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'BACKUP', mqsc_qualifier: 'CFSTRUCT',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        # Execute the MQSC +CLEAR QLOCAL+ command.
        #
        # @param name [String, nil] object name
        # @param request_parameters [Hash{String => Object}, nil] request attributes
        # @param response_parameters [Array<String>, nil] response attributes
        # @return [nil]
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def clear_qlocal(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'CLEAR', mqsc_qualifier: 'QLOCAL',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        # Execute the MQSC +CLEAR TOPICSTR+ command.
        #
        # @param name [String, nil] object name
        # @param request_parameters [Hash{String => Object}, nil] request attributes
        # @param response_parameters [Array<String>, nil] response attributes
        # @return [nil]
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def clear_topicstr(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'CLEAR', mqsc_qualifier: 'TOPICSTR',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        # Execute the MQSC +DEFINE AUTHINFO+ command.
        #
        # @param name [String, nil] object name
        # @param request_parameters [Hash{String => Object}, nil] request attributes
        # @param response_parameters [Array<String>, nil] response attributes
        # @return [nil]
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def define_authinfo(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'DEFINE', mqsc_qualifier: 'AUTHINFO',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        # Execute the MQSC +DEFINE BUFFPOOL+ command.
        #
        # @param name [String, nil] object name
        # @param request_parameters [Hash{String => Object}, nil] request attributes
        # @param response_parameters [Array<String>, nil] response attributes
        # @return [nil]
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def define_buffpool(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'DEFINE', mqsc_qualifier: 'BUFFPOOL',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        # Execute the MQSC +DEFINE CFSTRUCT+ command.
        #
        # @param name [String, nil] object name
        # @param request_parameters [Hash{String => Object}, nil] request attributes
        # @param response_parameters [Array<String>, nil] response attributes
        # @return [nil]
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def define_cfstruct(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'DEFINE', mqsc_qualifier: 'CFSTRUCT',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        # Execute the MQSC +DEFINE COMMINFO+ command.
        #
        # @param name [String, nil] object name
        # @param request_parameters [Hash{String => Object}, nil] request attributes
        # @param response_parameters [Array<String>, nil] response attributes
        # @return [nil]
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def define_comminfo(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'DEFINE', mqsc_qualifier: 'COMMINFO',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        # Execute the MQSC +DEFINE LISTENER+ command.
        #
        # @param name [String, nil] object name
        # @param request_parameters [Hash{String => Object}, nil] request attributes
        # @param response_parameters [Array<String>, nil] response attributes
        # @return [nil]
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def define_listener(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'DEFINE', mqsc_qualifier: 'LISTENER',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        # Execute the MQSC +DEFINE LOG+ command.
        #
        # @param name [String, nil] object name
        # @param request_parameters [Hash{String => Object}, nil] request attributes
        # @param response_parameters [Array<String>, nil] response attributes
        # @return [nil]
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def define_log(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'DEFINE', mqsc_qualifier: 'LOG',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        # Execute the MQSC +DEFINE MAXSMSGS+ command.
        #
        # @param name [String, nil] object name
        # @param request_parameters [Hash{String => Object}, nil] request attributes
        # @param response_parameters [Array<String>, nil] response attributes
        # @return [nil]
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def define_maxsmsgs(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'DEFINE', mqsc_qualifier: 'MAXSMSGS',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        # Execute the MQSC +DEFINE NAMELIST+ command.
        #
        # @param name [String, nil] object name
        # @param request_parameters [Hash{String => Object}, nil] request attributes
        # @param response_parameters [Array<String>, nil] response attributes
        # @return [nil]
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def define_namelist(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'DEFINE', mqsc_qualifier: 'NAMELIST',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        # Execute the MQSC +DEFINE PROCESS+ command.
        #
        # @param name [String, nil] object name
        # @param request_parameters [Hash{String => Object}, nil] request attributes
        # @param response_parameters [Array<String>, nil] response attributes
        # @return [nil]
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def define_process(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'DEFINE', mqsc_qualifier: 'PROCESS',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        # Execute the MQSC +DEFINE PSID+ command.
        #
        # @param name [String, nil] object name
        # @param request_parameters [Hash{String => Object}, nil] request attributes
        # @param response_parameters [Array<String>, nil] response attributes
        # @return [nil]
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def define_psid(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'DEFINE', mqsc_qualifier: 'PSID',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        # Execute the MQSC +DEFINE SERVICE+ command.
        #
        # @param name [String, nil] object name
        # @param request_parameters [Hash{String => Object}, nil] request attributes
        # @param response_parameters [Array<String>, nil] response attributes
        # @return [nil]
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def define_service(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'DEFINE', mqsc_qualifier: 'SERVICE',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        # Execute the MQSC +DEFINE STGCLASS+ command.
        #
        # @param name [String, nil] object name
        # @param request_parameters [Hash{String => Object}, nil] request attributes
        # @param response_parameters [Array<String>, nil] response attributes
        # @return [nil]
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def define_stgclass(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'DEFINE', mqsc_qualifier: 'STGCLASS',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        # Execute the MQSC +DEFINE SUB+ command.
        #
        # @param name [String, nil] object name
        # @param request_parameters [Hash{String => Object}, nil] request attributes
        # @param response_parameters [Array<String>, nil] response attributes
        # @return [nil]
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def define_sub(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'DEFINE', mqsc_qualifier: 'SUB',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        # Execute the MQSC +DEFINE TOPIC+ command.
        #
        # @param name [String, nil] object name
        # @param request_parameters [Hash{String => Object}, nil] request attributes
        # @param response_parameters [Array<String>, nil] response attributes
        # @return [nil]
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def define_topic(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'DEFINE', mqsc_qualifier: 'TOPIC',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        # Execute the MQSC +DELETE AUTHINFO+ command.
        #
        # @param name [String, nil] object name
        # @param request_parameters [Hash{String => Object}, nil] request attributes
        # @param response_parameters [Array<String>, nil] response attributes
        # @return [nil]
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def delete_authinfo(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'DELETE', mqsc_qualifier: 'AUTHINFO',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        # Execute the MQSC +DELETE AUTHREC+ command.
        #
        # @param name [String, nil] object name
        # @param request_parameters [Hash{String => Object}, nil] request attributes
        # @param response_parameters [Array<String>, nil] response attributes
        # @return [nil]
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def delete_authrec(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'DELETE', mqsc_qualifier: 'AUTHREC',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        # Execute the MQSC +DELETE BUFFPOOL+ command.
        #
        # @param name [String, nil] object name
        # @param request_parameters [Hash{String => Object}, nil] request attributes
        # @param response_parameters [Array<String>, nil] response attributes
        # @return [nil]
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def delete_buffpool(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'DELETE', mqsc_qualifier: 'BUFFPOOL',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        # Execute the MQSC +DELETE CFSTRUCT+ command.
        #
        # @param name [String, nil] object name
        # @param request_parameters [Hash{String => Object}, nil] request attributes
        # @param response_parameters [Array<String>, nil] response attributes
        # @return [nil]
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def delete_cfstruct(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'DELETE', mqsc_qualifier: 'CFSTRUCT',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        # Execute the MQSC +DELETE COMMINFO+ command.
        #
        # @param name [String, nil] object name
        # @param request_parameters [Hash{String => Object}, nil] request attributes
        # @param response_parameters [Array<String>, nil] response attributes
        # @return [nil]
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def delete_comminfo(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'DELETE', mqsc_qualifier: 'COMMINFO',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        # Execute the MQSC +DELETE LISTENER+ command.
        #
        # @param name [String, nil] object name
        # @param request_parameters [Hash{String => Object}, nil] request attributes
        # @param response_parameters [Array<String>, nil] response attributes
        # @return [nil]
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def delete_listener(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'DELETE', mqsc_qualifier: 'LISTENER',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        # Execute the MQSC +DELETE NAMELIST+ command.
        #
        # @param name [String, nil] object name
        # @param request_parameters [Hash{String => Object}, nil] request attributes
        # @param response_parameters [Array<String>, nil] response attributes
        # @return [nil]
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def delete_namelist(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'DELETE', mqsc_qualifier: 'NAMELIST',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        # Execute the MQSC +DELETE POLICY+ command.
        #
        # @param name [String, nil] object name
        # @param request_parameters [Hash{String => Object}, nil] request attributes
        # @param response_parameters [Array<String>, nil] response attributes
        # @return [nil]
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def delete_policy(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'DELETE', mqsc_qualifier: 'POLICY',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        # Execute the MQSC +DELETE PROCESS+ command.
        #
        # @param name [String, nil] object name
        # @param request_parameters [Hash{String => Object}, nil] request attributes
        # @param response_parameters [Array<String>, nil] response attributes
        # @return [nil]
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def delete_process(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'DELETE', mqsc_qualifier: 'PROCESS',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        # Execute the MQSC +DELETE PSID+ command.
        #
        # @param name [String, nil] object name
        # @param request_parameters [Hash{String => Object}, nil] request attributes
        # @param response_parameters [Array<String>, nil] response attributes
        # @return [nil]
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def delete_psid(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'DELETE', mqsc_qualifier: 'PSID',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        # Execute the MQSC +DELETE QALIAS+ command.
        #
        # @param name [String, nil] object name
        # @param request_parameters [Hash{String => Object}, nil] request attributes
        # @param response_parameters [Array<String>, nil] response attributes
        # @return [nil]
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def delete_qalias(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'DELETE', mqsc_qualifier: 'QALIAS',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        # Execute the MQSC +DELETE QLOCAL+ command.
        #
        # @param name [String, nil] object name
        # @param request_parameters [Hash{String => Object}, nil] request attributes
        # @param response_parameters [Array<String>, nil] response attributes
        # @return [nil]
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def delete_qlocal(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'DELETE', mqsc_qualifier: 'QLOCAL',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        # Execute the MQSC +DELETE QMODEL+ command.
        #
        # @param name [String, nil] object name
        # @param request_parameters [Hash{String => Object}, nil] request attributes
        # @param response_parameters [Array<String>, nil] response attributes
        # @return [nil]
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def delete_qmodel(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'DELETE', mqsc_qualifier: 'QMODEL',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        # Execute the MQSC +DELETE QREMOTE+ command.
        #
        # @param name [String, nil] object name
        # @param request_parameters [Hash{String => Object}, nil] request attributes
        # @param response_parameters [Array<String>, nil] response attributes
        # @return [nil]
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def delete_qremote(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'DELETE', mqsc_qualifier: 'QREMOTE',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        # Execute the MQSC +DELETE SERVICE+ command.
        #
        # @param name [String, nil] object name
        # @param request_parameters [Hash{String => Object}, nil] request attributes
        # @param response_parameters [Array<String>, nil] response attributes
        # @return [nil]
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def delete_service(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'DELETE', mqsc_qualifier: 'SERVICE',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        # Execute the MQSC +DELETE STGCLASS+ command.
        #
        # @param name [String, nil] object name
        # @param request_parameters [Hash{String => Object}, nil] request attributes
        # @param response_parameters [Array<String>, nil] response attributes
        # @return [nil]
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def delete_stgclass(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'DELETE', mqsc_qualifier: 'STGCLASS',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        # Execute the MQSC +DELETE SUB+ command.
        #
        # @param name [String, nil] object name
        # @param request_parameters [Hash{String => Object}, nil] request attributes
        # @param response_parameters [Array<String>, nil] response attributes
        # @return [nil]
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def delete_sub(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'DELETE', mqsc_qualifier: 'SUB',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        # Execute the MQSC +DELETE TOPIC+ command.
        #
        # @param name [String, nil] object name
        # @param request_parameters [Hash{String => Object}, nil] request attributes
        # @param response_parameters [Array<String>, nil] response attributes
        # @return [nil]
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def delete_topic(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'DELETE', mqsc_qualifier: 'TOPIC',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        # Execute the MQSC +DISPLAY APSTATUS+ command.
        #
        # @param name [String] object name or pattern
        # @param request_parameters [Hash{String => Object}, nil] request attributes
        # @param response_parameters [Array<String>, nil] response attributes to return
        # @param where [String, nil] filter expression
        # @return [Array<Hash{String => Object}>] parameter hashes
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def display_apstatus(name, request_parameters: nil, response_parameters: nil, where: nil)
          mqsc_command(
            command: 'DISPLAY', mqsc_qualifier: 'APSTATUS',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters, where: where
          )
        end

        # Execute the MQSC +DISPLAY ARCHIVE+ command.
        #
        # @param name [String] object name or pattern
        # @param request_parameters [Hash{String => Object}, nil] request attributes
        # @param response_parameters [Array<String>, nil] response attributes to return
        # @param where [String, nil] filter expression
        # @return [Array<Hash{String => Object}>] parameter hashes
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def display_archive(name, request_parameters: nil, response_parameters: nil, where: nil)
          mqsc_command(
            command: 'DISPLAY', mqsc_qualifier: 'ARCHIVE',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters, where: where
          )
        end

        # Execute the MQSC +DISPLAY AUTHINFO+ command.
        #
        # @param name [String] object name or pattern
        # @param request_parameters [Hash{String => Object}, nil] request attributes
        # @param response_parameters [Array<String>, nil] response attributes to return
        # @param where [String, nil] filter expression
        # @return [Array<Hash{String => Object}>] parameter hashes
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def display_authinfo(name, request_parameters: nil, response_parameters: nil, where: nil)
          mqsc_command(
            command: 'DISPLAY', mqsc_qualifier: 'AUTHINFO',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters, where: where
          )
        end

        # Execute the MQSC +DISPLAY AUTHREC+ command.
        #
        # @param name [String] object name or pattern
        # @param request_parameters [Hash{String => Object}, nil] request attributes
        # @param response_parameters [Array<String>, nil] response attributes to return
        # @param where [String, nil] filter expression
        # @return [Array<Hash{String => Object}>] parameter hashes
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def display_authrec(name, request_parameters: nil, response_parameters: nil, where: nil)
          mqsc_command(
            command: 'DISPLAY', mqsc_qualifier: 'AUTHREC',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters, where: where
          )
        end

        # Execute the MQSC +DISPLAY AUTHSERV+ command.
        #
        # @param name [String] object name or pattern
        # @param request_parameters [Hash{String => Object}, nil] request attributes
        # @param response_parameters [Array<String>, nil] response attributes to return
        # @param where [String, nil] filter expression
        # @return [Array<Hash{String => Object}>] parameter hashes
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def display_authserv(name, request_parameters: nil, response_parameters: nil, where: nil)
          mqsc_command(
            command: 'DISPLAY', mqsc_qualifier: 'AUTHSERV',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters, where: where
          )
        end

        # Execute the MQSC +DISPLAY CFSTATUS+ command.
        #
        # @param name [String] object name or pattern
        # @param request_parameters [Hash{String => Object}, nil] request attributes
        # @param response_parameters [Array<String>, nil] response attributes to return
        # @param where [String, nil] filter expression
        # @return [Array<Hash{String => Object}>] parameter hashes
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def display_cfstatus(name, request_parameters: nil, response_parameters: nil, where: nil)
          mqsc_command(
            command: 'DISPLAY', mqsc_qualifier: 'CFSTATUS',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters, where: where
          )
        end

        # Execute the MQSC +DISPLAY CFSTRUCT+ command.
        #
        # @param name [String] object name or pattern
        # @param request_parameters [Hash{String => Object}, nil] request attributes
        # @param response_parameters [Array<String>, nil] response attributes to return
        # @param where [String, nil] filter expression
        # @return [Array<Hash{String => Object}>] parameter hashes
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def display_cfstruct(name, request_parameters: nil, response_parameters: nil, where: nil)
          mqsc_command(
            command: 'DISPLAY', mqsc_qualifier: 'CFSTRUCT',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters, where: where
          )
        end

        # Execute the MQSC +DISPLAY CHINIT+ command.
        #
        # @param name [String] object name or pattern
        # @param request_parameters [Hash{String => Object}, nil] request attributes
        # @param response_parameters [Array<String>, nil] response attributes to return
        # @param where [String, nil] filter expression
        # @return [Array<Hash{String => Object}>] parameter hashes
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def display_chinit(name, request_parameters: nil, response_parameters: nil, where: nil)
          mqsc_command(
            command: 'DISPLAY', mqsc_qualifier: 'CHINIT',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters, where: where
          )
        end

        # Execute the MQSC +DISPLAY CHLAUTH+ command.
        #
        # @param name [String] object name or pattern
        # @param request_parameters [Hash{String => Object}, nil] request attributes
        # @param response_parameters [Array<String>, nil] response attributes to return
        # @param where [String, nil] filter expression
        # @return [Array<Hash{String => Object}>] parameter hashes
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def display_chlauth(name, request_parameters: nil, response_parameters: nil, where: nil)
          mqsc_command(
            command: 'DISPLAY', mqsc_qualifier: 'CHLAUTH',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters, where: where
          )
        end

        # Execute the MQSC +DISPLAY CHSTATUS+ command.
        #
        # @param name [String] object name or pattern
        # @param request_parameters [Hash{String => Object}, nil] request attributes
        # @param response_parameters [Array<String>, nil] response attributes to return
        # @param where [String, nil] filter expression
        # @return [Array<Hash{String => Object}>] parameter hashes
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def display_chstatus(name, request_parameters: nil, response_parameters: nil, where: nil)
          mqsc_command(
            command: 'DISPLAY', mqsc_qualifier: 'CHSTATUS',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters, where: where
          )
        end

        # Execute the MQSC +DISPLAY CLUSQMGR+ command.
        #
        # @param name [String] object name or pattern
        # @param request_parameters [Hash{String => Object}, nil] request attributes
        # @param response_parameters [Array<String>, nil] response attributes to return
        # @param where [String, nil] filter expression
        # @return [Array<Hash{String => Object}>] parameter hashes
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def display_clusqmgr(name, request_parameters: nil, response_parameters: nil, where: nil)
          mqsc_command(
            command: 'DISPLAY', mqsc_qualifier: 'CLUSQMGR',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters, where: where
          )
        end

        # Execute the MQSC +DISPLAY COMMINFO+ command.
        #
        # @param name [String] object name or pattern
        # @param request_parameters [Hash{String => Object}, nil] request attributes
        # @param response_parameters [Array<String>, nil] response attributes to return
        # @param where [String, nil] filter expression
        # @return [Array<Hash{String => Object}>] parameter hashes
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def display_comminfo(name, request_parameters: nil, response_parameters: nil, where: nil)
          mqsc_command(
            command: 'DISPLAY', mqsc_qualifier: 'COMMINFO',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters, where: where
          )
        end

        # Execute the MQSC +DISPLAY CONN+ command.
        #
        # @param name [String] object name or pattern
        # @param request_parameters [Hash{String => Object}, nil] request attributes
        # @param response_parameters [Array<String>, nil] response attributes to return
        # @param where [String, nil] filter expression
        # @return [Array<Hash{String => Object}>] parameter hashes
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def display_conn(name, request_parameters: nil, response_parameters: nil, where: nil)
          mqsc_command(
            command: 'DISPLAY', mqsc_qualifier: 'CONN',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters, where: where
          )
        end

        # Execute the MQSC +DISPLAY ENTAUTH+ command.
        #
        # @param name [String] object name or pattern
        # @param request_parameters [Hash{String => Object}, nil] request attributes
        # @param response_parameters [Array<String>, nil] response attributes to return
        # @param where [String, nil] filter expression
        # @return [Array<Hash{String => Object}>] parameter hashes
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def display_entauth(name, request_parameters: nil, response_parameters: nil, where: nil)
          mqsc_command(
            command: 'DISPLAY', mqsc_qualifier: 'ENTAUTH',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters, where: where
          )
        end

        # Execute the MQSC +DISPLAY GROUP+ command.
        #
        # @param name [String] object name or pattern
        # @param request_parameters [Hash{String => Object}, nil] request attributes
        # @param response_parameters [Array<String>, nil] response attributes to return
        # @param where [String, nil] filter expression
        # @return [Array<Hash{String => Object}>] parameter hashes
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def display_group(name, request_parameters: nil, response_parameters: nil, where: nil)
          mqsc_command(
            command: 'DISPLAY', mqsc_qualifier: 'GROUP',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters, where: where
          )
        end

        # Execute the MQSC +DISPLAY LISTENER+ command.
        #
        # @param name [String] object name or pattern
        # @param request_parameters [Hash{String => Object}, nil] request attributes
        # @param response_parameters [Array<String>, nil] response attributes to return
        # @param where [String, nil] filter expression
        # @return [Array<Hash{String => Object}>] parameter hashes
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def display_listener(name, request_parameters: nil, response_parameters: nil, where: nil)
          mqsc_command(
            command: 'DISPLAY', mqsc_qualifier: 'LISTENER',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters, where: where
          )
        end

        # Execute the MQSC +DISPLAY LOG+ command.
        #
        # @param name [String] object name or pattern
        # @param request_parameters [Hash{String => Object}, nil] request attributes
        # @param response_parameters [Array<String>, nil] response attributes to return
        # @param where [String, nil] filter expression
        # @return [Array<Hash{String => Object}>] parameter hashes
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def display_log(name, request_parameters: nil, response_parameters: nil, where: nil)
          mqsc_command(
            command: 'DISPLAY', mqsc_qualifier: 'LOG',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters, where: where
          )
        end

        # Execute the MQSC +DISPLAY LSSTATUS+ command.
        #
        # @param name [String] object name or pattern
        # @param request_parameters [Hash{String => Object}, nil] request attributes
        # @param response_parameters [Array<String>, nil] response attributes to return
        # @param where [String, nil] filter expression
        # @return [Array<Hash{String => Object}>] parameter hashes
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def display_lsstatus(name, request_parameters: nil, response_parameters: nil, where: nil)
          mqsc_command(
            command: 'DISPLAY', mqsc_qualifier: 'LSSTATUS',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters, where: where
          )
        end

        # Execute the MQSC +DISPLAY MAXSMSGS+ command.
        #
        # @param name [String] object name or pattern
        # @param request_parameters [Hash{String => Object}, nil] request attributes
        # @param response_parameters [Array<String>, nil] response attributes to return
        # @param where [String, nil] filter expression
        # @return [Array<Hash{String => Object}>] parameter hashes
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def display_maxsmsgs(name, request_parameters: nil, response_parameters: nil, where: nil)
          mqsc_command(
            command: 'DISPLAY', mqsc_qualifier: 'MAXSMSGS',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters, where: where
          )
        end

        # Execute the MQSC +DISPLAY NAMELIST+ command.
        #
        # @param name [String] object name or pattern
        # @param request_parameters [Hash{String => Object}, nil] request attributes
        # @param response_parameters [Array<String>, nil] response attributes to return
        # @param where [String, nil] filter expression
        # @return [Array<Hash{String => Object}>] parameter hashes
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def display_namelist(name, request_parameters: nil, response_parameters: nil, where: nil)
          mqsc_command(
            command: 'DISPLAY', mqsc_qualifier: 'NAMELIST',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters, where: where
          )
        end

        # Execute the MQSC +DISPLAY POLICY+ command.
        #
        # @param name [String] object name or pattern
        # @param request_parameters [Hash{String => Object}, nil] request attributes
        # @param response_parameters [Array<String>, nil] response attributes to return
        # @param where [String, nil] filter expression
        # @return [Array<Hash{String => Object}>] parameter hashes
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def display_policy(name, request_parameters: nil, response_parameters: nil, where: nil)
          mqsc_command(
            command: 'DISPLAY', mqsc_qualifier: 'POLICY',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters, where: where
          )
        end

        # Execute the MQSC +DISPLAY PROCESS+ command.
        #
        # @param name [String] object name or pattern
        # @param request_parameters [Hash{String => Object}, nil] request attributes
        # @param response_parameters [Array<String>, nil] response attributes to return
        # @param where [String, nil] filter expression
        # @return [Array<Hash{String => Object}>] parameter hashes
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def display_process(name, request_parameters: nil, response_parameters: nil, where: nil)
          mqsc_command(
            command: 'DISPLAY', mqsc_qualifier: 'PROCESS',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters, where: where
          )
        end

        # Execute the MQSC +DISPLAY PUBSUB+ command.
        #
        # @param name [String] object name or pattern
        # @param request_parameters [Hash{String => Object}, nil] request attributes
        # @param response_parameters [Array<String>, nil] response attributes to return
        # @param where [String, nil] filter expression
        # @return [Array<Hash{String => Object}>] parameter hashes
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def display_pubsub(name, request_parameters: nil, response_parameters: nil, where: nil)
          mqsc_command(
            command: 'DISPLAY', mqsc_qualifier: 'PUBSUB',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters, where: where
          )
        end

        # Execute the MQSC +DISPLAY QSTATUS+ command.
        #
        # @param name [String] object name or pattern
        # @param request_parameters [Hash{String => Object}, nil] request attributes
        # @param response_parameters [Array<String>, nil] response attributes to return
        # @param where [String, nil] filter expression
        # @return [Array<Hash{String => Object}>] parameter hashes
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def display_qstatus(name, request_parameters: nil, response_parameters: nil, where: nil)
          mqsc_command(
            command: 'DISPLAY', mqsc_qualifier: 'QSTATUS',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters, where: where
          )
        end

        # Execute the MQSC +DISPLAY SBSTATUS+ command.
        #
        # @param name [String] object name or pattern
        # @param request_parameters [Hash{String => Object}, nil] request attributes
        # @param response_parameters [Array<String>, nil] response attributes to return
        # @param where [String, nil] filter expression
        # @return [Array<Hash{String => Object}>] parameter hashes
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def display_sbstatus(name, request_parameters: nil, response_parameters: nil, where: nil)
          mqsc_command(
            command: 'DISPLAY', mqsc_qualifier: 'SBSTATUS',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters, where: where
          )
        end

        # Execute the MQSC +DISPLAY SECURITY+ command.
        #
        # @param name [String] object name or pattern
        # @param request_parameters [Hash{String => Object}, nil] request attributes
        # @param response_parameters [Array<String>, nil] response attributes to return
        # @param where [String, nil] filter expression
        # @return [Array<Hash{String => Object}>] parameter hashes
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def display_security(name, request_parameters: nil, response_parameters: nil, where: nil)
          mqsc_command(
            command: 'DISPLAY', mqsc_qualifier: 'SECURITY',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters, where: where
          )
        end

        # Execute the MQSC +DISPLAY SERVICE+ command.
        #
        # @param name [String] object name or pattern
        # @param request_parameters [Hash{String => Object}, nil] request attributes
        # @param response_parameters [Array<String>, nil] response attributes to return
        # @param where [String, nil] filter expression
        # @return [Array<Hash{String => Object}>] parameter hashes
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def display_service(name, request_parameters: nil, response_parameters: nil, where: nil)
          mqsc_command(
            command: 'DISPLAY', mqsc_qualifier: 'SERVICE',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters, where: where
          )
        end

        # Execute the MQSC +DISPLAY SMDS+ command.
        #
        # @param name [String] object name or pattern
        # @param request_parameters [Hash{String => Object}, nil] request attributes
        # @param response_parameters [Array<String>, nil] response attributes to return
        # @param where [String, nil] filter expression
        # @return [Array<Hash{String => Object}>] parameter hashes
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def display_smds(name, request_parameters: nil, response_parameters: nil, where: nil)
          mqsc_command(
            command: 'DISPLAY', mqsc_qualifier: 'SMDS',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters, where: where
          )
        end

        # Execute the MQSC +DISPLAY SMDSCONN+ command.
        #
        # @param name [String] object name or pattern
        # @param request_parameters [Hash{String => Object}, nil] request attributes
        # @param response_parameters [Array<String>, nil] response attributes to return
        # @param where [String, nil] filter expression
        # @return [Array<Hash{String => Object}>] parameter hashes
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def display_smdsconn(name, request_parameters: nil, response_parameters: nil, where: nil)
          mqsc_command(
            command: 'DISPLAY', mqsc_qualifier: 'SMDSCONN',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters, where: where
          )
        end

        # Execute the MQSC +DISPLAY STGCLASS+ command.
        #
        # @param name [String] object name or pattern
        # @param request_parameters [Hash{String => Object}, nil] request attributes
        # @param response_parameters [Array<String>, nil] response attributes to return
        # @param where [String, nil] filter expression
        # @return [Array<Hash{String => Object}>] parameter hashes
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def display_stgclass(name, request_parameters: nil, response_parameters: nil, where: nil)
          mqsc_command(
            command: 'DISPLAY', mqsc_qualifier: 'STGCLASS',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters, where: where
          )
        end

        # Execute the MQSC +DISPLAY SUB+ command.
        #
        # @param name [String] object name or pattern
        # @param request_parameters [Hash{String => Object}, nil] request attributes
        # @param response_parameters [Array<String>, nil] response attributes to return
        # @param where [String, nil] filter expression
        # @return [Array<Hash{String => Object}>] parameter hashes
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def display_sub(name, request_parameters: nil, response_parameters: nil, where: nil)
          mqsc_command(
            command: 'DISPLAY', mqsc_qualifier: 'SUB',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters, where: where
          )
        end

        # Execute the MQSC +DISPLAY SVSTATUS+ command.
        #
        # @param name [String] object name or pattern
        # @param request_parameters [Hash{String => Object}, nil] request attributes
        # @param response_parameters [Array<String>, nil] response attributes to return
        # @param where [String, nil] filter expression
        # @return [Array<Hash{String => Object}>] parameter hashes
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def display_svstatus(name, request_parameters: nil, response_parameters: nil, where: nil)
          mqsc_command(
            command: 'DISPLAY', mqsc_qualifier: 'SVSTATUS',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters, where: where
          )
        end

        # Execute the MQSC +DISPLAY SYSTEM+ command.
        #
        # @param name [String] object name or pattern
        # @param request_parameters [Hash{String => Object}, nil] request attributes
        # @param response_parameters [Array<String>, nil] response attributes to return
        # @param where [String, nil] filter expression
        # @return [Array<Hash{String => Object}>] parameter hashes
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def display_system(name, request_parameters: nil, response_parameters: nil, where: nil)
          mqsc_command(
            command: 'DISPLAY', mqsc_qualifier: 'SYSTEM',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters, where: where
          )
        end

        # Execute the MQSC +DISPLAY TCLUSTER+ command.
        #
        # @param name [String] object name or pattern
        # @param request_parameters [Hash{String => Object}, nil] request attributes
        # @param response_parameters [Array<String>, nil] response attributes to return
        # @param where [String, nil] filter expression
        # @return [Array<Hash{String => Object}>] parameter hashes
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def display_tcluster(name, request_parameters: nil, response_parameters: nil, where: nil)
          mqsc_command(
            command: 'DISPLAY', mqsc_qualifier: 'TCLUSTER',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters, where: where
          )
        end

        # Execute the MQSC +DISPLAY THREAD+ command.
        #
        # @param name [String] object name or pattern
        # @param request_parameters [Hash{String => Object}, nil] request attributes
        # @param response_parameters [Array<String>, nil] response attributes to return
        # @param where [String, nil] filter expression
        # @return [Array<Hash{String => Object}>] parameter hashes
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def display_thread(name, request_parameters: nil, response_parameters: nil, where: nil)
          mqsc_command(
            command: 'DISPLAY', mqsc_qualifier: 'THREAD',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters, where: where
          )
        end

        # Execute the MQSC +DISPLAY TOPIC+ command.
        #
        # @param name [String] object name or pattern
        # @param request_parameters [Hash{String => Object}, nil] request attributes
        # @param response_parameters [Array<String>, nil] response attributes to return
        # @param where [String, nil] filter expression
        # @return [Array<Hash{String => Object}>] parameter hashes
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def display_topic(name, request_parameters: nil, response_parameters: nil, where: nil)
          mqsc_command(
            command: 'DISPLAY', mqsc_qualifier: 'TOPIC',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters, where: where
          )
        end

        # Execute the MQSC +DISPLAY TPSTATUS+ command.
        #
        # @param name [String] object name or pattern
        # @param request_parameters [Hash{String => Object}, nil] request attributes
        # @param response_parameters [Array<String>, nil] response attributes to return
        # @param where [String, nil] filter expression
        # @return [Array<Hash{String => Object}>] parameter hashes
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def display_tpstatus(name, request_parameters: nil, response_parameters: nil, where: nil)
          mqsc_command(
            command: 'DISPLAY', mqsc_qualifier: 'TPSTATUS',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters, where: where
          )
        end

        # Execute the MQSC +DISPLAY TRACE+ command.
        #
        # @param name [String] object name or pattern
        # @param request_parameters [Hash{String => Object}, nil] request attributes
        # @param response_parameters [Array<String>, nil] response attributes to return
        # @param where [String, nil] filter expression
        # @return [Array<Hash{String => Object}>] parameter hashes
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def display_trace(name, request_parameters: nil, response_parameters: nil, where: nil)
          mqsc_command(
            command: 'DISPLAY', mqsc_qualifier: 'TRACE',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters, where: where
          )
        end

        # Execute the MQSC +DISPLAY USAGE+ command.
        #
        # @param name [String] object name or pattern
        # @param request_parameters [Hash{String => Object}, nil] request attributes
        # @param response_parameters [Array<String>, nil] response attributes to return
        # @param where [String, nil] filter expression
        # @return [Array<Hash{String => Object}>] parameter hashes
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def display_usage(name, request_parameters: nil, response_parameters: nil, where: nil)
          mqsc_command(
            command: 'DISPLAY', mqsc_qualifier: 'USAGE',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters, where: where
          )
        end

        # Execute the MQSC +MOVE QLOCAL+ command.
        #
        # @param name [String, nil] object name
        # @param request_parameters [Hash{String => Object}, nil] request attributes
        # @param response_parameters [Array<String>, nil] response attributes
        # @return [nil]
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def move_qlocal(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'MOVE', mqsc_qualifier: 'QLOCAL',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        # Execute the MQSC +PING CHANNEL+ command.
        #
        # @param name [String, nil] object name
        # @param request_parameters [Hash{String => Object}, nil] request attributes
        # @param response_parameters [Array<String>, nil] response attributes
        # @return [nil]
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def ping_channel(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'PING', mqsc_qualifier: 'CHANNEL',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        # Execute the MQSC +PING QMGR+ command.
        #
        # @param request_parameters [Hash{String => Object}, nil] request attributes
        # @param response_parameters [Array<String>, nil] response attributes
        # @return [nil]
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def ping_qmgr(request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'PING', mqsc_qualifier: 'QMGR',
            name: nil, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        # Execute the MQSC +PURGE CHANNEL+ command.
        #
        # @param name [String, nil] object name
        # @param request_parameters [Hash{String => Object}, nil] request attributes
        # @param response_parameters [Array<String>, nil] response attributes
        # @return [nil]
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def purge_channel(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'PURGE', mqsc_qualifier: 'CHANNEL',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        # Execute the MQSC +RECOVER BSDS+ command.
        #
        # @param name [String, nil] object name
        # @param request_parameters [Hash{String => Object}, nil] request attributes
        # @param response_parameters [Array<String>, nil] response attributes
        # @return [nil]
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def recover_bsds(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'RECOVER', mqsc_qualifier: 'BSDS',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        # Execute the MQSC +RECOVER CFSTRUCT+ command.
        #
        # @param name [String, nil] object name
        # @param request_parameters [Hash{String => Object}, nil] request attributes
        # @param response_parameters [Array<String>, nil] response attributes
        # @return [nil]
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def recover_cfstruct(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'RECOVER', mqsc_qualifier: 'CFSTRUCT',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        # Execute the MQSC +REFRESH CLUSTER+ command.
        #
        # @param name [String, nil] object name
        # @param request_parameters [Hash{String => Object}, nil] request attributes
        # @param response_parameters [Array<String>, nil] response attributes
        # @return [nil]
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def refresh_cluster(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'REFRESH', mqsc_qualifier: 'CLUSTER',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        # Execute the MQSC +REFRESH QMGR+ command.
        #
        # @param request_parameters [Hash{String => Object}, nil] request attributes
        # @param response_parameters [Array<String>, nil] response attributes
        # @return [nil]
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def refresh_qmgr(request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'REFRESH', mqsc_qualifier: 'QMGR',
            name: nil, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        # Execute the MQSC +REFRESH SECURITY+ command.
        #
        # @param name [String, nil] object name
        # @param request_parameters [Hash{String => Object}, nil] request attributes
        # @param response_parameters [Array<String>, nil] response attributes
        # @return [nil]
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def refresh_security(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'REFRESH', mqsc_qualifier: 'SECURITY',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        # Execute the MQSC +RESET CFSTRUCT+ command.
        #
        # @param name [String, nil] object name
        # @param request_parameters [Hash{String => Object}, nil] request attributes
        # @param response_parameters [Array<String>, nil] response attributes
        # @return [nil]
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def reset_cfstruct(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'RESET', mqsc_qualifier: 'CFSTRUCT',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        # Execute the MQSC +RESET CHANNEL+ command.
        #
        # @param name [String, nil] object name
        # @param request_parameters [Hash{String => Object}, nil] request attributes
        # @param response_parameters [Array<String>, nil] response attributes
        # @return [nil]
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def reset_channel(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'RESET', mqsc_qualifier: 'CHANNEL',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        # Execute the MQSC +RESET CLUSTER+ command.
        #
        # @param name [String, nil] object name
        # @param request_parameters [Hash{String => Object}, nil] request attributes
        # @param response_parameters [Array<String>, nil] response attributes
        # @return [nil]
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def reset_cluster(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'RESET', mqsc_qualifier: 'CLUSTER',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        # Execute the MQSC +RESET QMGR+ command.
        #
        # @param request_parameters [Hash{String => Object}, nil] request attributes
        # @param response_parameters [Array<String>, nil] response attributes
        # @return [nil]
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def reset_qmgr(request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'RESET', mqsc_qualifier: 'QMGR',
            name: nil, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        # Execute the MQSC +RESET QSTATS+ command.
        #
        # @param name [String, nil] object name
        # @param request_parameters [Hash{String => Object}, nil] request attributes
        # @param response_parameters [Array<String>, nil] response attributes
        # @return [nil]
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def reset_qstats(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'RESET', mqsc_qualifier: 'QSTATS',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        # Execute the MQSC +RESET SMDS+ command.
        #
        # @param name [String, nil] object name
        # @param request_parameters [Hash{String => Object}, nil] request attributes
        # @param response_parameters [Array<String>, nil] response attributes
        # @return [nil]
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def reset_smds(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'RESET', mqsc_qualifier: 'SMDS',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        # Execute the MQSC +RESET TPIPE+ command.
        #
        # @param name [String, nil] object name
        # @param request_parameters [Hash{String => Object}, nil] request attributes
        # @param response_parameters [Array<String>, nil] response attributes
        # @return [nil]
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def reset_tpipe(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'RESET', mqsc_qualifier: 'TPIPE',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        # Execute the MQSC +RESOLVE CHANNEL+ command.
        #
        # @param name [String, nil] object name
        # @param request_parameters [Hash{String => Object}, nil] request attributes
        # @param response_parameters [Array<String>, nil] response attributes
        # @return [nil]
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def resolve_channel(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'RESOLVE', mqsc_qualifier: 'CHANNEL',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        # Execute the MQSC +RESOLVE INDOUBT+ command.
        #
        # @param name [String, nil] object name
        # @param request_parameters [Hash{String => Object}, nil] request attributes
        # @param response_parameters [Array<String>, nil] response attributes
        # @return [nil]
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def resolve_indoubt(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'RESOLVE', mqsc_qualifier: 'INDOUBT',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        # Execute the MQSC +RESUME QMGR+ command.
        #
        # @param request_parameters [Hash{String => Object}, nil] request attributes
        # @param response_parameters [Array<String>, nil] response attributes
        # @return [nil]
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def resume_qmgr(request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'RESUME', mqsc_qualifier: 'QMGR',
            name: nil, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        # Execute the MQSC +RVERIFY SECURITY+ command.
        #
        # @param name [String, nil] object name
        # @param request_parameters [Hash{String => Object}, nil] request attributes
        # @param response_parameters [Array<String>, nil] response attributes
        # @return [nil]
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def rverify_security(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'RVERIFY', mqsc_qualifier: 'SECURITY',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        # Execute the MQSC +SET ARCHIVE+ command.
        #
        # @param name [String, nil] object name
        # @param request_parameters [Hash{String => Object}, nil] request attributes
        # @param response_parameters [Array<String>, nil] response attributes
        # @return [nil]
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def set_archive(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'SET', mqsc_qualifier: 'ARCHIVE',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        # Execute the MQSC +SET AUTHREC+ command.
        #
        # @param name [String, nil] object name
        # @param request_parameters [Hash{String => Object}, nil] request attributes
        # @param response_parameters [Array<String>, nil] response attributes
        # @return [nil]
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def set_authrec(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'SET', mqsc_qualifier: 'AUTHREC',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        # Execute the MQSC +SET CHLAUTH+ command.
        #
        # @param name [String, nil] object name
        # @param request_parameters [Hash{String => Object}, nil] request attributes
        # @param response_parameters [Array<String>, nil] response attributes
        # @return [nil]
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def set_chlauth(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'SET', mqsc_qualifier: 'CHLAUTH',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        # Execute the MQSC +SET LOG+ command.
        #
        # @param name [String, nil] object name
        # @param request_parameters [Hash{String => Object}, nil] request attributes
        # @param response_parameters [Array<String>, nil] response attributes
        # @return [nil]
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def set_log(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'SET', mqsc_qualifier: 'LOG',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        # Execute the MQSC +SET POLICY+ command.
        #
        # @param name [String, nil] object name
        # @param request_parameters [Hash{String => Object}, nil] request attributes
        # @param response_parameters [Array<String>, nil] response attributes
        # @return [nil]
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def set_policy(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'SET', mqsc_qualifier: 'POLICY',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        # Execute the MQSC +SET SYSTEM+ command.
        #
        # @param name [String, nil] object name
        # @param request_parameters [Hash{String => Object}, nil] request attributes
        # @param response_parameters [Array<String>, nil] response attributes
        # @return [nil]
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def set_system(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'SET', mqsc_qualifier: 'SYSTEM',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        # Execute the MQSC +START CHANNEL+ command.
        #
        # @param name [String, nil] object name
        # @param request_parameters [Hash{String => Object}, nil] request attributes
        # @param response_parameters [Array<String>, nil] response attributes
        # @return [nil]
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def start_channel(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'START', mqsc_qualifier: 'CHANNEL',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        # Execute the MQSC +START CHINIT+ command.
        #
        # @param name [String, nil] object name
        # @param request_parameters [Hash{String => Object}, nil] request attributes
        # @param response_parameters [Array<String>, nil] response attributes
        # @return [nil]
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def start_chinit(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'START', mqsc_qualifier: 'CHINIT',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        # Execute the MQSC +START CMDSERV+ command.
        #
        # @param request_parameters [Hash{String => Object}, nil] request attributes
        # @param response_parameters [Array<String>, nil] response attributes
        # @return [nil]
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def start_cmdserv(request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'START', mqsc_qualifier: 'CMDSERV',
            name: nil, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        # Execute the MQSC +START LISTENER+ command.
        #
        # @param name [String, nil] object name
        # @param request_parameters [Hash{String => Object}, nil] request attributes
        # @param response_parameters [Array<String>, nil] response attributes
        # @return [nil]
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def start_listener(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'START', mqsc_qualifier: 'LISTENER',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        # Execute the MQSC +START QMGR+ command.
        #
        # @param request_parameters [Hash{String => Object}, nil] request attributes
        # @param response_parameters [Array<String>, nil] response attributes
        # @return [nil]
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def start_qmgr(request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'START', mqsc_qualifier: 'QMGR',
            name: nil, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        # Execute the MQSC +START SERVICE+ command.
        #
        # @param name [String, nil] object name
        # @param request_parameters [Hash{String => Object}, nil] request attributes
        # @param response_parameters [Array<String>, nil] response attributes
        # @return [nil]
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def start_service(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'START', mqsc_qualifier: 'SERVICE',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        # Execute the MQSC +START SMDSCONN+ command.
        #
        # @param name [String, nil] object name
        # @param request_parameters [Hash{String => Object}, nil] request attributes
        # @param response_parameters [Array<String>, nil] response attributes
        # @return [nil]
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def start_smdsconn(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'START', mqsc_qualifier: 'SMDSCONN',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        # Execute the MQSC +START TRACE+ command.
        #
        # @param name [String, nil] object name
        # @param request_parameters [Hash{String => Object}, nil] request attributes
        # @param response_parameters [Array<String>, nil] response attributes
        # @return [nil]
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def start_trace(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'START', mqsc_qualifier: 'TRACE',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        # Execute the MQSC +STOP CHANNEL+ command.
        #
        # @param name [String, nil] object name
        # @param request_parameters [Hash{String => Object}, nil] request attributes
        # @param response_parameters [Array<String>, nil] response attributes
        # @return [nil]
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def stop_channel(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'STOP', mqsc_qualifier: 'CHANNEL',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        # Execute the MQSC +STOP CHINIT+ command.
        #
        # @param name [String, nil] object name
        # @param request_parameters [Hash{String => Object}, nil] request attributes
        # @param response_parameters [Array<String>, nil] response attributes
        # @return [nil]
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def stop_chinit(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'STOP', mqsc_qualifier: 'CHINIT',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        # Execute the MQSC +STOP CMDSERV+ command.
        #
        # @param request_parameters [Hash{String => Object}, nil] request attributes
        # @param response_parameters [Array<String>, nil] response attributes
        # @return [nil]
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def stop_cmdserv(request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'STOP', mqsc_qualifier: 'CMDSERV',
            name: nil, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        # Execute the MQSC +STOP CONN+ command.
        #
        # @param name [String, nil] object name
        # @param request_parameters [Hash{String => Object}, nil] request attributes
        # @param response_parameters [Array<String>, nil] response attributes
        # @return [nil]
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def stop_conn(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'STOP', mqsc_qualifier: 'CONN',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        # Execute the MQSC +STOP LISTENER+ command.
        #
        # @param name [String, nil] object name
        # @param request_parameters [Hash{String => Object}, nil] request attributes
        # @param response_parameters [Array<String>, nil] response attributes
        # @return [nil]
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def stop_listener(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'STOP', mqsc_qualifier: 'LISTENER',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        # Execute the MQSC +STOP QMGR+ command.
        #
        # @param request_parameters [Hash{String => Object}, nil] request attributes
        # @param response_parameters [Array<String>, nil] response attributes
        # @return [nil]
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def stop_qmgr(request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'STOP', mqsc_qualifier: 'QMGR',
            name: nil, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        # Execute the MQSC +STOP SERVICE+ command.
        #
        # @param name [String, nil] object name
        # @param request_parameters [Hash{String => Object}, nil] request attributes
        # @param response_parameters [Array<String>, nil] response attributes
        # @return [nil]
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def stop_service(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'STOP', mqsc_qualifier: 'SERVICE',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        # Execute the MQSC +STOP SMDSCONN+ command.
        #
        # @param name [String, nil] object name
        # @param request_parameters [Hash{String => Object}, nil] request attributes
        # @param response_parameters [Array<String>, nil] response attributes
        # @return [nil]
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def stop_smdsconn(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'STOP', mqsc_qualifier: 'SMDSCONN',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        # Execute the MQSC +STOP TRACE+ command.
        #
        # @param name [String, nil] object name
        # @param request_parameters [Hash{String => Object}, nil] request attributes
        # @param response_parameters [Array<String>, nil] response attributes
        # @return [nil]
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def stop_trace(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'STOP', mqsc_qualifier: 'TRACE',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        # Execute the MQSC +SUSPEND QMGR+ command.
        #
        # @param request_parameters [Hash{String => Object}, nil] request attributes
        # @param response_parameters [Array<String>, nil] response attributes
        # @return [nil]
        # @raise [CommandError] if the MQSC command fails
        # @raise [MappingError] if attribute mapping fails in strict mode
        def suspend_qmgr(request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'SUSPEND', mqsc_qualifier: 'QMGR',
            name: nil, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end
      end
    end
  end
end
