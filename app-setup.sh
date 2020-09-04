#! /bin/bash

# Take ownership of data
if [[ ! -d /config/.config/sonarr ]]; then
    mkdir -p /config/.config/sonarr
    chown docker_user:docker_group /config/.config
fi
chown docker_user:docker_group /data

# Take ownership of TV
chown docker_user:docker_group /tv


