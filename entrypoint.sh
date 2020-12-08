#!/bin/bash
set -e

# Remove um pontencial pre-existente server.pid para o Rails.
rm -f /onebitexchange/tmp/pids/server.pid

# Então executa o processo principal do container main (Que está setado como CMD no Dockerfile)
exec "$@"