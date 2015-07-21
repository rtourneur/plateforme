FROM jenkins

MAINTAINER <niv.goor@polymont.fr>

COPY plugins.txt /usr/share/jenkins/plugins.txt
RUN /usr/local/bin/plugins.sh /usr/share/jenkins/plugins.txt
