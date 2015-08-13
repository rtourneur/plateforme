FROM registry:2

MAINTAINER Raphael Tourneur

# Add SSH
RUN apt-get update && apt-get install -y openssh-server openssh-client && rm -rf /var/lib/apt/lists/*

# Configure SSH and ssh user
RUN useradd -p $(openssl passwd -1 'novia69') -G sudo -s /bin/bash -m sshuser

# Add rsa public key
ADD id_rsa.pub  /home/sshuser/.ssh/authorized_keys
RUN chown sshuser:sshuser /home/sshuser/.ssh && chown sshuser:sshuser /home/sshuser/.ssh/* 

EXPOSE 22

# Add launch script
ENV DISTRIBUTION_DIR /go/src/github.com/docker/distribution
WORKDIR $DISTRIBUTION_DIR
COPY registry.sh $DISTRIBUTION_DIR/registry.sh

ENTRYPOINT exec ./registry.sh

