FROM n8nio/n8n:latest

# Switch to root to install tools
USER root

# Install tools and cron using apt (because it's Debian-based now)
RUN set -eux; \
  apt-get update -qq && \
  apt-get install -y --no-install-recommends \
    bash \
    curl \
    cron \
    gzip \
    python3 \
    python3-pip && \
  pip3 install --no-cache-dir awscli && \
  rm -rf /var/lib/apt/lists/*

# Copy files
COPY start.sh /start.sh
COPY etc/ /etc/

# Set permissions and add cron job
RUN chmod +x /start.sh /etc/cron.daily/pg_r2_backup.sh && \
    chmod 0644 /etc/cron.d/pg_r2_backup && \
    crontab /etc/cron.d/pg_r2_backup

# Switch back to n8n user (default)
USER node
