#!/bin/sh

# Custom actions before starting Node-RED
if [[ -f /var/run/.vcache_ready ]]; then
	echo "resetting vcache state file..."
	rm -f /var/run/.vcache_ready
fi

if [[ ! -e /etc/vcache/vcache.cfg ]]; then
	if [[ -r /etc/vcache/vcache.cfg.dist ]]; then
		echo "no vcache.cfg exists: copying default config..." 
		cp /etc/vcache/vcache.cfg.dist /etc/vcache/vcache.cfg
	else
		echo "no vcache.cfg exists: unable to copy default config: exiting..."
		exit 1
    fi
else
	echo "found existing vcache.cfg: starting..."
fi

if [[ -e /etc/vcache/vcache.version ]]; then
	echo "copying vcache.version to /var/run"
	cp /etc/vcache/vcache.version /var/run
fi

# Run the original entrypoint script
exec /usr/src/node-red/entrypoint.sh "$@"
