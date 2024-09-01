#!/bin/bash

if [ -z "$1" ] || [ -z "$2" ]; then
  echo "Usage: $0 <AppName> <AppURL>"
  exit 1
fi

APP_NAME="$1"
APP_URL="$2"

if [[ "$APP_URL" == *.app ]]; then
  APP_URL="${APP_URL}/Contents/MacOS/$APP_NAME"
fi

PID=$(pgrep -x "$APP_NAME")

if [ ! -z "$PID" ]; then
  echo "Killing $APP_NAME with PID $PID..."
  kill -9 $PID
  sleep 1
else
  echo "$APP_NAME is not running."
fi

echo "Restarting $APP_NAME..."

eval "$APP_URL"

echo "$APP_NAME has been restarted."
