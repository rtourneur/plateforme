#Image GitBlit
FROM polymont/java:jdk8
#
MAINTAINER Raphael Tourneur <raphael.tourneur@polymont.fr>

ENV GITBLIT_HOME /var/gitblit_home

# Gitblit is ran with user `gitblit`, uid = variable
# If you bind mount a volume from host/vloume from a data container,
# ensure you use same uid
RUN useradd -d "$GITBLIT_HOME" -u {{ansible_user_uid}} -m -s /bin/bash gitblit

# Gitblit home directoy is a volume, so configuration and build history
# can be persisted and survive image upgrades
VOLUME /var/gitblit_home

# Version of gitblit to use
# Gitblit min req java 7
ENV GITBLIT_VERSION gitblit-1.6.2

# Install Gitblit
RUN curl -Lks http://dl.bintray.com/gitblit/releases/$GITBLIT_VERSION.tar.gz -o /tmp/gitblit.tar.gz
RUN mkdir -p /opt/gitblit \
    && tar zxf /tmp/gitblit.tar.gz -C /opt/gitblit \
    && rm -rf /tmp/gitblit.tar.gz
RUN chown -R gitblit /opt/gitblit

# Adjust the default Gitblit settings to bind to 8080, 8443, 9418, 29418, and allow RPC administration.
# Note: we are writing to a different file here because sed doesn't like to the same file it
# is streaming.  This is why the original properties file was renamed earlier.
RUN mv /opt/gitblit/data/gitblit.properties /opt/gitblit/data/default.properties && \ 
    sed -e "s/server\.httpPort\s=\s0/server\.httpPort=8080/" \
        -e "s/web\.enableRpcManagement\s=\sfalse/web\.enableRpcManagement=true/" \
        -e "s/web\.enableRpcAdministration\s=\sfalse/web.enableRpcAdministration=true/" \
        -e "s/server\.contextPath\s=\s\//server.contextPath=\/gitblit\//" \
        /opt/gitblit/data/default.properties > /opt/gitblit/data/gitblit.properties

EXPOSE 8080 9418 29418

# Administering Users - AB
RUN echo '[user "user1"]'            >> /opt/gitblit/data/users.conf \
&& echo '        password = user1'  >> /opt/gitblit/data/users.conf \
&& echo '[user "user2"]'            >> /opt/gitblit/data/users.conf \
&& echo '        password = user2'  >> /opt/gitblit/data/users.conf \
&& echo '[user "user3"]'            >> /opt/gitblit/data/users.conf \
&& echo '        password = user3'  >> /opt/gitblit/data/users.conf \
&& echo '[user "user4"]'            >> /opt/gitblit/data/users.conf \
&& echo '        password = user4'  >> /opt/gitblit/data/users.conf
# Add launch script
#COPY add_users.sh /opt/gitblit/add_users.sh
#RUN add_users.sh

#CMD service ssh start && java -server -Xmx1024M -Djava.awt.headless=true -jar /opt/gitblit/gitblit.jar --baseFolder /opt/gitblit-data
COPY start.sh /usr/local/bin/start.sh
COPY gitblit.sh /usr/local/bin/gitblit.sh
ENTRYPOINT ["/usr/local/bin/start.sh"]
