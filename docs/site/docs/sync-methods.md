# Sync Methods

## The fire-and-forget problem

--8<-- "concepts/sync-pattern.md"

## Basic usage

```ruby
# Start a channel and wait for it to reach RUNNING
result = session.start_channel_sync('MY.CHANNEL')

puts result.operation      # :started
puts result.polls          # number of status polls
puts result.elapsed_seconds
```

## SyncConfig

Control timeout and polling interval:

```ruby
config = MQ::REST::Admin::SyncConfig.new(
  timeout_seconds: 60.0,
  poll_interval_seconds: 2.0
)

result = session.start_channel_sync('MY.CHANNEL', config: config)
```

Default values: 30 second timeout, 1 second poll interval.

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

## Available sync methods

| Method | Operation |
| --- | --- |
| `start_channel_sync` | Start channel and wait for RUNNING |
| `stop_channel_sync` | Stop channel and wait for STOPPED |
| `restart_channel` | Stop then start channel |
| `start_listener_sync` | Start listener and wait for RUNNING |
| `stop_listener_sync` | Stop listener and wait for STOPPED |
| `restart_listener` | Stop then start listener |
| `start_service_sync` | Start service and wait for RUNNING |
| `stop_service_sync` | Stop service and wait for STOPPED |
| `restart_service` | Stop then start service |

## Channel stop edge case

When stopping a channel, an empty status response (no rows returned by
DISPLAY CHSTATUS) is treated as "stopped". This handles the case where MQ
removes the channel status entry entirely after the channel stops, rather
than reporting a STOPPED status.

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
