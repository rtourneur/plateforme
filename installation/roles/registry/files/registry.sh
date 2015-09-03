#! /bin/bash

# Launch ssh service
service ssh start

# launch registry
registry /etc/docker/registry/config.yml
