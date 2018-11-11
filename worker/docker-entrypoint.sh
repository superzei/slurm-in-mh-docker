#!/bin/bash


echo "---> Starting the MUNGE Authentication service (munged) ..."
/bin/cp -f munge.key /etc/munge/
chown -R munge: /etc/munge /var/lib/munge /var/log/munge /var/run/munge
gosu munge /usr/sbin/munged --force

echo "---> Waiting for slurmctld to become active before starting slurmd..."

until 2>/dev/null >/dev/tcp/slurmctld/6817
do
    echo "-- slurmctld is not available.  Sleeping ..."
    sleep 2
done
echo "-- slurmctld is now active ..."

echo "---> Starting the Slurm Node Daemon (slurmd) ..."
exec /usr/sbin/slurmd -Dvvv