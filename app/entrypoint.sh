#!/bin/sh
# Replace placeholders with actual environment variables
envsubst < /etc/serles/config.ini.template > /etc/serles/config.ini

# Execute the main process
exec "$@"
