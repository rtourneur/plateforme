#! /bin/bash

script=`cat maven.groovy`
curl -d "script=$script" http://127.0.0.1:9080/jenkins/scriptText
