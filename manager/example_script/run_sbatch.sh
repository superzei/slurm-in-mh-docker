#!/bin/bash

id=$(id -g $whoami)
my_dir=$(pwd)
command='{"run":"sbatch --priority='$id' job.sh", "pwd":"'$my_dir'"}'
curl slurmctld:5050 -d "${command}"
