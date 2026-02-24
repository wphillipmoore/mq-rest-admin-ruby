# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/)
and this project adheres to [Semantic Versioning](https://semver.org/).

## [1.2.0] - 2026-02-24

### Bug fixes

- remove nonexistent Python/uv infrastructure from docs workflow (#7)

### CI

- add workflow to auto-add issues to GitHub Project
- assign unique REST API ports per integration test matrix entry (#10)

### Documentation

- add MkDocs/mike documentation site (#5)

### Features

- implement full Ruby port of mq-rest-admin (#3)
- run integration tests with same Ruby version matrix as unit tests (#8)

### Testing

- add integration test suite porting Python reference coverage (#12)

### Revert

- remove premature add-to-project workflow
