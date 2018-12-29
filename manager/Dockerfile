ARG BASE_IMAGE
FROM $BASE_IMAGE

COPY secret/munge.key munge.key
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
COPY example_script/ example_script/
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
