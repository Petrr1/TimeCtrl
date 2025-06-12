#!/bin/bash
#pash: /usr/local/bin
BAZIC_DIR="/usr/local/bin"
source $BAZIC_DIR/TimeCtrl/environments.env
#   if [ $# -eq 3 ]; then
#       CONFIG=$BAZIC_DIR/../config.conf
#       LOCAL_DIR=$BAZIC_DIR/..
#   fi
source $BAZIC_DIR/$PROGECT_NAME/loger.sh
PIPE=$LOCAL_DIR/command_pipe

function push(){
    echo "$@" >> $PIPE
}

case $1 in
    "start")
        push "start"
        ;;
    "stop")
        push "stop"
        ;;
    "pause")
        push "pause"
        ;;
    "play")
        push "play"
        ;;
    "play-pause")
        push "switch-pause"
        ;;
    "reload")
        push "reload"
        ;;
    "show")
        get_log | grep $(date +%Y/%m/%d)| yad --text-info --geometry=200x400
        ;;
    "daemon")
        exec $BAZIC_DIR/${PROGECT_NAME}d.sh ${*:2}&
        ;;
    "kill")
        push "killD"
        ;;
    *)
        echo "not valide value"
        ;;
esac
