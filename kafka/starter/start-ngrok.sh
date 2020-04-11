#!/bin/sh -e

if [ -n "$NGROK_AUTH" ]; then
  $HOME/ngrok authtoken $NGROK_AUTH
fi

set -x
exec $HOME/ngrok http -region=$REGION -hostname=$HOSTNAME localhost:8000