#! /bin/bash
#Execute: deploiement_projet_ansible.sh

function usage
{
    echo "Usage : deploiement_projet_ansible.sh [[-a application_name] [-e env] | [-h]]"
    echo ""
    echo "Options :"
    echo "  -a APP_NAME, --application APP_NAME"
    echo "                        Application name"
    echo "  -e ENV, --envir ENV   Deployment environment"
    echo "  -h, --help            show this help message and exit"
}

#Retrieve the name of the container from the dir variable 
# the name of dir must follow : {name} or {d}-{name}
function getContainerName
{
  OLDIFS=$IFS
  IFS="-"
  read -a containers <<< "$(printf "%s" "$dir")"
  IFS=$OLDIFS
  if [ ${#containers[@]} -eq 2 ]; then
    container=${containers[1]}
  else
    container=$containers
  fi
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
ssh ansible@$PLATEFORME_HOST -p 2022 -oStrictHostKeyChecking=no -oUserKnownHostsFile=/dev/null "cp -u /opt/recipes/ansible.cfg ."

# Get the name of the inventory file
  . ~/workspace/$appname/src/config/$env/infra.properties
  
# execute the init playbook
echo execute init playbook
echo '...'
echo ssh ansible@$PLATEFORME_HOST -p 2022 -oStrictHostKeyChecking=no -oUserKnownHostsFile=/dev/null "ansible-playbook /opt/recipes/init.yml -i /opt/recipes/$inventory -e application=$appname -e env=$env"
echo '...'
ssh ansible@$PLATEFORME_HOST -p 2022 -oStrictHostKeyChecking=no -oUserKnownHostsFile=/dev/null "ansible-playbook /opt/recipes/init.yml -i /opt/recipes/$inventory -e application=$appname -e env=$env"
OUT=$?
if [ $OUT -ne 0 ]; then
  echo " Erreur d'initialisation"
  exit 1
fi

# execute the playbooks for each directories in config/env, each directory being named after the name of the component it configures 
# the name of directory must follow : {name} (if order not required) or {d}-{name} (if order is required, the sort is on {d})
for dir in $(ls ~/workspace/$appname/src/config/$env)
do
  if [ "$dir" != "infra.properties" ]; then
    cd ~/workspace/$appname/src/config/$env/$dir
    getContainerName
    file=$(ls *yml)
    echo '...'
    echo ssh ansible@$PLATEFORME_HOST -p 2022 -oStrictHostKeyChecking=no -oUserKnownHostsFile=/dev/null "ansible-playbook /opt/recipes/$file -i /opt/recipes/$inventory -e application=$appname -e env=$env -e component_name=$container -e configuration_file=$dir/$file"
    echo '...'
    ssh ansible@$PLATEFORME_HOST -p 2022 -oStrictHostKeyChecking=no -oUserKnownHostsFile=/dev/null "ansible-playbook /opt/recipes/$file -i /opt/recipes/$inventory -e application=$appname -e env=$env -e component_name=$container -e configuration_file=$dir/$file"
    OUT=$?
    if [ $OUT -ne 0 ]; then
      echo " Erreur de traitement"
      exit 1
    fi
  fi
done

