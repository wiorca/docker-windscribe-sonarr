#1 /bin/bash

# Here is where you run the secure service you want to run.  Do not exit.  Run in foreground.
# Overwrite this file in your docker image

echo "IP information"

ip addr

echo "Starting Sonarr Service"

mono /opt/NzbDrone/NzbDrone.exe

