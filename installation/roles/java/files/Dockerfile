#Image JDK 8
#FROM polymont/ubuntu:latest
from polymont/ubuntu

MAINTAINER Abdallah BENBRAHIM

RUN apt-get update && apt-get install -y software-properties-common && add-apt-repository ppa:webupd8team/java && apt-get update

# Add JDK8
RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
RUN apt-get install -y oracle-java8-installer

ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

CMD service ssh start && java -version && /bin/bash

