#! /bin/bash

# Check to make sure Sonarr is running

QBTNX=$(pgrep mono | wc -l )
if [[ ${QBTNX} -ne 1 ]]
then
	echo "Sonarr process not running"
	exit 1
fi

echo "Sonarr is running"

exit 0
