#!/bin/sh

APACHE_DIR="$HOME/ApacheSpark"

echo "Stopping master..."
$APACHE_DIR/sbin/stop-master.sh > /dev/null
if [ $? -eq 0 ]; then
	echo "Master stopped."
else
	echo "Unable to stop master."
	exit 1
fi

echo "Stopping history server..."
$APACHE_DIR/sbin/stop-history-server.sh > /dev/null
if [ $? -eq 0 ]; then
	echo "History server stopped."
else
	echo "Unable to stop history server."
	exit 1
fi

echo "Stopping workers..."
$APACHE_DIR/sbin/stop-worker.sh > /dev/null
if [ $? -eq 0 ]; then
	echo "Workers stopped."
else
	echo "Unable to stop workers."
	exit 1
fi
