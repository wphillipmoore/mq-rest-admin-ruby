# Sync

--8<-- "concepts/sync-pattern.md"

## SyncConfig

`SyncConfig` is an immutable value object (`Data.define`):

| Field | Type | Default | Description |
| --- | --- | --- | --- |
| `timeout_seconds` | `Float` | `30.0` | Maximum wait time |
| `poll_interval_seconds` | `Float` | `1.0` | Delay between polls |

## SyncResult

`SyncResult` is an immutable value object (`Data.define`):

| Field | Type | Description |
| --- | --- | --- |
| `operation` | `Symbol` | `:started`, `:stopped`, or `:restarted` |
| `polls` | `Integer` | Number of status polls performed |
| `elapsed_seconds` | `Float` | Total elapsed time |

## Basic usage

```ruby
# Start a channel and wait for it to reach RUNNING
result = session.start_channel_sync('MY.CHANNEL')

puts result.operation      # :started
puts result.polls          # number of status polls
puts result.elapsed_seconds
```

## Custom configuration

```ruby
config = MQ::REST::Admin::SyncConfig.new(
  timeout_seconds: 60.0,
  poll_interval_seconds: 2.0
)

result = session.start_channel_sync('MY.CHANNEL', config: config)
```

## Restart convenience methods

Each object type has a restart method that stops, waits for stopped, then
starts and waits for running:

```ruby
result = session.restart_channel('MY.CHANNEL')
puts result.operation      # :restarted
puts result.polls          # total polls across stop + start
```

## Timeout handling

If the operation doesn't complete within the timeout, a `TimeoutError` is
raised:

```ruby
begin
  session.start_channel_sync('MY.CHANNEL',
    config: MQ::REST::Admin::SyncConfig.new(timeout_seconds: 5.0)
  )
rescue MQ::REST::Admin::TimeoutError => e
  puts "#{e.operation} timed out for #{e.name} after #{e.elapsed}s"
end
```

## Provisioning example

```ruby
config = MQ::REST::Admin::SyncConfig.new(timeout_seconds: 60.0)

# Ensure queues exist
session.ensure_qlocal('APP.REQUESTS', 'max_queue_depth' => '50000')
session.ensure_qlocal('APP.RESPONSES', 'max_queue_depth' => '50000')

# Start listener
session.start_listener_sync('TCP.LISTENER', config: config)

puts 'Environment provisioned'
```

## Rolling restart example

```ruby
config = MQ::REST::Admin::SyncConfig.new(timeout_seconds: 30.0)

channels = session.display_channel(name: 'APP.*')
channels.each do |ch|
  name = ch['channel_name']
  puts "Restarting #{name}..."
  result = session.restart_channel(name, config: config)
  puts "  #{result.operation} in #{result.elapsed_seconds.round(1)}s (#{result.polls} polls)"
end
```
