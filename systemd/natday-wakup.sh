#!/bin/bash
sleep 10s
if [ "${1}" == "pre" ]; then
exit 0
elif [ "${1}" == "post" ]; then
cd /run/media/hammer/Data/projects/js_code
node nat-day1.js
fi

