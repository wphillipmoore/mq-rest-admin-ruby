# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

**Standards reference**: <https://github.com/wphillipmoore/standards-and-conventions>
— active standards documentation lives in the standard-tooling repository under `docs/`.
Repository profile: `standard-tooling.toml`.

## Auto-memory policy

**Do NOT use MEMORY.md.** Never write to MEMORY.md or any file under the
memory directory. All behavioral rules, conventions, and workflow instructions
belong in managed, version-controlled documentation (CLAUDE.md, AGENTS.md,
skills, or docs/). If you want to persist something, tell the human what you
would save and let them decide where it belongs.

## Parallel AI agent development

This repository supports running multiple Claude Code agents in parallel via
git worktrees. The convention keeps parallel agents' working trees isolated
while preserving shared project memory (which Claude Code derives from the
session's starting CWD).

**Canonical spec:**
[`standard-tooling/docs/specs/worktree-convention.md`](https://github.com/wphillipmoore/standard-tooling/blob/develop/docs/specs/worktree-convention.md)
— full rationale, trust model, failure modes, and memory-path implications.
The canonical text lives in `standard-tooling`; this section is the local
on-ramp.

### Structure

```text
~/dev/github/mq-rest-admin-ruby/          ← sessions ALWAYS start here
  .git/
  CLAUDE.md, lib/, spec/, …               ← main worktree (usually `develop`)
  .worktrees/                             ← container for parallel worktrees
    issue-105-adopt-worktree-convention/  ← worktree on feature/105-...
    …
```

### Rules

1. **Sessions always start at the project root.**
   `cd ~/dev/github/mq-rest-admin-ruby && claude` — never from inside
   `.worktrees/<name>/`. This keeps the memory-path slug stable and shared.
2. **Each parallel agent is assigned exactly one worktree.** The session
   prompt names the worktree (see Agent prompt contract below).
   - For Read / Edit / Write tools: use the worktree's absolute path.
   - For Bash commands that touch files: `cd` into the worktree first,
     or use absolute paths.
3. **The main worktree is read-only.** All edits flow through a worktree
   on a feature branch — the logical endpoint of the standing
   "no direct commits to `develop`" policy.
4. **One worktree per issue.** Don't stack in-flight issues. When a
   branch lands, remove the worktree before starting the next.
5. **Naming: `issue-<N>-<short-slug>`.** `<N>` is the GitHub issue
   number; `<short-slug>` is 2–4 kebab-case tokens.

### Agent prompt contract

When launching a parallel-agent session, use this template (fill in the
placeholders):

```text
You are working on issue #<N>: <issue title>.

Your worktree is: /Users/pmoore/dev/github/mq-rest-admin-ruby/.worktrees/issue-<N>-<slug>/
Your branch is:   feature/<N>-<slug>

Rules for this session:
- Do all git operations from inside your worktree:
    cd <absolute-worktree-path> && git <command>
- For Read / Edit / Write tools, use the absolute worktree path.
- For Bash commands that touch files, cd into the worktree first
  or use absolute paths.
- Do not edit files at the project root. The main worktree is
  read-only — all changes flow through your worktree on your
  feature branch.
```

All fields are required.

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

### Two-Tier CI Model

Testing is split across two tiers with increasing scope and cost:

**Tier 1 — Local pre-commit (seconds):** Fast smoke tests in a single
container. Enforced via the `.githooks` pre-commit gate on every commit.
No MQ, no matrix.

```bash
./scripts/dev/test.sh        # Unit tests in dev-ruby:3.4
./scripts/dev/lint.sh        # RuboCop in dev-ruby:3.4
./scripts/dev/typecheck.sh   # Steep in dev-ruby:3.4
./scripts/dev/audit.sh       # bundle-audit in dev-ruby:3.4
```

**Tier 2 — PR CI (~8-10 min):** Triggers on `pull_request`. Full Ruby
matrix (3.2, 3.3, 3.4), all integration tests, security scanners (CodeQL,
Trivy, Semgrep), standards compliance, and release gates. Workflow:
`.github/workflows/ci.yml`.

Push-CI was retired once `st-validate-local` reached parity with PR-CI.
See wphillipmoore/standard-actions#176 for the parity audit and rationale.

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
