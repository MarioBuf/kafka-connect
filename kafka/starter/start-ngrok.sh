#!/bin/sh -e

if [ -z "$NGROK_AUTH" ]; then
    echo "YOU MUST SPECIFY AN AUTHENTICATION TOKEN WITH -eNGROK_AUTH"
    exit 1
  else
    if [ -z "$HOSTNAME" ]; then
        echo "YOU MUST SPECIFY AN HOSTNAME WITH -eHOSTNAME"
        exit 1
      else
        if [ -z "$REGION" ]; then
          echo "YOU MUST SPECIFY A REGION WITH -eREGION"
          exit 1
        fi
    fi
fi;

if [ -n "$NGROK_AUTH" ]; then
  $HOME/ngrok authtoken $NGROK_AUTH
fi

set -x
exec $HOME/ngrok http -region=$REGION -hostname=$HOSTNAME localhost:8000