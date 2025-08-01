FROM n8nio/n8n:latest

USER root

# Install tools (and awscli with override flag for Alpine's new Python 3.12+ restrictions)
RUN set -eux; \
  apk add --no-cache \
    bash \
    curl \
    dcron \
    gzip \
    python3 \
    py3-pip && \
  pip3 install --break-system-packages --no-cache-dir awscli

USER node
