#!/bin/bash -l

time_default="00:20:00"
executable="./main"
job_name="my_job"
mem=0
cpu=1
# Configration file
conf_file=""
if [ $# -eq 0 ]
then
        conf_file="./main.conf"
else
        conf_file=$1
fi

#Create parameters list
parameters=()
# Read config file line by line
while IFS='' read -r line || [[ -n "$line" ]]; do
        # Check if comment
        if [[ ${line:0:1} == "#" ]]
        then
                continue
        fi
        # Read command
        command="$(cut -d'=' -f1 <<< $line)"
        parameter="$(cut -d'=' -f2 <<< $line)"
        # Check if command is param
        if [[ $command == "param" ]]
        then
                parameters+=($parameter)
        # Check if command is executable
        elif [[ $command == "executable" ]]
        then
                executable=$parameter
        # Check if and expected runtime is given
        elif [[ $command == "expected_runtime" ]]
        then
                if [[ $parameter =~ [0-1][0-9]:[0-5][0-9]:[0-5][0-9] ]]
                then
                        time_default=$parameter
                fi
        # Check if job name is specified
        elif [[ $command == "job_name" ]]
        then
                job_name=$parameter
        # Check if memeory required is specified
        elif [[ $command == "cpu_count" ]]
        then
                cpu=$parameter
        elif [[ $command == "memory" ]]
        then
                mem=$parameter
        fi
        # Can add extra commands if neccessary
done < "$conf_file"

#SBATCH -q debug           
#SBATCH -t $time_default
#SBATCH -job-name=$job_name
#SBATCH --nodes=1
#SBATCH --mem=$mem
#SBATCH --cpus-per-task=$cpu
# Priority should be set on terminal command.

#SBATCH --output=output.txt
#SBATCH --error=error.txt
# Sending mail needs a mail service, since we don't have any this doesn't work.
#SBATCH --mail-type=ALL
#SBATCH --mail-user=hakanaska@gmail.com

$executable ${parameters[@]:0:${#parameters[@]}}


