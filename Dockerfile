FROM n8nio/n8n:latest                 # Debian-based image

# ---------- helper scripts ----------
COPY start.sh /start.sh
COPY etc  /etc

# ---------- install tools & register cron ----------
RUN set -eux; \
    apt-get update -qq; \
    DEBIAN_FRONTEND=noninteractive apt-get install -y -qq \
        cron gzip curl python3-pip; \
    pip3 install --no-cache-dir awscli; \
    chmod +x  /start.sh                 \
              /etc/cron.daily/pg_r2_backup.sh; \
    chmod 0644 /etc/cron.d/pg_r2_backup;       \
    crontab      /etc/cron.d/pg_r2_backup

ENTRYPOINT ["bash", "/start.sh", "docker-entrypoint.sh"]
