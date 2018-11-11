FROM honorlessman/slurm-in-docker:1.0

COPY secret/munge.key munge.key
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]