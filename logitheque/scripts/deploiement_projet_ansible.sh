#! /bin/bash
#Execute: deploiement_projet_ansible.sh

function usage
{
    echo "Usage : creation_projet_ansible.sh [[-a application_name] | [-h]]"
    echo ""
    echo "Options :"
    echo "  -a APP_NAME, --application APP_NAME"
    echo "                        Application name"
    echo "  -e ENV, --envir ENV   Deployment environment"
    echo "  -h, --help            show this help message and exit"
}

##### Main
echo "Vérification des paramètres"

appname=
env=

if [ $# -eq 0 ]; then
  usage
  exit
fi

while [ "$1" != "" ]; do
    case $1 in
        -a | --application )    shift
                                appname=$1
                                ;;
        -e | --envir )          shift
                                env=$1
                                ;;
        -h | --help )           usage
                                exit
                                ;;
        * )                     usage
                                exit 1
    esac
    shift
done

if [[ -z "$appname" || -z "$env" ]]; then
  usage
  exit
fi

PLATEFORME_HOST=`cat ~/plateforme_host`

# copy the ansible configuration file into the home directory
ssh sshuser@$PLATEFORME_HOST -p 2022 -oStrictHostKeyChecking=no -oUserKnownHostsFile=/dev/null "cp -u /opt/recipes/ansible.cfg ."

# Get the name of the inventory file
  . ~/workspace/$appname/src/config/$env/infra.properties
  
# execute the init playbook
ssh sshuser@$PLATEFORME_HOST -p 2022 -oStrictHostKeyChecking=no -oUserKnownHostsFile=/dev/null "ansible-playbook /opt/recipes/init.yml -i /opt/recipes/$inventory -e application=$appname -e env=$env"

# execute the playbooks for each directories in config/env, each directory being named after the name of the component it configures 
for dir in $(ls ~/workspace/$appname/src/config/$env)
do 
  cd ~/workspace/$appname/src/config/$env/$dir
  file=$(ls *yml)
  echo ssh sshuser@$PLATEFORME_HOST -p 2022 -oStrictHostKeyChecking=no -oUserKnownHostsFile=/dev/null "ansible-playbook /opt/recipes/$file -i /opt/recipes/$inventory -e application=$appname -e env=$env -e component_name=$dir -e configuration_file=$file"
  ssh sshuser@$PLATEFORME_HOST -p 2022 -oStrictHostKeyChecking=no -oUserKnownHostsFile=/dev/null "ansible-playbook /opt/recipes/$file -i /opt/recipes/$inventory -e application=$appname -e env=$env -e component_name=$dir -e configuration_file=$file"
done
