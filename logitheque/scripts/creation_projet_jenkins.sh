#! /bin/bash

#################################################################################################################################################################
#Execute: creation_projet_jenkins.sh

function usage
{
    echo "Usage : creation_projet_jenkins.sh [[[-u USER ] [-a application_name] [-p project_name] [[-b base_folder] [-j JDK_VERSION] [-m MAVEN_VERSION] [-g GOALS_VALUE]] | [-h]]"
    echo ""
    echo "Options :"
    echo "  -u USER, --user USER  Jenkins valid user"
    echo "  -j JDK_VERSION, --jdk-version JDK_VERSION"
    echo "                        JDK version"
    echo "  -m MAVEN_VERSION, --maven-version MAVEN_VERSION"
    echo "                        Maven version"
    echo "  -g GOALS_VALUE, --goals-value GOALS_VALUE"
    echo "                        goals value"
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
appname=
projectname=

if [ $# -eq 0 ]; then
  usage
  exit
fi

while [ "$1" != "" ]; do
    case $1 in
        -u | --user )           shift
                                user=$1
                                ;;
        -j | --jdk-version )    shift
                                jdkversion=$1
                                ;;
        -m | --maven-version )  shift
                                mavenversion=$1
                                ;;
        -g | --goals-value )    shift
                                mavengoals=$1
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

if [[ -z "$jdkversion" ]]; then
  jdkversion='JDK 8'
fi

if [[ -z "$mavenversion" ]]; then
  mavenversion='MAVEN 3.3'
fi

if [[ -z "$mavengoals" ]]; then
  mavengoals='clean install'
fi

PLATEFORME_HOST=`cat ~/plateforme_host`

repository=$projectname"\/"$appname
if [ "$basefolder" ]; then
  repository=$basefolder"\/"$repository
fi

giturl="git:\/\/"$PLATEFORME_HOST"\/"$repository.git

read -s -p "Enter Password: " mypassword

# Appelle curl en specifiant l'utilisateur et en verifiant la reponse de Jenkins
# arg1 : le script groovy
file=creation_projet_jenkins.groovy

# remplacer les parametres
sed -e "s/\"{job}\"/\"$appname\"/"  \
    -e "s/\"{giturl}\"/\"$giturl\"/"  \
    -e "s/\"{jdk}\"/\"$jdkversion\"/"  \
    -e "s/\"{maven}\"/\"$mavenversion\"/"  \
    -e "s/\"{goals}\"/\"$mavengoals\"/"  \
        /opt/scripts/$file > /tmp/file.tmp
OUT=$?
if [ $OUT -ne 0 ]; then
  echo " Erreur de configuration du fichier groovy"
  exit 1
fi

script=`cat /tmp/file.tmp`
rm  $file.log
curl -u $user:$mypassword -d "script=$script" -o $file.log https://$PLATEFORME_HOST/jenkins/scriptText -k
  
if [ -s $file.log ]; then
  echo "erreur exécution script "$file
  exit 1
else
  rm /tmp/file.tmp
fi