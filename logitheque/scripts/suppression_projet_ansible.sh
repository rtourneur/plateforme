#! /bin/bash
#Execute: suppression_projet_ansible.sh

function usage
{
    echo "Usage : suppression_projet_ansible.sh [[-a application_name] [-e env] | [-h]]"
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

# execute the reset playbook
echo execute reset playbook
echo '...'
echo su -l sshuser -c "ssh ansible@$PLATEFORME_HOST -p 2022 -oStrictHostKeyChecking=no -oUserKnownHostsFile=/dev/null \"ansible-playbook /opt/recipes/reset.yml -i /opt/recipes/docker-$PLATEFORME_HOST -e application=$appname -e env=$env\""
echo '...'
su -l sshuser -c "ssh ansible@$PLATEFORME_HOST -p 2022 -oStrictHostKeyChecking=no -oUserKnownHostsFile=/dev/null \"ansible-playbook /opt/recipes/reset.yml -i /opt/recipes/docker-$PLATEFORME_HOST -e application=$appname -e env=$env\""
OUT=$?
if [ $OUT -ne 0 ]; then
  echo " Erreur de suppression"
  exit 1
fi
