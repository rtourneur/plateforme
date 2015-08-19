FROM nginx

MAINTAINER Raphael Tourneur

RUN echo "deb http://mirrors.ircam.fr/pub/debian jessie main" >> /etc/apt/sources.list && \
    echo "deb http://mirrors.ircam.fr/pub/debian jessie-updates main" >> /etc/apt/sources.list 

# Add SSH
RUN apt-get update && apt-get install -y openssh-server openssh-client && rm -rf /var/lib/apt/lists/*

# Configure SSH and ssh user
RUN useradd -p $(openssl passwd -1 'novia69') -G sudo -s /bin/bash -m sshuser
# Add rsa public key
ADD id_rsa.pub  /home/sshuser/.ssh/authorized_keys
RUN chown sshuser:sshuser /home/sshuser/.ssh && chown sshuser:sshuser /home/sshuser/.ssh/* 
EXPOSE 22

CMD service ssh start && nginx -g "daemon off;"
