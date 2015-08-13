#! /bin/bash

# start ssh service
service ssh start

# launch jenkins as jenkins user
# if `docker run` first argument start with `--` the user is passing jenkins launcher arguments
if [[ $# -lt 1 ]] || [[ "$1" == "--"* ]]; then
   /bin/su -s /bin/bash -c '/usr/local/bin/jenkins.sh' jenkins
fi

# As argument is not jenkins, assume user want to run his own process, for sample a `bash` shell to explore this image
exec "$@"

