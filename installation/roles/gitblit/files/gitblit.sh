#! /bin/bash

# Copy files from /opt/gitblit/data into /var/gitblit_home

mv -n /opt/gitblit/data/* $GITBLIT_HOME

cd  /opt/gitblit
java -server -Xmx1024M -Djava.awt.headless=true -jar /opt/gitblit/gitblit.jar --baseFolder $GITBLIT_HOME
