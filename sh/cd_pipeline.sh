#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LOG_FILE="$SCRIPT_DIR/erp_deploy.log"

{
  echo "=============================="
  echo "Deploy script started at $(date)"

  cd /home/wethinkdigital/myapps/cd_pipeline || { echo "Failed to change directory"; exit 1; }

  echo "Pulling latest code from Git..."
  git pull || { echo "Git pull failed"; exit 1; }

  echo "Restarting Docker container..."
  docker restart cd_pipeline || { echo "Docker restart failed"; exit 1; }

  echo "Deploy script finished at $(date)"
} >> "$LOG_FILE" 2>&1
