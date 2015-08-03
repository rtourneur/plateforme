#! /bin/bash

# Launch ssh service
service ssh start

# launch nginx
registry cmd/registry/config.yml
