# Sync

## Overview

The `Sync` module provides synchronous start/stop/restart operations that
poll for the desired status before returning.

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

## Usage

```ruby
config = MQ::REST::Admin::SyncConfig.new(timeout_seconds: 60.0)

result = session.start_channel_sync('MY.CHANNEL', config: config)
puts "#{result.operation} in #{result.elapsed_seconds.round(1)}s"
```

## Available sync methods

| Method | Operation |
| --- | --- |
| `start_channel_sync` | Start channel, wait for RUNNING |
| `stop_channel_sync` | Stop channel, wait for STOPPED |
| `restart_channel` | Stop then start channel |
| `start_listener_sync` | Start listener, wait for RUNNING |
| `stop_listener_sync` | Stop listener, wait for STOPPED |
| `restart_listener` | Stop then start listener |
| `start_service_sync` | Start service, wait for RUNNING |
| `stop_service_sync` | Stop service, wait for STOPPED |
| `restart_service` | Stop then start service |

## Timeout handling

Raises `TimeoutError` if the operation doesn't complete within the configured
timeout:

```ruby
begin
  session.start_channel_sync('MY.CHANNEL',
    config: MQ::REST::Admin::SyncConfig.new(timeout_seconds: 5.0)
  )
rescue MQ::REST::Admin::TimeoutError => e
  puts "#{e.operation} timed out for #{e.name}"
end
```
