#!/bin/bash

# deploy a nfs server
docker run -d --privileged --restart=always \
 -v $PWD/../nfs:/nfs \
 -e NFS_EXPORT_DIR_1=/nfs \
 -e NFS_EXPORT_DOMAIN_1=\* \
 -e NFS_EXPORT_OPTIONS_1=rw,insecure,no_subtree_check,no_root_squash,fsid=1 \
 -p 111:111 -p 111:111/udp \
 -p 2049:2049 -p 2049:2049/udp \
 -p 32765:32765 -p 32765:32765/udp \
 -p 32766:32766 -p 32766:32766/udp \
 -p 32767:32767 -p 32767:32767/udp \
 --name slurm-nfs-server \
 fuzzle/docker-nfs-server:latest


# creating volumes on nfs
docker exec slurm-nfs-server bash -c 'mkdir /nfs/slurm_jobdir && chown -R 1000 /nfs/slurm_jobdir && chmod -R 777 /nfs/slurm_jobdir && chgrp -R 1000 /nfs/slurm_jobdir'
docker exec slurm-nfs-server bash -c 'mkdir /nfs/etc_munge && chown -R 1000 /nfs/etc_munge && chmod -R 777 /nfs/etc_munge && chgrp -R 1000 /nfs/etc_munge'
docker exec slurm-nfs-server bash -c 'mkdir /nfs/etc_slurm && chown -R 1000 /nfs/etc_slurm && chmod -R 777 /nfs/etc_slurm && chgrp -R 1000 /nfs/etc_slurm'
docker exec slurm-nfs-server bash -c 'mkdir /nfs/var_log_slurm && chown -R 1000 /nfs/var_log_slurm && chmod -R 777 /nfs/var_log_slurm  && chgrp -R 1000 /nfs/var_log_slurm'
docker exec slurm-nfs-server bash -c 'mkdir /nfs/home'

# building volumes on docker

# deploying container
cd ../ && \
docker build -t honorlessman/slurm-manager:1.0 manager/ && \
cd manager/ && \
docker-compose up -d && \
cd ../