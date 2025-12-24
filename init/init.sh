#!/usr/bin/env bash
set -euo pipefail

echo "Waiting for SQL Server to be ready..."
for i in {1..60}; do
  sqlcmd -S localhost -U sa -P "${SA_PASSWORD}" -C -Q "SELECT 1" >/dev/null 2>&1 && break
  sleep 2
done

echo "SQL Server is up. Running restore script..."
sqlcmd -S localhost -U sa -P "${SA_PASSWORD}" -C -i /usr/src/app/restore.sql

echo "Init complete."
