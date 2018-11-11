docker build -t honorlessman/slurm-manager:1.0 manager/ 
cd manager/ && \
docker-compose up -d && \
cd ../