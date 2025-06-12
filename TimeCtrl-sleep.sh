#
#path: /usr/lib/systemd/system-sleep/

if [ "${1}" == "pre" ]; then
    /bin/bash TimeCtrl.sh pause
elif [ "${1}" == "post" ]; then
    /bin/bash TimeCtrl.sh play
fi
