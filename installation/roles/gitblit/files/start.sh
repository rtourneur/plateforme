#! /bin/bash

# start ssh service
service ssh start

# launch gitblit as gitblit user
# if `docker run` first argument start with `--` the user is passing gitblit launcher arguments
if [[ $# -lt 1 ]] || [[ "$1" == "--"* ]]; then
   /bin/su -s /bin/bash -c '/usr/local/bin/gitblit.sh' gitblit
fi

# As argument is not gitblit, assume user want to run his own process, for sample a `bash` shell to explore this image
exec "$@"
