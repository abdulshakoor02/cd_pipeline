#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LOG_FILE="$SCRIPT_DIR/erp_deploy.log"

{
  echo "=============================="
  echo "Deploy erp_backend script started at $(date)"

  cd /home/wethinkdigital/myapps/erp_backend_go || { echo "Failed to change directory"; exit 1; }

  echo "Pulling latest code from Git..."
  git pull || { echo "Git pull failed"; exit 1; }

  echo "building the go app"
  make build || { echo "Docker restart failed"; exit 1; }

  echo "restarting the app"
  systemctl restart cdapp.service || { echo "restarting the app failed"; exit 1; }

  echo "Deploy erp_backend script finished at $(date)"
} >> "$LOG_FILE" 2>&1
