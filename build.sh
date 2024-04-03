
export HOST_UID=1000
export HOST_USER=jhoerig
export HOST_GID=1000
export HOST_GROUP_NAME=jhoerig
export CLI_HOME=/home/jhoerig/


docker build \
    -t cpython-internals:1.0.0 \
    --build-arg HOST_UID \
    --build-arg HOST_USER \
    --build-arg HOST_GID \
    --build-arg HOST_GROUP_NAME \
    --build-arg CLI_HOME \
    .