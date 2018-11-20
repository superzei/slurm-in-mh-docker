#!/bin/bash

# deploy docker container
docker build -t honorlessman/slurm-worker:1.0 worker/ 
cd worker/ && \
docker-compose up -d && \
cd ../ 