BAZIC_DIR=$(dirname $0)
source $BAZIC_DIR/tools/environments.env
if [ $2=="test" ]; then
    CONFIG=$BAZIC_DIR/../config.conf
    LOCAL_DIR=$BAZIC_DIR/..
fi
source $BAZIC_DIR/tools/loger.sh
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
        push "pause"
        ;;
    "reload")
        push "reload"
        ;;
    "show")
        get_log
        ;;
    "deamon")
        exec $BAZIC_DIR/TimeControld.sh ${@[@]:1}
        ;;
    "kill")
        push "killD"
        ;;
    *)
        echo "not valide value"
        ;;
esac
