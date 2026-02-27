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

if command -v docker-test >/dev/null 2>&1; then
  exec docker-test
fi

# Fallback: run docker directly if docker-test is not on PATH.
repo_root="$(cd "$(dirname "$0")/../.." && pwd)"

docker_args=(
  run --rm
  -v "${repo_root}:/workspace"
  -w /workspace
  --network "${DOCKER_NETWORK}"
)

# Pass through MQ_* environment variables.
while IFS='=' read -r name _; do
  docker_args+=(-e "$name")
done < <(env | grep '^MQ_' || true)

docker_args+=("${DOCKER_DEV_IMAGE}")
docker_args+=(bash -c "${DOCKER_TEST_CMD}")

echo "Image:   ${DOCKER_DEV_IMAGE}"
echo "Command: ${DOCKER_TEST_CMD}"
echo "Network: ${DOCKER_NETWORK}"
echo "---"

exec docker "${docker_args[@]}"
