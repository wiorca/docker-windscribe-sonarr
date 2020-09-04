
# Based on Ubuntu 20.04 LTS
FROM wiorca/docker-windscribe:latest

# Version
ARG VERSION=0.0.3

# Expose the webadmin port for Sonarr
EXPOSE 8989/tcp

# Create a volume for the bittorrent data and library
VOLUME [ "/data", "/tv" ]

# Update ubuntu container, and install the basics, Add windscribe ppa, Install windscribe, and some to be removed utilities
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 2009837CBFFD68F45BC180471F4F90DE2A9B4BF8 && \
    echo "deb https://apt.sonarr.tv/ubuntu focal main" | tee /etc/apt/sources.list.d/sonarr.list && \
    echo "deb https://download.mono-project.com/repo/ubuntu stable-focal main" | tee /etc/apt/sources.list.d/mono-official-stable.list && \
    apt -y update && apt install -y mono-devel sonarr && \
    apt -y autoremove && apt -y clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Link the sonarr data directory somewhere useful
RUN mkdir -p /config/.config/sonarr && ln -sf /config/.config/sonarr /var/lib/sonarr

# Add in scripts for health check and start-up
ADD app-health-check.sh /opt/scripts/app-health-check.sh
ADD app-startup.sh /opt/scripts/app-startup.sh
ADD app-setup.sh /opt/scripts/app-setup.sh

