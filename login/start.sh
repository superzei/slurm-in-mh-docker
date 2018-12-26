export LOGIN_NODE_CONTAINER_NAME=login-test

docker build -t ssh-login .
docker run -v manager_login_home:/mnt/nfs/home -p 52022:22 -i --name $LOGIN_NODE_CONTAINER_NAME ssh-login 