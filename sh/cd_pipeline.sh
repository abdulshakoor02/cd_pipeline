#!/bin/bash

source ~/.bashrc

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LOG_FILE="$SCRIPT_DIR/erp_deploy.log"

{
  echo "=============================="
  echo "Deploy cdapp script started at $(date)"

  cd /home/wethinkdigital/myapps/cd_pipeline || { echo "Failed to change directory"; exit 1; }

  echo "Pulling latest code from Git..."
  git pull || { echo "Git pull failed"; exit 1; }

  echo "download dependencies"
  go mod download || { echo "downloading dependencies failed"; exit 1; }

  echo "building the go app"
  go build -o app || { echo "building the go app failed"; exit 1; }

  echo "restarting the app"
  systemctl restart cdapp.service || { echo "restarting the app failed"; exit 1; }

  echo "Deploy cdapp script finished at $(date)"
} >> "$LOG_FILE" 2>&1
