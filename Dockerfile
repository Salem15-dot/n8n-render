FROM n8nio/n8n:latest

# -------- copy helper scripts --------
COPY start.sh /start.sh
COPY etc/ /etc/

# -------- install tools, enable cron --------
# --- install tools, enable cron ---  (Alpine version)
RUN set -eux; \
    apk add --no-cache dcron python3 py3-pip gzip bash curl; \
    pip3 install --no-cache-dir awscli; \
 && chmod +x /start.sh /etc/cron.daily/pg_r2_backup.sh \
 && chmod 0644 /etc/cron.d/pg_r2_backup \
 && crontab /etc/cron.d/pg_r2_backup

ENTRYPOINT ["bash", "/start.sh", "docker-entrypoint.sh"]
