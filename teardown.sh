cd worker/
docker-compose stop
docker-compose rm -sf

cd ../manager
docker-compose stop
docker-compose rm -sf

docker volume rm manager_etc_munge \
            manager_etc_slurm \
            manager_slurm_jobdir \
            manager_var_lib_mysql \
            manager_var_log_slurm

docker network rm manager_slurm