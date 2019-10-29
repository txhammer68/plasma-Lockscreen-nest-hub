#!/bin/bash
sleep 5s
if [ "${1}" == "pre" ]; then
exit 0
elif [ "${1}" == "post" ]; then
cd /run/media/hammer/Data/projects/gmail
python3 /run/media/hammer/Data/projects/gmail/counter.py
fi
