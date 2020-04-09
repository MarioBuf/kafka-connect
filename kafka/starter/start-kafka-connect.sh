#!/bin/sh -e
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

exec java -jar /opt/bin/kafka-connect-0.1.jar