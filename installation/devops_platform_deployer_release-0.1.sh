#!/bin/bash
#Execute: sudo bash devops_platform_deployer_release-0.1.sh

function usage
{
    echo "Usage : devops_platform_deployer_release-0.1.sh [[[-u user ] [-i host]] | [-h]]"
    echo ""
    echo "Options :"
    echo "  -u USER, --user USER  Gitblit valid user"
    echo "  -i HOST, --inventory HOST"
    echo "                        Hostname for install (or ip adress)"
    echo "  -h, --help            show this help message and exit"
    exit 0
}
 

##### Main
echo "Vérification des paramètres"

user=
host=

while [ "$1" != "" ]; do
    case $1 in
        -u | --user )           shift
                                user=$1
                                ;;
        -i | --inventory )      host=$1
                                ;;
        -h | --help )           usage
                                exit
                                ;;
        * )                     usage
                                exit 1
    esac
    shift
done


echo '$user = ' $user
echo '$host = ' $host

#(Pre-req: python >= 2.7)

#First add the EPEL repository:
printf "**************************** ADDING EPEL REPOSITORY ****************************\n"
rpm -iUvh http://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm

# install git
printf "**************************** INSTALLING GIT ****************************\n"
yum install -y git

# pull platforme source code
printf "**************************** PULL PLATFORME SOURCE CODE ****************************\n"
git clone ssh://$user@git.polymont-itservices.fr:29418/Interne/4SASL00004-Devops/plateforme.git

# verify ssh installed
printf "**************************** INSTALL SSH (ANSIBLE PRE-REQ) ****************************\n"
yum install -y openssh-clients

#then run
printf "**************************** INSTALL ANSIBLE ****************************\n"
yum install -y ansible

#create ssh key
printf "**************************** CREATE SSH KEY AND DEPLOY IT ****************************\n"

# set ansible/hosts file
printf "**************************** SET HOSTS FOR ANSIBLE ****************************\n"
printf "[install-machines]\$host  ansible_ssh_user=root" > /etc/ansible/hosts-install
printf "[docker-machines]\$host  ansible_ssh_user=ansible" > /etc/ansible/hosts-docker

printf "**************************** DEPLOY THE PLATFORM ****************************\n"
ansible-playbook plateforme/installation/install_platforme.yml --skip-tags "update_all" -i /etc/ansible/hosts-install
ansible-playbook plateforme/installation/devops_plateforme.yml -i /etc/ansible/hosts-docker