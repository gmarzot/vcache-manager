#!/bin/sh
set -e

# Set permissions on the dynamically created volume
chmod -R ugo+rwx /var/run

# Start the original entrypoint or command
exec "$@"
