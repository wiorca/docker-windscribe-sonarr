
# Based on wiorca/docker-windscribe-mono
FROM wiorca/docker-windscribe-mono:latest

# Version
ARG VERSION=0.0.6

# Expose the webadmin port for Sonarr
EXPOSE 8989/tcp

# Create a volume for the bittorrent data and library
VOLUME [ "/data", "/tv" ]

# Install mediainfo
RUN apt -y update && apt install -y mediainfo && \
    apt -y autoremove && apt -y clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Link the sonarr data directory somewhere useful
RUN mkdir -p /config/.config/sonarr && ln -sf /config/.config/sonarr /var/lib/sonarr

# Add in scripts for health check and start-up
ADD app-health-check.sh /opt/scripts/app-health-check.sh
ADD app-startup.sh /opt/scripts/app-startup.sh
ADD app-setup.sh /opt/scripts/app-setup.sh

# Download the latest sonarr
RUN curl -L https://services.sonarr.tv/v1/download/main/latest?version=3\&os=linux \
    | tar xvz --directory /opt && chmod -R a+rx /opt/Sonarr

