FROM centos:7

MAINTAINER <niv.goor@polymont.fr>

#ssh
RUN yum install -y openssh-clients

# install ansible
RUN rpm -iUvh http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-5.noarch.rpm
RUN yum install -y ansible