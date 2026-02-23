# Errors

## Overview

All errors inherit from `MQ::REST::Admin::Error`, which inherits from
`StandardError`. Use `rescue` to match specific error types.

## Error hierarchy

```
StandardError
  └── MQ::REST::Admin::Error
        ├── TransportError
        ├── ResponseError
        ├── AuthError
        ├── CommandError
        ├── TimeoutError
        └── MappingError
```

## TransportError

Raised when the HTTP request fails at the network level (connection refused,
timeout, DNS failure).

| Field | Type | Description |
| --- | --- | --- |
| `url` | `String` | The URL that was being accessed |

```ruby
rescue MQ::REST::Admin::TransportError => e
  puts "Network error reaching #{e.url}: #{e.message}"
end
```

## ResponseError

Raised when the HTTP response cannot be parsed or has an unexpected structure.

| Field | Type | Description |
| --- | --- | --- |
| `response_text` | `String` | The raw response body |

```ruby
rescue MQ::REST::Admin::ResponseError => e
  puts "Bad response: #{e.response_text}"
end
```

## AuthError

Raised when authentication fails (HTTP 401/403).

| Field | Type | Description |
| --- | --- | --- |
| `url` | `String` | The URL that was being accessed |
| `status_code` | `Integer` | HTTP status code (401 or 403) |

```ruby
rescue MQ::REST::Admin::AuthError => e
  puts "Auth failed at #{e.url}: HTTP #{e.status_code}"
end
```

## CommandError

Raised when an MQSC command fails (non-zero completion or reason code).

| Field | Type | Description |
| --- | --- | --- |
| `payload` | `Hash` | Full MQ response payload |
| `status_code` | `Integer` | HTTP status code |

```ruby
rescue MQ::REST::Admin::CommandError => e
  puts "Command failed: #{e.message}"
  puts "HTTP status: #{e.status_code}"
  puts "Payload: #{e.payload}"
end
```

## TimeoutError

Raised when a synchronous operation (start/stop/restart) exceeds its timeout.

| Field | Type | Description |
| --- | --- | --- |
| `name` | `String` | Object name (channel, listener, or service) |
| `operation` | `String` | Operation that timed out (`'start'` or `'stop'`) |
| `elapsed` | `Float` | Seconds elapsed before timeout |

```ruby
rescue MQ::REST::Admin::TimeoutError => e
  puts "#{e.operation} of #{e.name} timed out after #{e.elapsed}s"
end
```

## MappingError

Raised in strict mapping mode when unknown attributes or values are encountered.

| Field | Type | Description |
| --- | --- | --- |
| `issues` | `Array<MappingIssue>` | List of mapping issues |

```ruby
rescue MQ::REST::Admin::MappingError => e
  e.issues.each do |issue|
    puts "#{issue.direction}: #{issue.reason} for '#{issue.attribute_name}'"
  end
end
```
