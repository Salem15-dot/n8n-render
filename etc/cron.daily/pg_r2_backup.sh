#!/usr/bin/env bash
set -euo pipefail

DATE=$(date +%F_%H-%M)
FILE="n8n_dump_${DATE}.sql.gz"

# 1  Dump Postgres
PGPASSWORD="$POSTGRES_PASSWORD" pg_dump \
  --dbname="$POSTGRES_CONNECTION_URL" \
  --no-owner --format=custom | gzip -9 > "/tmp/$FILE"

# 2  Upload to Cloudflare R2
aws --endpoint-url "$R2_ENDPOINT" \
    s3 cp "/tmp/$FILE" "s3://$R2_BUCKET/$FILE"

# 3  Remove local copy
rm "/tmp/$FILE"
