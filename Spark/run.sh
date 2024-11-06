#!/bin/sh

APACHE_DIR="$HOME/ApacheSpark"

if [ $# -eq 0 ]; then
	echo "Usage: run.sh <main class> [application arguments]"
	exit 1
fi

if [ $# -ge 1 ]; then
	echo "Starting master..."
	$APACHE_DIR/sbin/start-master.sh > /dev/null
	if [ $? -eq 0 ]; then
		echo "Master started successfully."
	else
		echo "Master already running."
	fi

	echo "Starting history server..."
	$APACHE_DIR/sbin/start-history-server.sh > /dev/null
	if [ $? -eq 0 ]; then
		echo "History server started successfully."
	else
		echo "History server already running."
	fi

	echo "Packaging application to deploy..."
	mvn package > /dev/null
	if [ $? -eq 0 ]; then
		echo "Packaging successful."
	else
		echo "Unable to package application."
		exit 1
	fi

	echo "Starting worker..."
	$APACHE_DIR/sbin/start-worker.sh spark://$SPARK_MASTER_HOST:7077
	if [ $? -eq 0 ]; then
		echo "Worker started successfully."
	else
		echo "Worker already running."
	fi

	echo "Submitting application..."
	$APACHE_DIR/bin/spark-submit --class $1 target/*.jar "${@:2}"
	if [ $? -eq 0 ]; then
		echo "Application submitted successfully."
	else
		echo "Unable to submit application."
	fi
fi
