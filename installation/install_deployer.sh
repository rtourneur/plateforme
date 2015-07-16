#Execute: sudo bash install_ansible.sh

#(Pre-req: python >= 2.7)

#First add the EPEL repository:
printf "**************************** ADDING EPEL REPOSITORY ****************************"
rpm -iUvh http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-5.noarch.rpm

# install git
printf "**************************** INSTALLING GIT ****************************"
yum install -y git

# pull platforme source code
printf "**************************** PULL PLATFORME SOURCE CODE ****************************"
git clone ssh://niv.goor@git.polymont-itservices.fr:29418/Interne/4SASL00004-Devops/plateforme.git

# verify ssh installed
printf "**************************** INSTALL SSH (ANSIBLE PRE-REQ) ****************************"
yum install -y openssh-clients

#then run
printf "**************************** INSTALL ANSIBLE ****************************"
yum install -y ansible

# set ansible/hosts file
printf "**************************** SET ANSIBLE TO WORK LOCALLY ****************************"
printf "[local]\nlocalhost  ansible_connection=local" > /etc/ansible/hosts