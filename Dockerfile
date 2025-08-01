FROM n8nio/n8n:latest

# Switch to root for installing dependencies
USER 0

# Install required tools
RUN set -eux; \
    apk add --no-cache bash curl cron gzip python3 py3-pip; \
    pip3 install --no-cache-dir awscli

# Copy backup scripts
COPY start.sh /start.sh
COPY etc/ /etc/

# Permissions and cron setup
RUN chmod +x /start.sh /etc/cron.daily/pg_r2_backup.sh; \
    chmod 0644 /etc/cron.d/pg_r2_backup; \
    crontab /etc/cron.d/pg_r2_backup

# Switch back to default non-root user
USER node
