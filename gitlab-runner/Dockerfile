FROM gitlab/gitlab-runner@sha256:371009a3c02014fd87c59c527ef64958b3ba58fc991a13a92aae334824eaef27

USER root

# Install Docker inside GitLab Runner
RUN apt-get update && \
    apt-get install -y docker.io && \
    apt-get clean

# Add Docker daemon config (optional, for tuning)
COPY daemon.json /etc/docker/daemon.json

COPY wrapper_entrypoint.sh /wrapper_entrypoint.sh
RUN chmod +x /wrapper_entrypoint.sh

ENTRYPOINT ["/usr/bin/dumb-init", "/wrapper_entrypoint.sh"]
CMD ["run", "--user=gitlab-runner", "--working-directory=/home/gitlab-runner"]
