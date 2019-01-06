ARG BASE_IMAGE
FROM $BASE_IMAGE

ENV container docker

COPY secret/munge.key munge.key
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
COPY example_script/ example_script/

RUN cp example_script/job /usr/bin

RUN pip install flask

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
