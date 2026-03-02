# Examples

Runnable example scripts live in the `examples/` directory. Each script
demonstrates a common MQ administration task using `mq-rest-admin`.

## Prerequisites

Start the multi-queue-manager Docker environment and seed both queue managers:

```bash
./scripts/dev/mq_start.sh
./scripts/dev/mq_seed.sh
```

This starts two queue managers (`QM1` on port 9473, `QM2` on port 9474) on a
shared Docker network. See [local MQ container](development/local-mq-container.md) for details.

## Environment variables

| Variable               | Default                                | Description                   |
|------------------------|----------------------------------------|-------------------------------|
| `MQ_REST_BASE_URL`     | `https://localhost:9473/ibmmq/rest/v2` | QM1 REST endpoint             |
| `MQ_REST_BASE_URL_QM2` | `https://localhost:9474/ibmmq/rest/v2` | QM2 REST endpoint             |
| `MQ_QMGR_NAME`         | `QM1`                                  | Queue manager name            |
| `MQ_ADMIN_USER`        | `mqadmin`                              | Admin username                |
| `MQ_ADMIN_PASSWORD`    | `mqadmin`                              | Admin password                |
| `DEPTH_THRESHOLD_PCT`  | `80`                                   | Queue depth warning threshold |

## Health check

Connects to one or more queue managers and checks QMGR status,
command server availability, and listener state. Produces a pass/fail
summary for each queue manager.

```bash
ruby examples/health_check.rb
```

See [`examples/health_check.rb`](https://github.com/wphillipmoore/mq-rest-admin-ruby/blob/main/examples/health_check.rb) for implementation details.

## Queue depth monitor

Displays local queues with their current depth, flags queues
approaching capacity, and sorts by depth percentage.

```bash
ruby examples/queue_depth_monitor.rb
```

See [`examples/queue_depth_monitor.rb`](https://github.com/wphillipmoore/mq-rest-admin-ruby/blob/main/examples/queue_depth_monitor.rb) for implementation details.

## Channel status report

Displays channel definitions alongside live channel status, identifies
channels that are defined but not running, and shows connection details.

```bash
ruby examples/channel_status.rb
```

See [`examples/channel_status.rb`](https://github.com/wphillipmoore/mq-rest-admin-ruby/blob/main/examples/channel_status.rb) for implementation details.

## Environment provisioner

Defines a complete set of queues, channels, and remote queue definitions
across two queue managers, then verifies connectivity. Includes teardown.

```bash
ruby examples/provision_environment.rb
```

See [`examples/provision_environment.rb`](https://github.com/wphillipmoore/mq-rest-admin-ruby/blob/main/examples/provision_environment.rb) for implementation details.

## Dead letter queue inspector

Checks the dead letter queue configuration, reports depth and capacity,
and suggests actions when messages are present.

```bash
ruby examples/dlq_inspector.rb
```

See [`examples/dlq_inspector.rb`](https://github.com/wphillipmoore/mq-rest-admin-ruby/blob/main/examples/dlq_inspector.rb) for implementation details.

## Queue status and connection handles

Demonstrates `DISPLAY QSTATUS TYPE(HANDLE)` and `DISPLAY CONN TYPE(HANDLE)`
queries, showing how `mq-rest-admin` flattens nested object response
structures into uniform flat hashes.

```bash
ruby examples/queue_status.rb
```

See [`examples/queue_status.rb`](https://github.com/wphillipmoore/mq-rest-admin-ruby/blob/main/examples/queue_status.rb) for implementation details.
