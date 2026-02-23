# frozen_string_literal: true

# This file is generated. Do not edit manually.
# Generated from pymqrest commands.py

module MQ
  module REST
    module Admin
      module Commands
        def display_qmgr(request_parameters: nil, response_parameters: nil)
          objects = mqsc_command(
            command: 'DISPLAY', mqsc_qualifier: 'QMGR',
            name: nil, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          objects.empty? ? nil : objects[0]
        end

        def display_qmstatus(request_parameters: nil, response_parameters: nil)
          objects = mqsc_command(
            command: 'DISPLAY', mqsc_qualifier: 'QMSTATUS',
            name: nil, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          objects.empty? ? nil : objects[0]
        end

        def display_cmdserv(request_parameters: nil, response_parameters: nil)
          objects = mqsc_command(
            command: 'DISPLAY', mqsc_qualifier: 'CMDSERV',
            name: nil, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          objects.empty? ? nil : objects[0]
        end

        def display_queue(name: nil, request_parameters: nil, response_parameters: nil, where: nil)
          mqsc_command(
            command: 'DISPLAY', mqsc_qualifier: 'QUEUE',
            name: name || '*', request_parameters: request_parameters,
            response_parameters: response_parameters, where: where
          )
        end

        def display_channel(name: nil, request_parameters: nil, response_parameters: nil, where: nil)
          mqsc_command(
            command: 'DISPLAY', mqsc_qualifier: 'CHANNEL',
            name: name || '*', request_parameters: request_parameters,
            response_parameters: response_parameters, where: where
          )
        end

        def define_qlocal(name, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'DEFINE', mqsc_qualifier: 'QLOCAL',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        def define_qremote(name, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'DEFINE', mqsc_qualifier: 'QREMOTE',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        def define_qalias(name, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'DEFINE', mqsc_qualifier: 'QALIAS',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        def define_qmodel(name, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'DEFINE', mqsc_qualifier: 'QMODEL',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        def delete_queue(name, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'DELETE', mqsc_qualifier: 'QUEUE',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        def define_channel(name, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'DEFINE', mqsc_qualifier: 'CHANNEL',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        def delete_channel(name, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'DELETE', mqsc_qualifier: 'CHANNEL',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        def alter_authinfo(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'ALTER', mqsc_qualifier: 'AUTHINFO',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        def alter_buffpool(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'ALTER', mqsc_qualifier: 'BUFFPOOL',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        def alter_cfstruct(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'ALTER', mqsc_qualifier: 'CFSTRUCT',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        def alter_channel(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'ALTER', mqsc_qualifier: 'CHANNEL',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        def alter_comminfo(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'ALTER', mqsc_qualifier: 'COMMINFO',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        def alter_listener(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'ALTER', mqsc_qualifier: 'LISTENER',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        def alter_namelist(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'ALTER', mqsc_qualifier: 'NAMELIST',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        def alter_process(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'ALTER', mqsc_qualifier: 'PROCESS',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        def alter_psid(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'ALTER', mqsc_qualifier: 'PSID',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        def alter_qmgr(request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'ALTER', mqsc_qualifier: 'QMGR',
            name: nil, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        def alter_security(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'ALTER', mqsc_qualifier: 'SECURITY',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        def alter_service(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'ALTER', mqsc_qualifier: 'SERVICE',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        def alter_smds(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'ALTER', mqsc_qualifier: 'SMDS',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        def alter_stgclass(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'ALTER', mqsc_qualifier: 'STGCLASS',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        def alter_sub(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'ALTER', mqsc_qualifier: 'SUB',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        def alter_topic(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'ALTER', mqsc_qualifier: 'TOPIC',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        def alter_trace(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'ALTER', mqsc_qualifier: 'TRACE',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        def archive_log(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'ARCHIVE', mqsc_qualifier: 'LOG',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        def backup_cfstruct(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'BACKUP', mqsc_qualifier: 'CFSTRUCT',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        def clear_qlocal(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'CLEAR', mqsc_qualifier: 'QLOCAL',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        def clear_topicstr(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'CLEAR', mqsc_qualifier: 'TOPICSTR',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        def define_authinfo(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'DEFINE', mqsc_qualifier: 'AUTHINFO',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        def define_buffpool(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'DEFINE', mqsc_qualifier: 'BUFFPOOL',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        def define_cfstruct(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'DEFINE', mqsc_qualifier: 'CFSTRUCT',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        def define_comminfo(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'DEFINE', mqsc_qualifier: 'COMMINFO',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        def define_listener(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'DEFINE', mqsc_qualifier: 'LISTENER',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        def define_log(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'DEFINE', mqsc_qualifier: 'LOG',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        def define_maxsmsgs(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'DEFINE', mqsc_qualifier: 'MAXSMSGS',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        def define_namelist(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'DEFINE', mqsc_qualifier: 'NAMELIST',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        def define_process(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'DEFINE', mqsc_qualifier: 'PROCESS',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        def define_psid(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'DEFINE', mqsc_qualifier: 'PSID',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        def define_service(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'DEFINE', mqsc_qualifier: 'SERVICE',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        def define_stgclass(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'DEFINE', mqsc_qualifier: 'STGCLASS',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        def define_sub(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'DEFINE', mqsc_qualifier: 'SUB',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        def define_topic(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'DEFINE', mqsc_qualifier: 'TOPIC',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        def delete_authinfo(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'DELETE', mqsc_qualifier: 'AUTHINFO',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        def delete_authrec(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'DELETE', mqsc_qualifier: 'AUTHREC',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        def delete_buffpool(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'DELETE', mqsc_qualifier: 'BUFFPOOL',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        def delete_cfstruct(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'DELETE', mqsc_qualifier: 'CFSTRUCT',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        def delete_comminfo(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'DELETE', mqsc_qualifier: 'COMMINFO',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        def delete_listener(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'DELETE', mqsc_qualifier: 'LISTENER',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        def delete_namelist(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'DELETE', mqsc_qualifier: 'NAMELIST',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        def delete_policy(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'DELETE', mqsc_qualifier: 'POLICY',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        def delete_process(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'DELETE', mqsc_qualifier: 'PROCESS',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        def delete_psid(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'DELETE', mqsc_qualifier: 'PSID',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        def delete_qalias(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'DELETE', mqsc_qualifier: 'QALIAS',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        def delete_qlocal(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'DELETE', mqsc_qualifier: 'QLOCAL',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        def delete_qmodel(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'DELETE', mqsc_qualifier: 'QMODEL',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        def delete_qremote(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'DELETE', mqsc_qualifier: 'QREMOTE',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        def delete_service(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'DELETE', mqsc_qualifier: 'SERVICE',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        def delete_stgclass(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'DELETE', mqsc_qualifier: 'STGCLASS',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        def delete_sub(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'DELETE', mqsc_qualifier: 'SUB',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        def delete_topic(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'DELETE', mqsc_qualifier: 'TOPIC',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        def display_apstatus(name, request_parameters: nil, response_parameters: nil, where: nil)
          mqsc_command(
            command: 'DISPLAY', mqsc_qualifier: 'APSTATUS',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters, where: where
          )
        end

        def display_archive(name, request_parameters: nil, response_parameters: nil, where: nil)
          mqsc_command(
            command: 'DISPLAY', mqsc_qualifier: 'ARCHIVE',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters, where: where
          )
        end

        def display_authinfo(name, request_parameters: nil, response_parameters: nil, where: nil)
          mqsc_command(
            command: 'DISPLAY', mqsc_qualifier: 'AUTHINFO',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters, where: where
          )
        end

        def display_authrec(name, request_parameters: nil, response_parameters: nil, where: nil)
          mqsc_command(
            command: 'DISPLAY', mqsc_qualifier: 'AUTHREC',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters, where: where
          )
        end

        def display_authserv(name, request_parameters: nil, response_parameters: nil, where: nil)
          mqsc_command(
            command: 'DISPLAY', mqsc_qualifier: 'AUTHSERV',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters, where: where
          )
        end

        def display_cfstatus(name, request_parameters: nil, response_parameters: nil, where: nil)
          mqsc_command(
            command: 'DISPLAY', mqsc_qualifier: 'CFSTATUS',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters, where: where
          )
        end

        def display_cfstruct(name, request_parameters: nil, response_parameters: nil, where: nil)
          mqsc_command(
            command: 'DISPLAY', mqsc_qualifier: 'CFSTRUCT',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters, where: where
          )
        end

        def display_chinit(name, request_parameters: nil, response_parameters: nil, where: nil)
          mqsc_command(
            command: 'DISPLAY', mqsc_qualifier: 'CHINIT',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters, where: where
          )
        end

        def display_chlauth(name, request_parameters: nil, response_parameters: nil, where: nil)
          mqsc_command(
            command: 'DISPLAY', mqsc_qualifier: 'CHLAUTH',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters, where: where
          )
        end

        def display_chstatus(name, request_parameters: nil, response_parameters: nil, where: nil)
          mqsc_command(
            command: 'DISPLAY', mqsc_qualifier: 'CHSTATUS',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters, where: where
          )
        end

        def display_clusqmgr(name, request_parameters: nil, response_parameters: nil, where: nil)
          mqsc_command(
            command: 'DISPLAY', mqsc_qualifier: 'CLUSQMGR',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters, where: where
          )
        end

        def display_comminfo(name, request_parameters: nil, response_parameters: nil, where: nil)
          mqsc_command(
            command: 'DISPLAY', mqsc_qualifier: 'COMMINFO',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters, where: where
          )
        end

        def display_conn(name, request_parameters: nil, response_parameters: nil, where: nil)
          mqsc_command(
            command: 'DISPLAY', mqsc_qualifier: 'CONN',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters, where: where
          )
        end

        def display_entauth(name, request_parameters: nil, response_parameters: nil, where: nil)
          mqsc_command(
            command: 'DISPLAY', mqsc_qualifier: 'ENTAUTH',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters, where: where
          )
        end

        def display_group(name, request_parameters: nil, response_parameters: nil, where: nil)
          mqsc_command(
            command: 'DISPLAY', mqsc_qualifier: 'GROUP',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters, where: where
          )
        end

        def display_listener(name, request_parameters: nil, response_parameters: nil, where: nil)
          mqsc_command(
            command: 'DISPLAY', mqsc_qualifier: 'LISTENER',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters, where: where
          )
        end

        def display_log(name, request_parameters: nil, response_parameters: nil, where: nil)
          mqsc_command(
            command: 'DISPLAY', mqsc_qualifier: 'LOG',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters, where: where
          )
        end

        def display_lsstatus(name, request_parameters: nil, response_parameters: nil, where: nil)
          mqsc_command(
            command: 'DISPLAY', mqsc_qualifier: 'LSSTATUS',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters, where: where
          )
        end

        def display_maxsmsgs(name, request_parameters: nil, response_parameters: nil, where: nil)
          mqsc_command(
            command: 'DISPLAY', mqsc_qualifier: 'MAXSMSGS',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters, where: where
          )
        end

        def display_namelist(name, request_parameters: nil, response_parameters: nil, where: nil)
          mqsc_command(
            command: 'DISPLAY', mqsc_qualifier: 'NAMELIST',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters, where: where
          )
        end

        def display_policy(name, request_parameters: nil, response_parameters: nil, where: nil)
          mqsc_command(
            command: 'DISPLAY', mqsc_qualifier: 'POLICY',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters, where: where
          )
        end

        def display_process(name, request_parameters: nil, response_parameters: nil, where: nil)
          mqsc_command(
            command: 'DISPLAY', mqsc_qualifier: 'PROCESS',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters, where: where
          )
        end

        def display_pubsub(name, request_parameters: nil, response_parameters: nil, where: nil)
          mqsc_command(
            command: 'DISPLAY', mqsc_qualifier: 'PUBSUB',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters, where: where
          )
        end

        def display_qstatus(name, request_parameters: nil, response_parameters: nil, where: nil)
          mqsc_command(
            command: 'DISPLAY', mqsc_qualifier: 'QSTATUS',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters, where: where
          )
        end

        def display_sbstatus(name, request_parameters: nil, response_parameters: nil, where: nil)
          mqsc_command(
            command: 'DISPLAY', mqsc_qualifier: 'SBSTATUS',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters, where: where
          )
        end

        def display_security(name, request_parameters: nil, response_parameters: nil, where: nil)
          mqsc_command(
            command: 'DISPLAY', mqsc_qualifier: 'SECURITY',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters, where: where
          )
        end

        def display_service(name, request_parameters: nil, response_parameters: nil, where: nil)
          mqsc_command(
            command: 'DISPLAY', mqsc_qualifier: 'SERVICE',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters, where: where
          )
        end

        def display_smds(name, request_parameters: nil, response_parameters: nil, where: nil)
          mqsc_command(
            command: 'DISPLAY', mqsc_qualifier: 'SMDS',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters, where: where
          )
        end

        def display_smdsconn(name, request_parameters: nil, response_parameters: nil, where: nil)
          mqsc_command(
            command: 'DISPLAY', mqsc_qualifier: 'SMDSCONN',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters, where: where
          )
        end

        def display_stgclass(name, request_parameters: nil, response_parameters: nil, where: nil)
          mqsc_command(
            command: 'DISPLAY', mqsc_qualifier: 'STGCLASS',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters, where: where
          )
        end

        def display_sub(name, request_parameters: nil, response_parameters: nil, where: nil)
          mqsc_command(
            command: 'DISPLAY', mqsc_qualifier: 'SUB',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters, where: where
          )
        end

        def display_svstatus(name, request_parameters: nil, response_parameters: nil, where: nil)
          mqsc_command(
            command: 'DISPLAY', mqsc_qualifier: 'SVSTATUS',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters, where: where
          )
        end

        def display_system(name, request_parameters: nil, response_parameters: nil, where: nil)
          mqsc_command(
            command: 'DISPLAY', mqsc_qualifier: 'SYSTEM',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters, where: where
          )
        end

        def display_tcluster(name, request_parameters: nil, response_parameters: nil, where: nil)
          mqsc_command(
            command: 'DISPLAY', mqsc_qualifier: 'TCLUSTER',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters, where: where
          )
        end

        def display_thread(name, request_parameters: nil, response_parameters: nil, where: nil)
          mqsc_command(
            command: 'DISPLAY', mqsc_qualifier: 'THREAD',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters, where: where
          )
        end

        def display_topic(name, request_parameters: nil, response_parameters: nil, where: nil)
          mqsc_command(
            command: 'DISPLAY', mqsc_qualifier: 'TOPIC',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters, where: where
          )
        end

        def display_tpstatus(name, request_parameters: nil, response_parameters: nil, where: nil)
          mqsc_command(
            command: 'DISPLAY', mqsc_qualifier: 'TPSTATUS',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters, where: where
          )
        end

        def display_trace(name, request_parameters: nil, response_parameters: nil, where: nil)
          mqsc_command(
            command: 'DISPLAY', mqsc_qualifier: 'TRACE',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters, where: where
          )
        end

        def display_usage(name, request_parameters: nil, response_parameters: nil, where: nil)
          mqsc_command(
            command: 'DISPLAY', mqsc_qualifier: 'USAGE',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters, where: where
          )
        end

        def move_qlocal(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'MOVE', mqsc_qualifier: 'QLOCAL',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        def ping_channel(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'PING', mqsc_qualifier: 'CHANNEL',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        def ping_qmgr(request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'PING', mqsc_qualifier: 'QMGR',
            name: nil, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        def purge_channel(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'PURGE', mqsc_qualifier: 'CHANNEL',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        def recover_bsds(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'RECOVER', mqsc_qualifier: 'BSDS',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        def recover_cfstruct(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'RECOVER', mqsc_qualifier: 'CFSTRUCT',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        def refresh_cluster(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'REFRESH', mqsc_qualifier: 'CLUSTER',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        def refresh_qmgr(request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'REFRESH', mqsc_qualifier: 'QMGR',
            name: nil, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        def refresh_security(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'REFRESH', mqsc_qualifier: 'SECURITY',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        def reset_cfstruct(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'RESET', mqsc_qualifier: 'CFSTRUCT',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        def reset_channel(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'RESET', mqsc_qualifier: 'CHANNEL',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        def reset_cluster(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'RESET', mqsc_qualifier: 'CLUSTER',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        def reset_qmgr(request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'RESET', mqsc_qualifier: 'QMGR',
            name: nil, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        def reset_qstats(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'RESET', mqsc_qualifier: 'QSTATS',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        def reset_smds(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'RESET', mqsc_qualifier: 'SMDS',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        def reset_tpipe(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'RESET', mqsc_qualifier: 'TPIPE',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        def resolve_channel(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'RESOLVE', mqsc_qualifier: 'CHANNEL',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        def resolve_indoubt(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'RESOLVE', mqsc_qualifier: 'INDOUBT',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        def resume_qmgr(request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'RESUME', mqsc_qualifier: 'QMGR',
            name: nil, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        def rverify_security(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'RVERIFY', mqsc_qualifier: 'SECURITY',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        def set_archive(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'SET', mqsc_qualifier: 'ARCHIVE',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        def set_authrec(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'SET', mqsc_qualifier: 'AUTHREC',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        def set_chlauth(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'SET', mqsc_qualifier: 'CHLAUTH',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        def set_log(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'SET', mqsc_qualifier: 'LOG',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        def set_policy(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'SET', mqsc_qualifier: 'POLICY',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        def set_system(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'SET', mqsc_qualifier: 'SYSTEM',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        def start_channel(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'START', mqsc_qualifier: 'CHANNEL',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        def start_chinit(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'START', mqsc_qualifier: 'CHINIT',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        def start_cmdserv(request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'START', mqsc_qualifier: 'CMDSERV',
            name: nil, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        def start_listener(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'START', mqsc_qualifier: 'LISTENER',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        def start_qmgr(request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'START', mqsc_qualifier: 'QMGR',
            name: nil, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        def start_service(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'START', mqsc_qualifier: 'SERVICE',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        def start_smdsconn(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'START', mqsc_qualifier: 'SMDSCONN',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        def start_trace(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'START', mqsc_qualifier: 'TRACE',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        def stop_channel(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'STOP', mqsc_qualifier: 'CHANNEL',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        def stop_chinit(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'STOP', mqsc_qualifier: 'CHINIT',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        def stop_cmdserv(request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'STOP', mqsc_qualifier: 'CMDSERV',
            name: nil, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        def stop_conn(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'STOP', mqsc_qualifier: 'CONN',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        def stop_listener(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'STOP', mqsc_qualifier: 'LISTENER',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        def stop_qmgr(request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'STOP', mqsc_qualifier: 'QMGR',
            name: nil, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        def stop_service(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'STOP', mqsc_qualifier: 'SERVICE',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        def stop_smdsconn(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'STOP', mqsc_qualifier: 'SMDSCONN',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

        def stop_trace(name: nil, request_parameters: nil, response_parameters: nil)
          mqsc_command(
            command: 'STOP', mqsc_qualifier: 'TRACE',
            name: name, request_parameters: request_parameters,
            response_parameters: response_parameters
          )
          nil
        end

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
