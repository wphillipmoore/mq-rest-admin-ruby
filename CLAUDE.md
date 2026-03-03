# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

<!-- include: docs/standards-and-conventions.md -->
<!-- include: docs/repository-standards.md -->

## Project Overview

`mq-rest-admin` is a Ruby wrapper for the IBM MQ administrative REST
API. The project provides typed Ruby methods for every MQSC command
exposed by the `runCommandJSON` REST endpoint, with automatic attribute name
translation between Ruby idioms and native MQSC parameter names.

**Project name**: mq-rest-admin-ruby

**Status**: Pre-alpha (initial setup)

**Canonical Standards**: This repository follows standards at <https://github.com/wphillipmoore/standards-and-conventions> (local path: `../standards-and-conventions` if available)

## Development Commands

### Standard Tooling

```bash
cd ../standard-tooling && uv sync                                                # Install standard-tooling
export PATH="../standard-tooling/.venv/bin:../standard-tooling/scripts/bin:$PATH" # Put tools on PATH
git config core.hooksPath ../standard-tooling/scripts/lib/git-hooks               # Enable git hooks
```

### Environment Setup

```bash
bundle install
```

### Validation

```bash
bundle exec rake
```

### Three-Tier CI Model

Testing is split across three tiers with increasing scope and cost:

**Tier 1 — Local pre-commit (seconds):** Fast smoke tests in a single
container. Run before every commit. No MQ, no matrix.

```bash
./scripts/dev/test.sh        # Unit tests in dev-ruby:3.4
./scripts/dev/lint.sh        # RuboCop in dev-ruby:3.4
./scripts/dev/typecheck.sh   # Steep in dev-ruby:3.4
./scripts/dev/audit.sh       # bundle-audit in dev-ruby:3.4
```

**Tier 2 — Push CI (~3-5 min):** Triggers automatically on push to
`feature/**`, `bugfix/**`, `hotfix/**`, `chore/**`. Single Ruby version
(3.4), includes integration tests, no security scanners or release gates.
Workflow: `.github/workflows/ci-push.yml` (calls `ci.yml`).

**Tier 3 — PR CI (~8-10 min):** Triggers on `pull_request`. Full Ruby
matrix (3.2, 3.3, 3.4), all integration tests, security scanners (CodeQL,
Trivy, Semgrep), standards compliance, and release gates. Workflow:
`.github/workflows/ci.yml`.

### Docker-First Testing

All tests can run inside containers — Docker is the only host prerequisite.
The `dev-ruby:3.4` image is built from `../standard-tooling/docker/ruby/`
and published to `ghcr.io/wphillipmoore/dev-ruby`.

```bash
# Build the dev image (one-time, from standard-tooling)
cd ../standard-tooling && docker/build.sh

# Run unit tests in container
./scripts/dev/test.sh

# Run linter in container
./scripts/dev/lint.sh

# Run type checker in container
./scripts/dev/typecheck.sh

# Run dependency audit in container
./scripts/dev/audit.sh

# Run integration tests (requires MQ containers running)
./scripts/dev/mq_start.sh
./scripts/dev/mq_seed.sh
./scripts/dev/test-integration.sh
./scripts/dev/mq_stop.sh
```

Environment overrides:

- `DOCKER_DEV_IMAGE` — override the container image (default: `dev-ruby:3.4`)
- `DOCKER_TEST_CMD` — override the test command
- `DOCKER_NETWORK` — join a Docker network (set automatically by
  `test-integration.sh`)

### Local MQ Container

The MQ development environment is owned by the
[mq-rest-admin-dev-environment](https://github.com/wphillipmoore/mq-rest-admin-dev-environment)
repository. Clone it as a sibling directory before running lifecycle
scripts:

```bash
# Prerequisite (one-time)
git clone https://github.com/wphillipmoore/mq-rest-admin-dev-environment.git ../mq-rest-admin-dev-environment

# Start the containerized MQ queue managers
./scripts/dev/mq_start.sh

# Seed deterministic test objects (DEV.* prefix)
./scripts/dev/mq_seed.sh

# Verify REST-based MQSC responses
./scripts/dev/mq_verify.sh

# Stop the queue managers
./scripts/dev/mq_stop.sh

# Reset to clean state (removes data volumes)
./scripts/dev/mq_reset.sh
```

Container details:

- Queue managers: `QM1` and `QM2`
- QM1 ports: `1444` (MQ listener), `9473` (mqweb console + REST API)
- QM2 ports: `1445` (MQ listener), `9474` (mqweb console + REST API)
- Admin credentials: `mqadmin` / `mqadmin`
- Read-only credentials: `mqreader` / `mqreader`
- QM1 REST base URL: `https://localhost:9473/ibmmq/rest/v2`
- QM2 REST base URL: `https://localhost:9474/ibmmq/rest/v2`
- Object prefix: `DEV.*`

## Architecture

### Gem layout (`lib/mq/rest/admin/`)

- **`version.rb`** — `MQ::REST::Admin::VERSION`
- **`errors.rb`** — `Error < StandardError` + 6 subclasses
- **`auth.rb`** — `BasicAuth`, `LTPAAuth`, `CertificateAuth` (`Data.define`)
- **`transport.rb`** — `TransportResponse` (`Data.define`), `NetHTTPTransport`
- **`mapping_data.rb`** — Loads and freezes `mapping-data.json`
- **`mapping.rb`** — 3-layer mapping pipeline + `MappingIssue`
- **`mapping_merge.rb`** — Override validation and merge/replace
- **`session.rb`** — `Session` class, `mqsc_command` dispatcher
- **`commands.rb`** — 149 MQSC command methods (module)
- **`ensure.rb`** — 16 idempotent ensure methods (module)
- **`sync.rb`** — 9 synchronous polling methods (module)

### Key design decisions

- **Zero runtime dependencies** — uses `net/http` from stdlib
- **Ruby 3.2+** — uses `Data.define` for immutable value objects
- **Module mixins** — `Commands`, `Ensure`, `Sync` included into `Session`

## Key References

**Reference implementation**: `../mq-rest-admin-python` (Python version)

**External Documentation**:

- IBM MQ 9.4 administrative REST API
- MQSC command reference
