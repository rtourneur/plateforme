#Image Remote
FROM polymont/ubuntu

MAINTAINER Raphael Tourneur <raphael.tourneur@polymont.fr>

# Add Redis, Git Curl, Zip and SSH
RUN apt-get update && apt-get install -y sshpass && rm -rf /var/lib/apt/lists/*

#add remote user
RUN useradd -p $(openssl passwd -1 '{{remote_user_password}}') -s /bin/bash -m remote

# Add rsa key
COPY id_rsa      /home/sshuser/.ssh/
RUN chown sshuser:sshuser /home/sshuser/.ssh/id_rsa 

#add volume
VOLUME /opt/scripts

#add scripts in sudoers for remote
RUN echo 'remote ALL=/opt/scripts/*.sh' >> /etc/sudoers

#Set gitblit hostname
RUN echo {{inventory_hostname}} > /home/remote/plateforme_host && chown remote /home/remote/plateforme_host