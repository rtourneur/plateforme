#Execute: sudo bash install_ansible.sh

#(Pre-req: python >= 2.7)

#First add the EPEL repository:
rpm -iUvh http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-5.noarch.rpm

# verify ssh installed
yum install -y openssh-clients

#then run
yum install -y ansible

# set ansible/hosts file