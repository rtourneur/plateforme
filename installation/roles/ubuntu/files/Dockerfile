FROM ubuntu:latest

MAINTAINER Abdallah BENBRAHIM

# Add Redis, Git Curl, Zip and SSH
RUN apt-get update && apt-get install -q -y git-core redis-server wget curl zip openssh-server openssh-client && rm -rf /var/lib/apt/lists/*

# Configure SSH and ssh user
RUN useradd -p $(openssl passwd -1 'novia69') -G sudo -s /bin/bash -m sshuser

# Add rsa public key
ADD id_rsa.pub  /home/sshuser/.ssh/authorized_keys
RUN chown sshuser:sshuser /home/sshuser/.ssh && chown sshuser:sshuser /home/sshuser/.ssh/* 

EXPOSE 22

# Start the service
ONBUILD CMD service ssh start && /bin/bash
CMD service ssh start && /bin/bash

