FROM n8nio/n8n:latest

# -------- copy helper scripts --------
COPY start.sh /start.sh
COPY etc/ /etc/

# -------- install tools, enable cron --------
RUN apt-get update -qq \
 && apt-get install -y -qq cron awscli gzip \
 && chmod +x /start.sh /etc/cron.daily/pg_r2_backup.sh \
 && chmod 0644 /etc/cron.d/pg_r2_backup \
 && crontab /etc/cron.d/pg_r2_backup

ENTRYPOINT ["bash", "/start.sh", "docker-entrypoint.sh"]
