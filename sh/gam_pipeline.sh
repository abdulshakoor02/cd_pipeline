#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LOG_FILE="$SCRIPT_DIR/erp_deploy.log"

{
  echo "=============================="
  echo "Deploy crm script started at $(date)"

  cd /home/wethinkdigital/myapps/gam_website || { echo "Failed to change directory"; exit 1; }

  echo "Pulling latest code from Git..."
  git pull || { echo "Git pull failed"; exit 1; }

  echo "building the next crm app"
  ~/.nvm/versions/node/v21.1.0/bin/npm run build || { echo "building the crm app failed"; exit 1; }

  echo "restarting the app"
  ~/.nvm/versions/node/v21.1.0/bin/pm2 restart gam || { echo "restarting the app failed"; exit 1; }

  echo "Deploy cdapp script finished at $(date)"
} >> "$LOG_FILE" 2>&1
