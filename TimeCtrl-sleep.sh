#!/bin/bash/
#path: /usr/lib/systemd/system-sleep/

if [ "${1}" == "pre" ]; then
    TimeCtrl.sh pause
elif [ "${1}" == "post" ]; then
    TimeCtrl.sh play
fi
