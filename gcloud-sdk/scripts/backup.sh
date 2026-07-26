#!/bin/sh
set -e

echo "Authenticating to GCP..."
gcloud auth activate-service-account --key-file=/gcp/key.json

TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
BACKUP_FILE="db_backup_${TIMESTAMP}.dump"

echo "Dumping database and streaming to gs://${GCS_BUCKET}/${BACKUP_FILE}..."
# -Fc uses the custom compressed format, optimal for pg_restore.
# Streaming straight into gcloud storage avoids writing the full dump to local disk.
PGPASSWORD=$POSTGRES_PASSWORD pg_dump -h "$PG_HOST" -U "$PG_USER" -d "$PG_DB" -Fc | \
  gcloud storage cp - "gs://${GCS_BUCKET}/${BACKUP_FILE}"

echo "Backup complete: $BACKUP_FILE"
