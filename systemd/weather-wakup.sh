#!/bin/bash
sleep 15s
if [ "${1}" == "pre" ]; then
exit 0
elif [ "${1}" == "post" ]; then
cd /run/media/hammer/Data/projects/nodejs-weather-app-master
node index.js
fi
