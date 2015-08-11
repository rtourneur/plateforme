#! /bin/bash

# Configure Maven
script=`cat maven.groovy`
curl -d "script=$script" http://127.0.0.1:9080/jenkins/scriptText

# Configure Git
script=`cat git.groovy`
curl -d "script=$script" http://127.0.0.1:9080/jenkins/scriptText

# Configure Java
script=`cat jdk.groovy`
curl -d "script=$script" http://127.0.0.1:9080/jenkins/scriptText
