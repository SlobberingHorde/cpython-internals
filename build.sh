
export HOST_UID=$(id -u)
export HOST_GID=$(id -g)

docker build \
    -t cpython-internals:1.0.0 \
    --build-arg HOST_UID \
    --build-arg HOST_GID \
    .