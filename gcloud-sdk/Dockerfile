FROM gcr.io/google.com/cloudsdktool/google-cloud-cli:alpine
RUN apk add --no-cache --update curl

RUN gcloud components install kubectl

# Pinned to match Postgres 18 (the server version atrack runs) so pg_dump/pg_restore
# stay compatible with the server. Re-pin this if the server's major version changes.
RUN apk add --no-cache postgresql18-client

COPY scripts/backup.sh /opt/scripts/backup.sh
COPY scripts/restore.sh /opt/scripts/restore.sh
RUN chmod +x /opt/scripts/backup.sh /opt/scripts/restore.sh