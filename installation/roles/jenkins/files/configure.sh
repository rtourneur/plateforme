#! /bin/bash

# Appelle curl en spécifiant l'utilisateur et en vérifiant la réponse de Jenkins
# arg1 : le script groovy
call() {
  file=$1
  rm $file.log.old
  script=`cat $file`
  curl -u admin:$password -d "script=$script" -o $file.log http://127.0.0.1:9080/jenkins/scriptText
  
  if [ -s $file.log ];
  then
    echo "erreur exécution script "$file
    mv $file.log $file.log.old
    exit 1
  fi
  
  rm $file
}

password=$1

# Configure security
script=`cat admin.groovy`
curl -d "script=$script" http://127.0.0.1:9080/jenkins/scriptText
rm admin.groovy

# Configure Maven
call maven.groovy

# Configure Git -- pas besoin, git est dans le path par défaut
#call git.groovy

# Configure Java
call jdk.groovy
