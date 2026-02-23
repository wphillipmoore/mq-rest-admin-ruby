# Ensure Methods

## The problem with ALTER

--8<-- "concepts/ensure-pattern.md"

## Basic usage

```ruby
result = session.ensure_qlocal('MY.QUEUE',
  'max_queue_depth' => '50000',
  'default_persistence' => 'persistent'
)

case result.action
when :created
  puts "Queue created with requested attributes"
when :updated
  puts "Queue updated: #{result.changed.join(', ')}"
when :unchanged
  puts "Queue already matches desired state"
end
```

## How it works

Each ensure method follows the same pattern:

1. **DISPLAY** the object to check if it exists
2. If the DISPLAY fails with a "not found" error, **DEFINE** the object with
   all requested attributes. Result: `:created`.
3. If the object exists, compare each requested attribute against the current
   value. If all match, do nothing. Result: `:unchanged`.
4. If any attributes differ, **ALTER** the object with only the changed
   attributes. Result: `:updated`.

## Comparison logic

Value comparison is case-insensitive and whitespace-trimming for strings.
Non-string values are compared with standard equality. This handles MQ's
inconsistent casing in responses (e.g. `PERSISTENT` vs `Persistent`).

## Selective ALTER

When attributes differ, only the changed attributes are sent in the ALTER
command. This avoids corrupting `ALTDATE`/`ALTTIME` audit timestamps for
attributes that already match.

## Available ensure methods

| Method | Object type |
| --- | --- |
| `ensure_qmgr` | Queue manager (singleton) |
| `ensure_qlocal` | Local queue |
| `ensure_qremote` | Remote queue |
| `ensure_qalias` | Alias queue |
| `ensure_qmodel` | Model queue |
| `ensure_channel` | Channel |
| `ensure_authinfo` | Authentication information |
| `ensure_listener` | Listener |
| `ensure_namelist` | Namelist |
| `ensure_process` | Process |
| `ensure_service` | Service |
| `ensure_topic` | Topic |
| `ensure_sub` | Subscription |
| `ensure_stgclass` | Storage class |
| `ensure_comminfo` | Communication information |
| `ensure_cfstruct` | CF structure |

## Attribute mapping

Ensure methods respect the session's mapping configuration. When mapping is
enabled (the default), pass `snake_case` attribute names:

```ruby
session.ensure_qlocal('MY.QUEUE',
  'max_queue_depth' => '50000'
)
```

When mapping is disabled, pass raw MQSC parameter names:

```ruby
session.ensure_qlocal('MY.QUEUE',
  'MAXDEPTH' => '50000'
)
```

## Configuration management example

```ruby
desired_queues = {
  'APP.REQUESTS'  => { 'max_queue_depth' => '50000', 'default_persistence' => 'persistent' },
  'APP.RESPONSES' => { 'max_queue_depth' => '50000', 'default_persistence' => 'persistent' },
  'APP.ERRORS'    => { 'max_queue_depth' => '10000' }
}

desired_queues.each do |name, attrs|
  result = session.ensure_qlocal(name, attrs)
  puts "#{name}: #{result.action} #{result.changed}"
end
```
