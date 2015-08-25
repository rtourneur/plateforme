#Image Remote
FROM polymont/ubuntu

MAINTAINER Raphael Tourneur <raphael.tourneur@polymont.fr>

# Add Redis, Git Curl, Zip and SSH
RUN apt-get update && apt-get install -y sshpass && rm -rf /var/lib/apt/lists/*

#add remote user
RUN useradd -p $(openssl passwd -1 '{{remote_user_password}}') -s /bin/bash -m remote

#add volume
VOLUME /opt/scripts

#Set gitblit hostname
RUN echo {{inventory_hostname}} > /home/remote/gitblit_host && chown remote /home/remote/gitblit_host