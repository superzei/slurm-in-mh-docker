group_name=$1

docker exec $LOGIN_NODE_CONTAINER_NAME bash -c "gpasswd -M $@ $group_name"