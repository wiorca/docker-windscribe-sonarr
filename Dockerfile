
# Based on Ubuntu 20.04 LTS
FROM wiorca/docker-windscribe:latest

# Version
ARG VERSION=0.0.1

# Expose the webadmin port for qBittorrent
EXPOSE 8080/tcp

# Create a volume for the bittorrent data
VOLUME [ "/data", "/tv" ]

# Update ubuntu container, and install the basics, Add windscribe ppa, Install windscribe, and some to be removed utilities
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 0xA236C58F409091A18ACA53CBEBFF6B99D9B78493 && \
    echo "deb http://apt.sonarr.tv/ master main" | tee /etc/apt/sources.list.d/sonarr.list && \
    echo "deb https://download.mono-project.com/repo/ubuntu stable-focal main" | tee /etc/apt/sources.list.d/mono-official-stable.list && \
    apt -y update && apt install -y mono-devel nzbdrone && \
    apt -y autoremove && apt -y clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Add in scripts for health check and start-up
ADD app-health-check.sh /opt/scripts/app-health-check.sh
ADD app-startup.sh /opt/scripts/app-startup.sh
ADD app-setup.sh /opt/scripts/app-setup.sh

