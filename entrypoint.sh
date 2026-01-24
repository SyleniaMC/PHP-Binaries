#!/bin/bash
cd /home/container

# Replace startup variables
MODIFIED_STARTUP=$(echo ${STARTUP} | sed -e 's/{{/${/g' -e 's/}}/}/g')
echo "Starting with command: ${MODIFIED_STARTUP}"

# Run the startup command
eval ${MODIFIED_STARTUP}
