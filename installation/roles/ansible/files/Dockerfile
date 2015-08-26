# Latest version of centos
FROM centos:centos7

MAINTAINER Abdallah BENBRAHIM <abdallah.benbrahim@polymont.fr>

#RUN yum -y update && \
# install epel and some utilities, install openSsh server. This server needs 
# default keys we need to create here. These keys are not used by Ansible 
# (just here for things to work).
RUN yum -y install epel-release && \
    yum -y install PyYAML python-jinja2 python-httplib2 python-keyczar python-paramiko \
         python-setuptools git python-pip openssl openssh-clients openssh-server ansible && \
    ssh-keygen -q -N "" -t dsa -f /etc/ssh/ssh_host_ecdsa_key && \
    ssh-keygen -q -N "" -t rsa -f /etc/ssh/ssh_host_rsa_key && \
    ssh-keygen -q -N "" -t ed25519 -f /etc/ssh/ssh_host_ed25519_key

# Static environment variables
ENV ANSIBLE_HOSTS=/etc/ansible/hosts 

# configure SSH and ssh user
# note that "-G wheel" enables running in "wheel" group, that is, in centos, the sudoers group
RUN useradd --create-home -G wheel -s/bin/bash sshuser -p $(openssl passwd -1 'novia69')

# Add rsa keys
#  |___ id_rsa
#  |___ id_rsa.pub
# these keys are the main platform keys. The container created from this image 
# will be able to connect via SSH to all containers of the platform configured 
# with these keys (see  usage of id_rsa.pub in some dockerfiles, for example in
# polymont/ubuntu image)
ADD  id_rsa.pub  /home/sshuser/.ssh/authorized_keys
COPY id_rsa      /home/sshuser/.ssh/
RUN chown sshuser:sshuser /home/sshuser/.ssh && chown sshuser:sshuser /home/sshuser/.ssh/* 

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
