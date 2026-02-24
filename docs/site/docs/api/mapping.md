# Mapping

## Overview

The `Mapping` module translates between developer-friendly `snake_case`
attribute names and native MQSC parameter names. Mapping is bidirectional:
request attributes are mapped from `snake_case` to MQSC, and response
attributes are mapped from MQSC to `snake_case`.

## Controlling mapping

| Session parameter | Default | Effect |
| --- | --- | --- |
| `map_attributes:` | `true` | Enable/disable mapping |
| `mapping_strict:` | `false` | Raise on unknown attributes |

## Mapping override modes

| Mode | Symbol | Behavior |
| --- | --- | --- |
| Merge | `:merge` | Sparse overlay on built-in data |
| Replace | `:replace` | Complete replacement of built-in data |

## Mapping data structure

Each qualifier has up to five sub-maps:

| Sub-map | Direction | Description |
| --- | --- | --- |
| `request_key_map` | Request | `snake_case` key -> MQSC key |
| `request_value_map` | Request | `snake_case` value -> MQSC value |
| `request_key_value_map` | Request | Combined key+value mapping |
| `response_key_map` | Response | MQSC key -> `snake_case` key |
| `response_value_map` | Response | MQSC value -> `snake_case` value |

## MappingIssue

When mapping encounters unknown attributes or values, it records issues as
`MappingIssue` objects:

| Field | Type | Description |
| --- | --- | --- |
| `direction` | `String` | `'request'` or `'response'` |
| `reason` | `String` | `'unknown_key'` or `'unknown_value'` |
| `attribute_name` | `String` | The attribute that couldn't be mapped |
| `attribute_value` | Object | The value (if applicable) |
| `object_index` | `Integer` or `nil` | Index in response list |
| `qualifier` | `String` or `nil` | The qualifier context |

## MappingError

In strict mode, `MappingError` is raised with an `issues` attribute containing
the array of `MappingIssue` objects:

```ruby
begin
  session.display_queue(name: '*', unknown_attr: 'value')
rescue MQ::REST::Admin::MappingError => e
  e.issues.each do |issue|
    puts "#{issue.direction}: #{issue.reason} for '#{issue.attribute_name}'"
  end
end
```

## Module methods

For direct mapping without a session:

```ruby
# Request direction
mapped = MQ::REST::Admin::Mapping.map_request_attributes(
  'queue',
  { 'description' => 'test' },
  strict: false
)

# Response direction
mapped = MQ::REST::Admin::Mapping.map_response_attributes(
  'queue',
  { 'DESCR' => 'test' },
  strict: false
)

# Batch response mapping
mapped = MQ::REST::Admin::Mapping.map_response_list(
  'queue',
  [{ 'DESCR' => 'test' }],
  strict: false
)
```
