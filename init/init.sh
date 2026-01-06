#!/usr/bin/env bash
set -euo pipefail

echo "Waiting for SQL Server..."
for i in {1..60}; do
  sqlcmd -S localhost -U sa -P "$SA_PASSWORD" -C -Q "SELECT 1" >/dev/null 2>&1 && break
  sleep 2
done

# Find the backup file in the backup folder
BACKUP_FILE=$(ls /var/opt/mssql/backup/*.bak | head -n 1)

# Check if backup file was not found
if [ -z "$BACKUP_FILE" ]; then
  echo "No .bak file found in /var/opt/mssql/backup"
  exit 1
fi

echo "Found backup: $BACKUP_FILE"

sqlcmd \
  -S localhost \
  -U sa \
  -P "$SA_PASSWORD" \
  -C \
  -v BACKUP_FILE="$BACKUP_FILE" \
  -i /usr/src/app/restore.sql

echo "Restore complete."
