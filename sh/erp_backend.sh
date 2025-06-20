#!/bin/bash

echo "Deploy script started at $(date)" >> ./erp_deploy.log

cd /home/wethinkdigital/myapps/erp_backend_go                                                                                                           
git pull
docker restart erp_backend

echo "Deploy script finished at $(date)" >> ./erp_deploy.log

