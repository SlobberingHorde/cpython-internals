#!/bin/bash

set -e

function unused-gid() {
  i=0
  while true; do
    if ! grep -q ":$i:" /etc/group; then
      echo "$i"
      exit 1
    fi
    ((i++))
  done
}

function move-existing-group-id() {
  local group_id=$1
  local group_name=$2
  local found_group_name=$(getent group ${group_id} | cut -d ':' -f1)
  if [ -n "${found_group_name}" ] ; then
    local new_gid=$(unused-gid)
    groupmod -g ${new_gid} ${found_group_name}
  fi
}

# Add the user
useradd -l -u ${HOST_UID} -G root  -s /bin/bash -M -N -d ${CLI_HOME} ${HOST_USER}

# Add the primary group from the host
move-existing-group-id ${HOST_GID} ${HOST_GROUP_NAME}
groupadd -g ${HOST_GID} ${HOST_GROUP_NAME}
usermod -g ${HOST_GROUP_NAME} ${HOST_USER}

# Optionally add the user to the docker group if on Linux
if [ -n "${HOST_DOCKER_GID}" ]; then
  move-existing-group-id ${HOST_DOCKER_GID} docker
  groupadd -g ${HOST_DOCKER_GID} docker
  usermod -a -G docker ${HOST_USER}
fi

echo 'ALL ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
