#!/bin/bash
# place in /lib/systemd/system-sleep/
if [ "${1}" == "pre" ]; then
exit 0
elif [ "${1}" == "post" ]; then
sleep 10s
cd /run/media/hammer/Data/projects/stocks/
node index.js
fi
exit 0


