# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/)
and this project adheres to [Semantic Versioning](https://semver.org/).

## [1.2.3] - 2026-03-02

### Bug fixes

- fix version-bump-pr regex and add Gemfile.lock update (#52)
- remove releases/index.md nav entry until first release exists (#59)
- require name parameter for DELETE Q* methods (#72)
- LTPA cookie extraction uses prefix matching for suffixed cookie names (#75)
- make license_finder check blocking with approved license list (#83)

### CI

- rename type-check job from test: to ci: prefix (#64)
- add concurrency group to ci-push workflow (#88)

### Documentation

- fix index page mismatches and restructure nav for LHS sidebar (#55)
- merge ensure and sync documentation into single pages (#57)
- add cross-repo documentation links to docs site (#77)

### Features

- port 6 runnable examples and add integration tests (#68)
- auto-generate all MQSC command methods from mapping-data.json (#70)
- add SyncConfig construction validation (#87)

### Refactoring

- rename 13 abbreviated and single-char variables to descriptive names (#66)

## [1.2.2] - 2026-02-26

### Bug fixes

- remove nonexistent Python/uv infrastructure from docs workflow (#7)
- add security-events permission to push workflow (#27)
- commit Gemfile.lock for CI reproducibility (#38)
- reorder publish workflow to tag before registry publish (#46)
- use job-level env for RubyGems secret gate (#49)

### CI

- add workflow to auto-add issues to GitHub Project
- assign unique REST API ports per integration test matrix entry (#10)
- add Steep type-check job to CI workflow (#21)
- migrate CI to GHCR container images (#25)
- replace inline security jobs with shared ci-security.yml workflow (#29)

### Documentation

- add MkDocs/mike documentation site (#5)

### Features

- implement full Ruby port of mq-rest-admin (#3)
- run integration tests with same Ruby version matrix as unit tests (#8)
- add Docker-first test scripts and fix COMPOSE_PROJECT_NAME (#23)

### Refactoring

- remove test exclusions and refactor oversized test classes (#31)
- remove remaining .rubocop.yml relaxations for session.rb and mapping.rb (#32)

### Testing

- add integration test suite porting Python reference coverage (#12)

### Revert

- remove premature add-to-project workflow
