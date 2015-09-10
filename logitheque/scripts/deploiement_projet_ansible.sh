#! /bin/bash
#Execute: deploiement_projet_ansible.sh

function usage
{
    echo "Usage : creation_projet_ansible.sh [[-a application_name] | [-h]]"
    echo ""
    echo "Options :"
    echo "  -a APP_NAME, --application APP_NAME"
    echo "                        Application name"
    echo "  -h, --help            show this help message and exit"
}

##### Main
echo "Vérification des paramètres"

appname=

if [ $# -eq 0 ]; then
  usage
  exit
fi

while [ "$1" != "" ]; do
    case $1 in
        -a | --application )    shift
                                appname=$1
                                ;;
        -h | --help )           usage
                                exit
                                ;;
        * )                     usage
                                exit 1
    esac
    shift
done

if [[ -z "$appname" ]]; then
  usage
  exit
fi

PLATEFORME_HOST=`cat ~/plateforme_host`

# Exemple de création du dossier de l'application dans le conteneur ansible tout en utilsant une commande ansible Ad-Hoc 
ssh sshuser@$PLATEFORME_HOST -p 2022 -oStrictHostKeyChecking=no -oUserKnownHostsFile=/dev/null "ansible localhost -m file -a 'dest=/home/sshuser/$appname state=directory'"