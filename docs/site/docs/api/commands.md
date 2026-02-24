# Commands

## Overview

The `Commands` module provides 148 methods covering all MQSC verbs and
qualifiers. Each method delegates to the internal `mqsc_command` dispatcher.

## Method patterns

### DISPLAY methods (list)

Return an `Array<Hash>`. Empty array if no objects match.

```ruby
queues = session.display_queue(name: '*')
```

### DISPLAY methods (singleton)

Return a `Hash` or `nil`.

```ruby
qmgr = session.display_qmgr
```

### Non-DISPLAY methods

Return `nil` on success. Raise `CommandError` on failure.

```ruby
session.define_qlocal('MY.QUEUE', 'max_queue_depth' => '50000')
```

## Optional parameters

All command methods accept optional keyword arguments that map to MQSC
command parameters:

```ruby
session.display_queue(
  name: 'MY.*',
  where: { 'current_queue_depth' => '0' },
  response_parameters: %w[queue_name current_queue_depth]
)
```

## DISPLAY methods

| Method | Qualifier |
| --- | --- |
| `display_apstatus` | APSTATUS |
| `display_authinfo` | AUTHINFO |
| `display_authrec` | AUTHREC |
| `display_authserv` | AUTHSERV |
| `display_cfstatus` | CFSTATUS |
| `display_cfstruct` | CFSTRUCT |
| `display_channel` | CHANNEL |
| `display_chinit` | CHINIT |
| `display_chlauth` | CHLAUTH |
| `display_chstatus` | CHSTATUS |
| `display_clusqmgr` | CLUSQMGR |
| `display_cluster` | CLUSTER |
| `display_comminfo` | COMMINFO |
| `display_conn` | CONN |
| `display_entauth` | ENTAUTH |
| `display_group` | GROUP |
| `display_listener` | LISTENER |
| `display_log` | LOG |
| `display_lsstatus` | LSSTATUS |
| `display_namelist` | NAMELIST |
| `display_policy` | POLICY |
| `display_process` | PROCESS |
| `display_pubsub` | PUBSUB |
| `display_qmgr` | QMGR |
| `display_qmstatus` | QMSTATUS |
| `display_qstatus` | QSTATUS |
| `display_queue` | QUEUE |
| `display_sbstatus` | SBSTATUS |
| `display_security` | SECURITY |
| `display_service` | SERVICE |
| `display_smds` | SMDS |
| `display_smdsconn` | SMDSCONN |
| `display_stgclass` | STGCLASS |
| `display_sub` | SUB |
| `display_svstatus` | SVSTATUS |
| `display_topic` | TOPIC |
| `display_tpstatus` | TPSTATUS |
| `display_usage` | USAGE |

## DEFINE methods

| Method | Qualifier |
| --- | --- |
| `define_authinfo` | AUTHINFO |
| `define_cfstruct` | CFSTRUCT |
| `define_channel` | CHANNEL |
| `define_comminfo` | COMMINFO |
| `define_listener` | LISTENER |
| `define_namelist` | NAMELIST |
| `define_policy` | POLICY |
| `define_process` | PROCESS |
| `define_qalias` | QALIAS |
| `define_qlocal` | QLOCAL |
| `define_qmodel` | QMODEL |
| `define_qremote` | QREMOTE |
| `define_service` | SERVICE |
| `define_stgclass` | STGCLASS |
| `define_sub` | SUB |
| `define_topic` | TOPIC |

## DELETE methods

| Method | Qualifier |
| --- | --- |
| `delete_authinfo` | AUTHINFO |
| `delete_authrec` | AUTHREC |
| `delete_cfstruct` | CFSTRUCT |
| `delete_channel` | CHANNEL |
| `delete_chlauth` | CHLAUTH |
| `delete_comminfo` | COMMINFO |
| `delete_listener` | LISTENER |
| `delete_namelist` | NAMELIST |
| `delete_policy` | POLICY |
| `delete_process` | PROCESS |
| `delete_queue` | QUEUE |
| `delete_service` | SERVICE |
| `delete_stgclass` | STGCLASS |
| `delete_sub` | SUB |
| `delete_topic` | TOPIC |

## ALTER methods

| Method | Qualifier |
| --- | --- |
| `alter_authinfo` | AUTHINFO |
| `alter_cfstruct` | CFSTRUCT |
| `alter_channel` | CHANNEL |
| `alter_comminfo` | COMMINFO |
| `alter_listener` | LISTENER |
| `alter_namelist` | NAMELIST |
| `alter_process` | PROCESS |
| `alter_qmgr` | QMGR |
| `alter_queue` | QUEUE |
| `alter_security` | SECURITY |
| `alter_service` | SERVICE |
| `alter_stgclass` | STGCLASS |
| `alter_sub` | SUB |
| `alter_topic` | TOPIC |

## START / STOP methods

| Method | Qualifier |
| --- | --- |
| `start_channel` | CHANNEL |
| `start_chinit` | CHINIT |
| `start_cmdserv` | CMDSERV |
| `start_listener` | LISTENER |
| `start_service` | SERVICE |
| `start_smdsconn` | SMDSCONN |
| `stop_channel` | CHANNEL |
| `stop_chinit` | CHINIT |
| `stop_cmdserv` | CMDSERV |
| `stop_conn` | CONN |
| `stop_listener` | LISTENER |
| `stop_service` | SERVICE |
| `stop_smdsconn` | SMDSCONN |

## Other methods

| Method | Qualifier |
| --- | --- |
| `archive_log` | LOG |
| `backup_cfstruct` | CFSTRUCT |
| `clear_qlocal` | QLOCAL |
| `clear_topicstr` | TOPICSTR |
| `move_queue` | QUEUE |
| `ping_channel` | CHANNEL |
| `ping_qmgr` | QMGR |
| `recover_cfstruct` | CFSTRUCT |
| `refresh_cluster` | CLUSTER |
| `refresh_qmgr` | QMGR |
| `refresh_security` | SECURITY |
| `reset_cfstruct` | CFSTRUCT |
| `reset_channel` | CHANNEL |
| `reset_cluster` | CLUSTER |
| `reset_qmgr` | QMGR |
| `reset_qstats` | QSTATS |
| `reset_smds` | SMDS |
| `resolve_channel` | CHANNEL |
| `resolve_indoubt` | INDOUBT |
| `resume_qmgr` | QMGR |
| `set_authrec` | AUTHREC |
| `set_chlauth` | CHLAUTH |
| `set_log` | LOG |
| `set_policy` | POLICY |
| `suspend_qmgr` | QMGR |
