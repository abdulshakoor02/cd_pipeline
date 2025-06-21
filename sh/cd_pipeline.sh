#!/bin/bash

echo "Deploy cd app script started at $(date)" >> ./erp_deploy.log

cd /home/wethinkdigital/myapps/cd_pipeline                                                                                                           
git pull
docker restart cd_pipeline

echo "Deploy cd app script finished at $(date)" >> ./erp_deploy.log

