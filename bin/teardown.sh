cd ../worker/
docker-compose stop
docker-compose rm -sf

cd ../manager
docker-compose stop
docker-compose rm -sf

 # removing existing volumes on nfs
 # just incase
docker exec slurm-nfs-server rm -rf /nfs/slurm_jobdir
docker exec slurm-nfs-server rm -rf /nfs/etc_munge
docker exec slurm-nfs-server rm -rf /nfs/etc_slurm
docker exec slurm-nfs-server rm -rf /nfs/var_log_slurm

docker stop slurm-nfs-server
docker rm slurm-nfs-server

docker volume rm manager_etc_munge \
            manager_etc_slurm \
            manager_slurm_jobdir \
            manager_var_lib_mysql \
            manager_var_log_slurm \
            manager_login_home

docker volume rm etc_munge \
            etc_slurm \
            slurm_jobdir \
            var_lib_mysql \
            var_log_slurm \
            login_home

docker network rm manager_slurm