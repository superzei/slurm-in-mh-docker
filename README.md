# slurm-in-mh-docker

slurm in multi host docker with swarm

System construction instructions:
---------------------------------
 - (1) Insall nvidia-docker2(cuda toolkit is not required, only GPU driver is required) on all nodes.
 - (2) Docker containers need to use --runtime=nvidia, since we use compose you will need to execute [3].
 - (3) Create a swarm network on manager node.
 - (4) Run "sudo apt-get install nfs-common" on all nodes.
 - (5) On both manager and workers build base image. Run build_base.sh script.
 - (6) On manager machine execute [1], run build_run_manager.sh script to build manager image, nfs server and run them.
 - (7) On worker machines execute [2] to connect to swarm network. 
 - (8) On worker machines run run_worker.sh script to build worker image and contruct a container. You will need

[1]$ docker swarm join-token worker, response will be used in worker nodes
[2]Execute response of [1]
Build alpine to connect to network
docker run -it --name alpine<number> --network manager_slurm alpine
[3]Open /etc/docker/daemon.json with a text editor with root access. Add the first level key 
"default-runtime":"nvidia", then run "sudo service docker restart".
Scripts and what they do:
-------------------------
 - build_base.sh: Constructs base image, which contains required files and programs for slurm, required on all nodes.
 - build_run_manager.sh: Constructs manager image, then constructs manager and database containers. Also deploys a container for nfs server, which is used to share files within the network. Will pass the munge key to shared location for future usage.
 - run_worker.sh: Constructs worker image, and deploys a container for worker.
 - teardown.sh: Simply destroys everything as name suggests.


To go into bash
docker exec -it <worker|manager> bash

To add user to system
useradd -m /bin/bash <username>
    assign password to user
    passwd <username>

To send ssh request
ssh <username>@<host_ip> -p <user_port>


Note: Worker should not be destroyed while working, otherwise it will become down.
Controller should be rebooted and then worker should be rebooted.


Nvidia-docker2
--------------
This is a wrapper of docker by nvidia. It is required for a docker container to see GPU on host computer. Required for cuda 10+. Nvidia-docker(not 2) is required for older cuda versions.

MUNGE
-----
Munge used for security and dependency reasons. Sharing munge key was troublesome, required root access, but when root access is given raised an error saying "Too much permission given". So right now key is copied by hand as a temporary solution.

Shared File System
------------------
 - GlusterFS: Did not work because we were unable to mount it onto volumes.

 - NFS Server: A NFS server is automatically created with build_run_manager.sh script. Container has multiple shared volumes. DAtaset volume is not shared because it isn't necessarily need to be shared.

 - Samba: We tried to fix shared file system problem with samba, but we encountered some access privilege problems, therefore we abandoned this as well. 

User Management(Current approach)
---------------
A ssh server is required for login system. Users will send a ssh key to login to system. This is used so no one can go in to another ones directory without permission.

Users will have random passwords at first.

Login User Management: Slurm account is always admin. Users from login servers will have seperate files in the shared file system. Each type of user will have seperate scripts that will be executable by the users but not readable or writable.

Slurm User Management: There isn't a proper user management and login system within slurm. So this is not used all.

A deamon will consistently run in the background, checking for new files in user directories. Users will not be able to go into slurm manager bash. We do not want any user to interact with slurm.

/*
 - ?? admin userları oluşturcak, guestler adminden izin isteyecek.
 - ?? dev'deki dosya erişim izinleri sorulacak.
 - ?? passwordlar random başlayacak, kullanıcı değiştirebilecek mi?
 - ?? Bastilion ?
*/

Assumptions
-----------
 - (1) Everything are on docker, so we expect os in use to handle docker properly.
 - (2) We expect system to run continuously.
 - (3) We expect admin to add manage users.
 - (4) We expect all nodes are run on ubuntu 16.04 or on a nvidia-docker2 supported linux distro.
 - (5) We expect all nodes to have Nvidia GPU cards.

Requirements
------------
 - (1) All dependencies nvidia-docker2
 - (2) A Nvidia GPU, of course...
 - (3) Nvidia driver version of >= 410 (we tested it with 384, it didn't work) on host computers of all worker and manager containers.

