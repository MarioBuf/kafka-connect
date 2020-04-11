#!/bin/sh -e

if [ -z "$NGROK_AUTH" ]; then
      echo "YOU MUST SPECIFY AN AUTHENTICATION TOKEN WITH -eNGROK_AUTH"
      exit 1
fi

if [ -z "$HOSTNAME" ]; then
      echo "YOU MUST SPECIFY AN HOSTNAME WITH -eHOSTNAME"
      exit 1
fi

if [ -z "$REGION" ]; then
      echo "YOU MUST SPECIFY A REGION WITH -eREGION"
      exit 1
fi

set -x
exec supervisord -n