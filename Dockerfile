FROM n8nio/n8n:latest

# ----- copy helper scripts -----
COPY start.sh /start.sh
COPY etc/ /etc/

# ----- install tools & register cron -----
RUN set -eux; \
    apk add --no-cache bash curl cron gzip python3 py3-pip; \
    pip3 install --no-cache-dir awscli; \
    chmod +x /start.sh /etc/cron.daily/pg_r2_backup.sh; \
    chmod 0644 /etc/cron.d/pg_r2_backup; \
    crontab /etc/cron.d/pg_r2_backup

ENTRYPOINT ["bash", "/start.sh", "docker-entrypoint.sh"]
