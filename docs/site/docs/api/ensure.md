# Ensure

--8<-- "concepts/ensure-pattern.md"

## EnsureResult

`EnsureResult` is an immutable value object (`Data.define`):

| Field | Type | Description |
| --- | --- | --- |
| `action` | `Symbol` | `:created`, `:updated`, or `:unchanged` |
| `changed` | `Array<String>` | List of attributes that were changed |

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
