#!/bin/bash

rm -f /shared/token.txt

# Start GitLab in background
/assets/init-container &

# Save PID
GITLAB_PID=$!

GITLAB_URL="http://localhost:80"

# Wait until GitLab API is ready
until curl -sf $GITLAB_URL/-/readiness; do
  echo "Waiting for GitLab to be ready..."
  sleep 5
done
echo "GitLab is ready!"

RUNNER_RETISTERATION_TOKEN=$(gitlab-rails runner "puts Gitlab::CurrentSettings.current_application_settings.runners_registration_token")
echo -n "$RUNNER_RETISTERATION_TOKEN" > /shared/token.txt
RUNNER_RETISTERATION_TOKEN=""

# Wait for GitLab process to end
wait $GITLAB_PID
