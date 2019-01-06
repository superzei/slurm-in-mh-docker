#!/bin/bash
my_dir=$(pwd)
if [ $# -eq 0 ]
then
        default_make="make"
else
        default_make=$1
fi

command='{"run":"'$default_make'", "pwd":"'$my_dir'"}'
curl slurmctld:5050 -d "${command}"
