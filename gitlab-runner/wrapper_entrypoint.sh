#!/bin/bash

GITLAB_URL="http://$(getent hosts gitlab | awk '{ print $1 }')"

# Call the original entrypoint with the original CMD args
/entrypoint "$@" &

# Save PID
GITLAB_RUNNER_PID=$!

until [ -f /shared/token.txt ]
do
     sleep 5
done

RUNNER_REGISTRATION_TOKEN=$(< /shared/token.txt)
rm -f /shared/token.txt

gitlab-runner unregister --all-runners
rm -f /etc/gitlab-runner/config.toml

gitlab-runner register \
  --non-interactive \
  --url "$GITLAB_URL" \
  --registration-token "$RUNNER_REGISTRATION_TOKEN" \
  --executor "docker" \
  --docker-image alpine@sha256:4bcff63911fcb4448bd4fdacec207030997caf25e9bea4045fa6c8c44de311d1 \
  --description "runner-1" \
  --docker-network-mode "${GITLAB_NET}"

gitlab-runner register \
  --non-interactive \
  --url "$GITLAB_URL" \
  --registration-token "$RUNNER_REGISTRATION_TOKEN" \
  --executor "docker" \
  --docker-image alpine@sha256:4bcff63911fcb4448bd4fdacec207030997caf25e9bea4045fa6c8c44de311d1 \
  --description "runner-2" \
  --docker-network-mode "${GITLAB_NET}"

gitlab-runner register \
  --non-interactive \
  --url "$GITLAB_URL" \
  --registration-token "$RUNNER_REGISTRATION_TOKEN" \
  --executor "docker" \
  --docker-image alpine@sha256:4bcff63911fcb4448bd4fdacec207030997caf25e9bea4045fa6c8c44de311d1 \
  --description "runner-3" \
  --docker-network-mode "${GITLAB_NET}"

# Wait for GitLab Runner process to end
wait $GITLAB_RUNNER_PID
