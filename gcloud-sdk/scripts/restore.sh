#!/bin/sh
set -e

echo "Authenticating to GCP..."
gcloud auth activate-service-account --key-file=/gcp/key.json

if [ -z "$TARGET_BACKUP" ] || [ "$TARGET_BACKUP" = "latest" ]; then
  echo "Finding latest backup in gs://$GCS_BUCKET/..."
  LATEST_FILE=$(gcloud storage ls "gs://$GCS_BUCKET/*.dump" | sort | tail -n 1)
  if [ -z "$LATEST_FILE" ]; then
    echo "Error: No .dump backups found in bucket!"
    exit 1
  fi
  TARGET_GCS_URI=$LATEST_FILE
else
  TARGET_GCS_URI="gs://$GCS_BUCKET/$TARGET_BACKUP"
fi

RESTORE_FILE="${CLOUDSDK_CONFIG:-/tmp}/restore.dump"

echo "Downloading $TARGET_GCS_URI..."
gcloud storage cp "$TARGET_GCS_URI" "$RESTORE_FILE"

echo "Restoring database..."
# -c drops objects before recreating them. --if-exists prevents errors on clean drops.
PGPASSWORD=$POSTGRES_PASSWORD pg_restore -h "$PG_HOST" -U "$PG_USER" -d "$PG_DB" -c --if-exists "$RESTORE_FILE"

echo "Restore completed successfully."
