#Image JDK 7 

FROM polymont/ubuntu

MAINTAINER Abdallah BENBRAHIM

run apt-get update

run DEBIAN_FRONTEND=noninteractive apt-get install -q -y software-properties-common
run DEBIAN_FRONTEND=noninteractive apt-get install -q -y python-software-properties
run DEBIAN_FRONTEND=noninteractive apt-add-repository ppa:webupd8team/java -y

run apt-get update

# JDK7
run echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
run DEBIAN_FRONTEND=noninteractive apt-get install oracle-java7-installer -y
#
# JDK8
#RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
#RUN DEBIAN_FRONTEND=noninteractive apt-get install -y oracle-java8-installer

CMD service ssh start && java -version && /bin/bash

