#!/usr/bin/env bash
set -e

if ! command -v aws >/dev/null; then
  apt-get update -qq \
  && apt-get install -y -qq python3-pip \
  && pip3 install --no-cache-dir awscli
fi

exec "$@"
