FROM  polymont/tomcat:8

MAINTAINER Raphaël TOURNEUR <raphael.tourneur@polymont.fr>

ENV JENKINS_HOME /var/jenkins_home

# Jenkins is ran with user `jenkins`, uid = 999
# If you bind mount a volume from host/vloume from a data container, 
# ensure you use same uid
RUN useradd -d "$JENKINS_HOME" -u 999 -m -s /bin/bash jenkins

# Jenkins home directoy is a volume, so configuration and build history 
# can be persisted and survive image upgrades
VOLUME /var/jenkins_home

# `/usr/share/jenkins/ref/` contains all reference configuration we want 
# to set on a fresh new installation. Use it to bundle additional plugins 
# or config file with your custom jenkins Docker image.
RUN mkdir -p /usr/share/jenkins/ref/init.groovy.d

COPY init.groovy /usr/share/jenkins/ref/init.groovy.d/tcp-slave-agent-port.groovy

ENV JENKINS_VERSION {{jenkins_version}}
ENV JENKINS_SHA 59215da16f9f8a781d185dde683c05fcf11450ef

# could use ADD but this one does not check Last-Modified header 
# see https://github.com/docker/docker/issues/8331
RUN curl -fL http://mirrors.jenkins-ci.org/war-stable/$JENKINS_VERSION/jenkins.war -o /usr/local/tomcat/webapps/jenkins.war \
  && echo "$JENKINS_SHA /usr/local/tomcat/webapps/jenkins.war" | sha1sum -c -

ENV JENKINS_UC https://updates.jenkins-ci.org
RUN chown -R jenkins "$JENKINS_HOME" /usr/share/jenkins/ref "$CATALINA_HOME"

# will be used by attached slave agents:
EXPOSE 50000

# JDK6
RUN echo oracle-java6-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
RUN apt-get install -y oracle-java6-installer
# JDK7
RUN echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
RUN apt-get install -y oracle-java7-installer

# Add Maven
RUN mkdir -p {{ maven_dir }} && chmod a+w {{ maven_dir }}
RUN curl -fL http://apache.mirrors.ovh.net/ftp.apache.org/dist/maven/maven-3/3.3.3/binaries/apache-maven-3.3.3-bin.tar.gz -o /tmp/apache-maven-3.3.3-bin.tar.gz \
&& tar -C {{ maven_dir }} -zxf /tmp/apache-maven-3.3.3-bin.tar.gz
RUN curl -fL http://apache.mirrors.ovh.net/ftp.apache.org/dist/maven/maven-3/3.2.5/binaries/apache-maven-3.2.5-bin.tar.gz -o /tmp/apache-maven-3.2.5-bin.tar.gz \
&& tar -C {{ maven_dir }} -zxf /tmp/apache-maven-3.2.5-bin.tar.gz

USER jenkins

# from a derived Dockerfile, can use `RUN plugin.sh active.txt` to setup /usr/share/jenkins/ref/plugins from a support bundle
COPY plugins.sh /usr/local/bin/plugins.sh
COPY active.txt /usr/local/bin/active.txt
RUN plugins.sh /usr/local/bin/active.txt

COPY jenkins.sh /usr/local/bin/jenkins.sh

USER root
COPY start.sh /usr/local/bin/start.sh
ENTRYPOINT ["/usr/local/bin/start.sh"]
#ENTRYPOINT ["catalina.sh", "run"]


