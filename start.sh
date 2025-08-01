#!/usr/bin/env bash
set -euo pipefail

# start cron in foreground (-f) so Render keeps the process alive
cron -f &

exec "$@"
