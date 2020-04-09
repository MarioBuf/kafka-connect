#!/bin/sh

if [ -z "$NGROK_AUTH" ]; then
    exit 1
  else
    if [ -z "$HOSTNAME" ]; then
        exit 1
      else
        if [ -z "$REGION" ]; then
          exit 1
        fi
    fi
fi;

$ZOOKEEPER_HOME/bin/zkServer.sh start-foreground