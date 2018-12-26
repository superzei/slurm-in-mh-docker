#!/bin/bash

# deploy docker container
docker build -t honorlessman/slurm-worker:1.1 ../worker/ 
cd ../ &&
cd worker/ && \
docker-compose up -d && \
cd ../ 