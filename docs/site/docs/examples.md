# Examples

These examples demonstrate common MQ administration tasks using
`mq-rest-admin`. Each example is self-contained and can be run against
the local Docker environment.

## Prerequisites

Start the multi-queue-manager Docker environment and seed both queue managers:

```bash
./scripts/dev/mq_start.sh
./scripts/dev/mq_seed.sh
```

This starts two queue managers (`QM1` on port 9443, `QM2` on port 9444) on a
shared Docker network. See [local MQ container](development/local-mq-container.md) for details.

## Health check

Connect to one or more queue managers and check:

- Queue manager attributes via `display_qmgr`
- Running status via `display_qmstatus`
- Listener definitions via `display_listener`

```ruby
require 'mq/rest/admin'

session = MQ::REST::Admin::Session.new(
  'https://localhost:9443/ibmmq/rest/v2', 'QM1',
  credentials: MQ::REST::Admin::BasicAuth.new(username: 'mqadmin', password: 'mqadmin'),
  verify_tls: false
)

qmgr = session.display_qmgr
puts "Queue manager: #{qmgr['queue_manager_name']}"

status = session.display_qmstatus
puts "Status: #{status['channel_initiator_status']}"

listeners = session.display_listener(name: '*')
listeners.each do |listener|
  puts "Listener: #{listener['listener_name']} port=#{listener['port']}"
end
```

## Queue depth monitor

Display all local queues with their current depth and flag queues
approaching capacity:

```ruby
queues = session.display_queue(name: '*')

queues.each do |queue|
  depth = queue['current_queue_depth'].to_i
  max_depth = queue['max_queue_depth'].to_i
  pct = max_depth.positive? ? depth * 100 / max_depth : 0
  flag = pct > 80 ? ' *** HIGH ***' : ''
  printf "%-40s %5d / %5d (%d%%)%s\n",
         queue['queue_name'], depth, max_depth, pct, flag
end
```

## Channel status report

Cross-reference channel definitions with live channel status:

```ruby
channels = session.display_channel(name: '*')
statuses = session.display_chstatus(name: '*')

running = statuses.map { |s| s['channel_name'] }.to_set

channels.each do |ch|
  name = ch['channel_name']
  state = running.include?(name) ? 'RUNNING' : 'INACTIVE'
  puts "#{name}: #{state}"
end
```

## Environment provisioner

Demonstrate bulk provisioning using ensure methods:

```ruby
# Ensure application queues exist
session.ensure_qlocal('APP.REQUESTS',
  'max_queue_depth' => '50000',
  'default_persistence' => 'persistent'
)

session.ensure_qlocal('APP.RESPONSES',
  'max_queue_depth' => '50000',
  'default_persistence' => 'persistent'
)

# Ensure listeners are running
config = MQ::REST::Admin::SyncConfig.new(timeout_seconds: 60.0)
session.start_listener_sync('TCP.LISTENER', config: config)

puts 'Environment provisioned'
```

## Dead letter queue inspector

Inspect the dead letter queue configuration:

```ruby
qmgr = session.display_qmgr

dlq_name = qmgr['dead_letter_q_name']
if dlq_name && !dlq_name.strip.empty?
  dlq = session.display_queue(name: dlq_name)
  unless dlq.empty?
    printf "DLQ: %s depth=%s max=%s\n",
           dlq_name, dlq[0]['current_queue_depth'], dlq[0]['max_queue_depth']
  end
else
  puts 'No dead letter queue configured'
end
```
