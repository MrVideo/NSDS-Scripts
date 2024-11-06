# NSDS Scripts

These are some scripts that I use to start and stop components of the various technologies used in the *Networked Software for Distributed Systems* course at PoliMi.

## Spark

These scripts start and stop the Apache Spark Master, History Server and Workers. The `start.sh` script also submits an automatically generated `jar` file to an active worker after activation.

To use, make sure that:

- The scripts are in the base directory of your project folder
- You are using Maven correctly
- The `target` folder contains the `jar` file to be submitted to the worker
- Your Spark home is `~/ApacheSpark`
