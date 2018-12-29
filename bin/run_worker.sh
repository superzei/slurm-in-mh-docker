#!/bin/bash

# set ip of control node
export CONTROL_NODE_IP_ADDRESS=192.168.1.108

# deploy docker container
docker build -t honorlessman/slurm-worker:1.1 ../worker/ 
cd ../ &&
cd worker/ && \
docker-compose up -d && \
cd ../ 
docker network connect manager_slurm c1
