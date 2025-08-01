FROM n8nio/n8n:latest

# Switch to root user to install tools
USER root

# Install tools using apk (Alpine Linux)
RUN set -eux; \
  apk add --no-cache \
    bash \
    curl \
    dcron \
    gzip \
    python3 \
    py3-pip && \
  pip3 install --no-cache-dir awscli

# Copy helper scripts and cron files
COPY start.sh /start.sh
COPY etc/ /etc/

# Set permissions and register cron job
RUN chmod +x /start.sh /etc/cron.daily/pg_r2_backup.sh && \
    chmod 0644 /etc/cron.d/pg_r2_backup && \
    crontab /etc/cron.d/pg_r2_backup

# Switch back to n8n user (best practice for security)
USER node

# Start script (optional if you're using it to trigger cron/start n8n)
ENTRYPOINT ["bash", "/start.sh"]
