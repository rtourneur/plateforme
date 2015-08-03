FROM ubuntu:latest

MAINTAINER Abdallah BENBRAHIM

RUN apt-get update
RUN apt-get install -q -y git-core redis-server

# Add Curl, Zip and SSH
RUN apt-get install -y wget curl zip openssh-server openssh-client && rm -rf /var/lib/apt/lists/*


# Configure SSH and ssh user
RUN mkdir /home/sshuser && useradd -p $(openssl passwd -1 'novia69') -G sudo  sshuser && chown sshuser:sshuser /home/sshuser
EXPOSE 22

# Start the service
ONBUILD CMD service ssh start && /bin/bash
CMD service ssh start && /bin/bash

