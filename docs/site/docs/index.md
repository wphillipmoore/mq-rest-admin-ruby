# mq-rest-admin

## Overview

**mq-rest-admin** provides a Ruby-friendly interface to IBM MQ queue manager
administration via the `runCommandJSON` REST endpoint. It translates between
Ruby `snake_case` attribute names and native MQSC parameter names, wraps
every MQSC command as a typed method, and handles authentication, CSRF tokens,
and error propagation.

## Key features

- **148 command methods** covering all MQSC verbs and qualifiers
- **Bidirectional attribute mapping** between developer-friendly names and MQSC parameters
- **Idempotent ensure methods** for declarative object management
- **Synchronous polling methods** for start/stop/restart workflows
- **Zero runtime dependencies** -- stdlib `net/http` only
- **Transport abstraction** for easy testing with mock transports

## Installation

Add to your Gemfile:

```ruby
gem 'mq-rest-admin'
```

Or install directly:

```bash
gem install mq-rest-admin
```

## Status

This project is in **pre-alpha** (initial setup). The API surface, mapping
tables, and return shapes are under active development.

## License

GNU General Public License v3.0

--8<-- "other-languages.md"
