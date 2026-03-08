#!/usr/bin/env bash
set -euo pipefail

mq_network="mqrest-ruby_mq-dev-net"

if ! docker network inspect "$mq_network" >/dev/null 2>&1; then
  echo "ERROR: Docker network '${mq_network}' not found." >&2
  echo "Start the MQ containers first: ./scripts/dev/mq_start.sh" >&2
  exit 1
fi

export DOCKER_DEV_IMAGE="${DOCKER_DEV_IMAGE:-dev-ruby:3.4}"
export DOCKER_TEST_CMD="${DOCKER_TEST_CMD:-bundle install --jobs 4 && bundle exec rake integration}"
export DOCKER_NETWORK="${mq_network}"

# MQ endpoints use container hostnames (internal port 9443 for both).
export MQ_REST_ADMIN_RUN_INTEGRATION=1
export MQ_QM1_REST_BASE_URL="https://qm1:9443/ibmmq/rest/v2"
export MQ_QM2_REST_BASE_URL="https://qm2:9443/ibmmq/rest/v2"
export MQ_ADMIN_USER="mqadmin"
export MQ_ADMIN_PASSWORD="mqadmin"

if ! command -v st-docker-test >/dev/null 2>&1; then
  echo "ERROR: st-docker-test not found on PATH." >&2
  echo "Set up standard-tooling: export PATH=../standard-tooling/.venv/bin:\$PATH" >&2
  exit 1
fi
exec st-docker-test
