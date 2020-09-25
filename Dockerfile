
# Based on Ubuntu 20.04 LTS
FROM wiorca/docker-windscribe:latest

# Version
ARG VERSION=0.0.4

# Expose the webadmin port for Sonarr
EXPOSE 8989/tcp

# Create a volume for the bittorrent data and library
VOLUME [ "/data", "/tv" ]

# Update ubuntu container, and install the basics, Add windscribe ppa, Install windscribe, and some to be removed utilities
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF && \
    echo "deb https://download.mono-project.com/repo/ubuntu stable-focal main" | tee /etc/apt/sources.list.d/mono-official-stable.list && \
    apt -y update && apt install -y mono-devel && \
    apt -y autoremove && apt -y clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Link the sonarr data directory somewhere useful
RUN mkdir -p /config/.config/sonarr && ln -sf /config/.config/sonarr /var/lib/sonarr

# Add in scripts for health check and start-up
ADD app-health-check.sh /opt/scripts/app-health-check.sh
ADD app-startup.sh /opt/scripts/app-startup.sh
ADD app-setup.sh /opt/scripts/app-setup.sh

# Download the latest sonarr
RUN curl -L https://services.sonarr.tv/v1/download/phantom-develop/latest?version=3\&os=linux \
    | tar xvz --directory /opt && chmod -R a+rx /opt/Sonarr

