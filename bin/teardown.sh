cd ../worker/

docker stop c1 && docker rm c1
docker stop c2 && docker rm c2

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

docker volume rm etc_munge \
            etc_slurm \
            slurm_jobdir \
            var_lib_mysql \
            var_log_slurm \
            login_home

docker volume rm $(docker volume ls --quiet --filter "name=manager")
docker volume rm $(docker volume ls --quiet --filter "name=worker")

docker network rm $(docker network ls --quiet --filter "name=worker")
docker network rm $(docker network ls --quiet --filter "name=manager")
