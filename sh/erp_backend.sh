#!/bin/bash

echo "Deploy erp_backend script started at $(date)" >> ./erp_deploy.log

cd /home/wethinkdigital/myapps/erp_backend_go                                                                                                           
git pull
docker restart erp_backend

echo "Deploy erp_backend script finished at $(date)" >> ./erp_deploy.log

