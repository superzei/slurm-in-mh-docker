username=$1
password=$2
raw_groups=($@)

groups="${raw_groups[@]:2}"
docker exec $LOGIN_NODE_CONTAINER_NAME bash -c "useradd $username -m -G $groups -s /bin/rbash"
docker exec $LOGIN_NODE_CONTAINER_NAME bash -c "echo "$1:$2" | chpasswd"