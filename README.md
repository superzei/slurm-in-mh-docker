# slurm-in-mh-docker

slurm in multi host docker with swarm

System construction instructions:
(1) On both manager and workers build base image. Run build_base.sh script.
(2) On manager machine run build_run_manager.sh script to build manager image, nfs server and run them.
(3) On worker machines execute [1] to connect to swarm network. 
(4) On worker machines run run_worker.sh script to build worker image and contruct a container.

[1]Build alpine to connect to network
docker run -it --name alpine<number> --network manager_slurm alpine

Scripts and what they do:
build_base.sh: Constructs base image, which contains required files and programs for slurm, required on all nodes.
build_run_manager.sh: Constructs manager image, then constructs manager and database containers. Also deploys a container for nfs server, which is used to share files within the network. Will pass the munge key to shared location for future usage.
run_worker.sh: Constructs worker image, and deploys a container for worker.
teardown.sh: Simply destroys everything as name suggests.


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

MUNGE
-----

Munge used for security and dependency reasons. Sharing munge key was troublesome, required root access, but when root access is given raised an error saying "Too much permission given". So right now key is copied by hand as a temporary solution.


Shared File System
------------------
GlusterFS: Did not work because we were unable to mount it onto volumes.

NFS Server: A NFS server is automatically created with build_run_manager.sh script. Container has multiple shared volumes. DAtaset volume is not shared because it isn't necessarily need to be shared.

Samba: We tried to fix shared file system problem with samba, but we encountered some access privilege problems, therefore we abandoned this as well. 

User Management
---------------

A ssh server is required for login system. Users will send a ssh key to login to system. This is used so no one can go in to another ones directory without permission.

Users will have random passwords at first.

Login User Management: Slurm account is always admin. Users from login servers will have seperate files in the shared file system. Each type of user will have seperate scripts that will be executable by the users but not readable or writable.

Slurm User Management: There isn't a proper user management and login system within slurm. So this is not used all.

A deamon will consistently run in the background, checking for new files in user directories. Users will not be able to go into slurm manager bash. We do not want any user to interact with slurm.


?? admin userları oluşturcak, guestler adminden izin isteyecek.
?? dev'deki dosya erişim izinleri sorulacak.
?? passwordlar random başlayacak, kullanıcı değiştirebilecek mi?
?? Bastilion ?
?? Nvidia driver mount pointleri base de mi olucak yoksa worker da yeter mi?


Assumptions
-----------
(1) Everything are on docker images, so we expect os in use to handle docker properly.
(2) We expect system to run continuously.
(3) We expect admin to add manage users.
(3)

