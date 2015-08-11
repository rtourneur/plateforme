# Latest version of centos
FROM centos:centos7

MAINTAINER Abdallah BENBRAHIM <abdallah.benbrahim@polymont.fr>

RUN yum clean all && \
    yum -y update && \
    yum -y install epel-release && \
    yum -y install PyYAML python-jinja2 python-httplib2 python-keyczar python-paramiko python-setuptools git python-pip openssl && \
    yum -y install ansible

# Static environment variables
ENV ANSIBLE_HOSTS=/etc/ansible/hosts
ENV PATH=/opt/ansible/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
ENV PYTHONPATH=/opt/ansible/lib:
ENV MANPATH=/opt/ansible/docs/man:

# configure SSH and ssh user
RUN useradd --create-home -G wheel -s/bin/bash sshuser -p $(openssl passwd -1 'novia69')

# Add rsa keys
#  |___ id_rsa
#  |___ id_rsa.pub
ADD  id_rsa.pub  /home/sshuser/.ssh/authorized_keys
COPY id_rsa      /home/sshuser/.ssh/

# configure SSH and ssh user
# RUN mkdir /home/sshuser && useradd -p $(openssl passwd -1 'novia69') -G sudo  sshuser && chown sshuser:sshuser /home/sshuser
EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
