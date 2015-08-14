# Latest version of centos
FROM centos:centos7

MAINTAINER Abdallah BENBRAHIM <abdallah.benbrahim@polymont.fr>

RUN yum -y update && \
    yum -y install epel-release PyYAML python-jinja2 python-httplib2 python-keyczar python-paramiko \
         python-setuptools git python-pip openssl openssh-clients openssh-server ansible && \
    rm -f /etc/ssh/ssh_host_ecdsa_key /etc/ssh/ssh_host_rsa_key && \
    ssh-keygen -q -N "" -t dsa -f /etc/ssh/ssh_host_ecdsa_key && \
    ssh-keygen -q -N "" -t rsa -f /etc/ssh/ssh_host_rsa_key && \
    ssh-keygen -q -N "" -t ed25519 -f /etc/ssh/ssh_host_ed25519_key

# Static environment variables
ENV ANSIBLE_HOSTS=/etc/ansible/hosts 

# configure SSH and ssh user
RUN useradd --create-home -G wheel -s/bin/bash sshuser -p $(openssl passwd -1 'novia69')

# Add rsa keys
#  |___ id_rsa
#  |___ id_rsa.pub
ADD  id_rsa.pub  /home/sshuser/.ssh/authorized_keys
COPY id_rsa      /home/sshuser/.ssh/
RUN chown sshuser:sshuser /home/sshuser/.ssh && chown sshuser:sshuser /home/sshuser/.ssh/* 

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
