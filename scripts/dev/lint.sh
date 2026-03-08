#!/usr/bin/env bash
set -euo pipefail

export DOCKER_DEV_IMAGE="${DOCKER_DEV_IMAGE:-dev-ruby:3.4}"
export DOCKER_TEST_CMD="${DOCKER_TEST_CMD:-bundle install --jobs 4 && bundle exec rubocop}"

if ! command -v st-docker-test >/dev/null 2>&1; then
  echo "ERROR: st-docker-test not found on PATH." >&2
  echo "Set up standard-tooling: export PATH=../standard-tooling/.venv/bin:\$PATH" >&2
  exit 1
fi
exec st-docker-test
