#Execute: sudo bash devops_platform_deployer_release-0.1.sh

#(Pre-req: python >= 2.7)

#First add the EPEL repository:
printf "**************************** ADDING EPEL REPOSITORY ****************************\n"
rpm -iUvh http://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm

# install git
printf "**************************** INSTALLING GIT ****************************\n"
yum install -y git

# pull platforme source code
printf "**************************** PULL PLATFORME SOURCE CODE ****************************\n"
git clone ssh://PRENOM.NOM@git.polymont-itservices.fr:29418/Interne/4SASL00004-Devops/plateforme.git

# verify ssh installed
printf "**************************** INSTALL SSH (ANSIBLE PRE-REQ) ****************************\n"
yum install -y openssh-clients

#then run
printf "**************************** INSTALL ANSIBLE ****************************\n"
yum install -y ansible

# set ansible/hosts file
printf "**************************** SET ANSIBLE TO WORK LOCALLY ****************************\n"
printf "[local]\nlocalhost  ansible_connection=local" > /etc/ansible/hosts

printf "**************************** DEPLOY THE PLATFORM ****************************\n"
ansible-playbook plateforme/installation/install_platforme.yml --ask-sudo-pass --skip-tags "update_all"