#Image Remote
FROM polymont/ubuntu

MAINTAINER Raphael Tourneur <raphael.tourneur@polymont.fr>

#add remote user
RUN useradd -p $(openssl passwd -1 '{{remote_user_password}}') -s /bin/bash -m remote

#add volume
VOLUME /opt/scripts
