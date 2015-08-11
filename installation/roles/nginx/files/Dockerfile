FROM nginx

MAINTAINER Raphael Tourneur

# Add SSH
RUN apt-get update && apt-get install -y openssh-server openssh-client && rm -rf /var/lib/apt/lists/*

# Configure SSH and ssh user
RUN mkdir /home/sshuser && useradd -p $(openssl passwd -1 'novia69') -G sudo  sshuser && chown sshuser:sshuser /home/sshuser
# Add rsa public key
ADD id_rsa.pub  /home/sshuser/.ssh/authorized_keys
EXPOSE 22

CMD service ssh start && nginx -g "daemon off;"
