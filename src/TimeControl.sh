CONFIG=$HOME/.config/$PROGECT_NAME.conf
LOCAL_DIR=$HOME/.local/share/$PROGECT_NAME
BAZIC_DIR=$(dirname $0)
if [ $2 ]; then
    CONFIG=$BAZIC_DIR/../config.conf
    LOCAL_DIR=$BAZIC_DIR/..
fi

source $CONFIG
source $BAZIC_DIR/tools/loger.sh
source $BAZIC_DIR/tools/timer.sh

case $1 in
    "start")
        i=$(yad  --entry --text="Start work time")
        (workCycle $i >> $LOCAL_DIR/log)&
        echo $! > $LOCAL_DIR/id
        ;;
    "stop")
        echo $(add_log "BREAKE CYCLE") >> $LOCAL_DIR/log
        kill $(cat $LOCAL_DIR/id)
        echo 
        rm $LOCAL_DIR/id
        ;;
    "show")
        cat $LOCAL_DIR/log
        ;;
    "pause")
        echo "PAUSE"
        ;;
    *)
        echo "not valide value"
        ;;
esac
