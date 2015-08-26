#!/bin/bash
#Execute: sudo bash devops_platform_deployer_release-0.1.sh

###### Devops platform deployer script ######

# usage reminder output
function usage
{
    echo "Usage : devops_platform_deployer_release-0.1.sh [[[-u user ] [-i host]] | [-h]]"
    echo ""
    echo "Options :"
    echo "  -u USER, --user USER  Gitblit valid user"
    echo "  -i HOST, --inventory HOST"
    echo "                        Hostname for install (or ip adress)"
    echo "  -h, --help            show this help message and exit"
}
 

##### Main
echo "Vérification des paramètres"

user=
host=

if [ $# -eq 0 ]; then
  echo "test"
  usage
  exit
fi

# extract command parameters
while [ "$1" != "" ]; do
    case $1 in
        -u | --user )           shift
                                user=$1
                                ;;
        -i | --inventory )      shift
                                host=$1
                                ;;
        -h | --help )           usage
                                exit
                                ;;
        * )                     usage
                                exit 1
    esac
    shift
done

if [[ -z "$user" || -z "$host" ]]; then
  usage
  exit
fi

echo '$user = ' $user
echo '$host = ' $host

#(Pre-req: python >= 2.7)

# Installation of the tools required for the platform deployment (installation). The main tool is Ansible.

#First add the EPEL repository:
printf "**************************** ADDING EPEL REPOSITORY ****************************\n"
sudo rpm -iUvh http://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm

# install git
printf "**************************** INSTALLING GIT ****************************\n"
sudo yum install -y git

# pull platform source code from the repository
printf "**************************** PULL PLATFORME SOURCE CODE ****************************\n"
git clone ssh://$user@git.polymont-itservices.fr:29418/Interne/4SASL00004-Devops/plateforme.git

# verify ssh is installed
printf "**************************** INSTALL SSH (ANSIBLE PRE-REQ) ****************************\n"
sudo yum install -y openssh-clients sshpass

#then run ansible installation
printf "**************************** INSTALL ANSIBLE ****************************\n"
sudo yum install -y ansible

#create rsa key used for SSH connection from Ansible to containers of the platform 
printf "**************************** CREATE SSH KEY  ****************************\n"
ssh-keygen -t rsa -b 2048
ssh-copy-id -i ~/.ssh/id_rsa root@$host

# set ansible/hosts file
printf "**************************** SET HOSTS FOR ANSIBLE ****************************\n"
# create Ansible inventory file and configure the installer Host
echo '[install-machines]' > ~/hosts-install && echo $host '  ansible_ssh_user=root' >> ~/hosts-install
# create Ansible inventory file and configure the docker Host
echo '[docker-machines]' > ~/hosts-docker && echo $host '  ansible_ssh_user=ansible' >> ~/hosts-docker

printf "**************************** DEPLOY THE PLATFORM ****************************\n"
# using the installation playbook and the installer inventory file, run the install process
ansible-playbook plateforme/installation/install_platforme.yml --skip-tags "update_all" -i ~/hosts-install --extra-vars "host-fqdn=$host"
OUT=$?
if [ $OUT -ne 0 ]; then
  echo " Erreur d'installation phase 1"
  exit 1
fi

ansible-playbook plateforme/installation/devops_plateforme.yml -i ~/hosts-docker
OUT=$?
if [ $OUT -ne 0 ]; then
  echo " Erreur d'installation phase 2"
  exit 1
fi

printf "**************************** REMOVE PLATFORM SOURCE CODE ****************************\n"
rm -rf plateforme
