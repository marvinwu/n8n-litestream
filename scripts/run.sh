#!/bin/bash
set -e


# if ENABLE_LITESTREAM is set to true, then run litestream
if [ "$ENABLE_LITESTREAM" = "true" ]; then
	echo "ENABLE_LITESTREAM is set to true"
	# Restore the database if it does not already exist.
	if [ -f /home/node/.n8n/database.sqlite ]; then
		echo "Database already exists, skipping restore"
	else
		echo "No database found, restoring from replica if exists"
		litestream restore -config /etc/litestream.yml  -if-replica-exists /home/node/.n8n/database.sqlite 
	fi

	# Run litestream with your app as the subprocess.
	exec litestream replicate -exec "n8n start"
else
	echo "ENABLE_LITESTREAM is set to false"
	exec n8n start
fi




