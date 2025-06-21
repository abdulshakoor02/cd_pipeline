#!/bin/bash

echo "Deploy crm script started at $(date)" >> ./erp_deploy.log

cd /home/wethinkdigital/myapps/crm                                                                                                           
git pull
npm run build
pm2 restart crm

echo "Deploy crm app script finished at $(date)" >> ./erp_deploy.log

