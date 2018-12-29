#!/bin/bash

# set ip of control node
export CONTROL_NODE_IP_ADDRESS=192.168.1.103

# base image name/version
export BASE_IMAGE=honorlessman/slurm-in-docker:1.2

# worker image name/version
export WORKER_IMAGE=honorlessman/slurm-worker:1.2

export NODE_NAME=$1

echo "Done"

# deploy docker container
docker build -t $WORKER_IMAGE --build-arg BASE_IMAGE ../worker/ 
cd ../ &&
cd worker/ && \
docker-compose up -d && \
cd ../ 
docker network connect manager_slurm $NODE_NAME
