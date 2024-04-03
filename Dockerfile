FROM debian:bookworm-slim

ARG HOST_UID
ARG HOST_GID

ENV HOST_UID=${HOST_UID}
ENV HOST_GID=${HOST_GID}
ENV HOST_USER=guest
ENV HOST_GROUP_NAME=guest
ENV CLI_HOME=/home/guest

RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y \
        vim \
        gcc \
        build-essential \
        libssl-dev \
        zlib1g-dev \
        libncurses5-dev \
        libncursesw5-dev \
        libreadline-dev \
        libsqlite3-dev \
        libgdbm-dev \
        libdb5.3-dev \
        libbz2-dev \
        libexpat1-dev \
        liblzma-dev \
        libffi-dev \
    && apt-get clean autoclean \
    && apt-get autoremove -y

COPY create-host-user.sh /usr/bin/create-host-user.sh
COPY entrypoint.sh /usr/bin/entrypoint.sh

RUN chmod 755 /usr/bin/*.sh

ENTRYPOINT ["/usr/bin/entrypoint.sh"]

