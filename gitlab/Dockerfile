FROM gitlab/gitlab-ce@sha256:c3724668f3d8b5cb51846d8efe7f864a597804cd38050e377ab384d16c29695f

COPY wrapper_entrypoint.sh /wrapper_entrypoint.sh
RUN chmod +x /wrapper_entrypoint.sh

ENTRYPOINT ["/wrapper_entrypoint.sh"]
