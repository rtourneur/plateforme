#!/bin/bash
#Execute: creation_depot_gitblit.sh

function usage
{
    echo "Usage : creation_depot_gitblit.sh [[[-u user ] [-a application_name] [-p project_name] [[-b base_folder]] | [-h]]"
    echo ""
    echo "Options :"
    echo "  -u USER, --user USER  Gitblit valid user"
    echo "  -a APP_NAME, --application APP_NAME"
    echo "                        Application name"
    echo "  -p PROJECT_NAME, --project PROJECT_NAME"
    echo "                        Project name"
    echo "  -b PATH, --base PATH  Base folder for project"
    echo "  -h, --help            show this help message and exit"
}
 

##### Main
echo "Vérification des paramètres"

user=
host=

if [ $# -eq 0 ]; then
  usage
  exit
fi

while [ "$1" != "" ]; do
    case $1 in
        -u | --user )           shift
                                user=$1
                                ;;
        -a | --application )    shift
                                appname=$1
                                ;;
        -p | --project )        shift
                                projectname=$1
                                ;;
        -b | --base )           shift
                                basefolder=$1
                                ;;
        -h | --help )           usage
                                exit
                                ;;
        * )                     usage
                                exit 1
    esac
    shift
done

if [[ -z "$user" || -z "$appname" || -z "$projectname" ]]; then
  usage
  exit
fi

repository=$projectname/$appname
if [ "$basefolder" ]; then
  repository=$basefolder/$repository
fi

read -s -p "Enter Password: " mypassword

sshpass -p $mypassword ssh $user@$GITBLIT_HOST -p 29418 -oStrictHostKeyChecking=no -oUserKnownHostsFile=/dev/null gitblit repositories new $repository

sshpass -p $mypassword ssh $user@$GITBLIT_HOST -p 29418 -oStrictHostKeyChecking=no -oUserKnownHostsFile=/dev/null gitblit teams perms developers  RW+:$repository
