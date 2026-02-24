# Ensure

## Overview

The `Ensure` module provides idempotent create-or-update operations for MQ
objects. Each method checks the current state and only makes changes if needed.

## EnsureResult

`EnsureResult` is an immutable value object (`Data.define`):

| Field | Type | Description |
| --- | --- | --- |
| `action` | `Symbol` | `:created`, `:updated`, or `:unchanged` |
| `changed` | `Array<String>` | List of attributes that were changed |

## Usage

```ruby
result = session.ensure_qlocal('MY.QUEUE',
  'max_queue_depth' => '50000',
  'default_persistence' => 'persistent'
)

puts result.action   # :created, :updated, or :unchanged
puts result.changed  # ["max_queue_depth"] if updated
```

## Available ensure methods

| Method | Object type |
| --- | --- |
| `ensure_qmgr` | Queue manager (singleton, no name) |
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

## Comparison logic

Values are compared case-insensitively for strings (after stripping
whitespace). Non-string values use standard equality. This handles MQ's
inconsistent casing in DISPLAY responses.
