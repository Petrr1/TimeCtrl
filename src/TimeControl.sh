PROGECT_NAME="TimeControl"
CONFIG=$HOME/.config/$PROGECT_NAME.conf
LOCAL_DIR=$HOME/.local/share/$PROGECT_NAME
BAZIC_DIR=/opt/$PROGECT_NAME
if [ $2 ]; then
    BAZIC_DIR=$HOME/Cods/MyTools/$PROGECT_NAME/src
    CONFIG=$BAZIC_DIR/../config.conf
    LOCAL_DIR=$BAZIC_DIR/..
fi

source $CONFIG

case $1 in
    "start")
        i=$(yad  --entry --text="Start work time")
        (exec $BAZIC_DIR/tools/timer.sh workCycle $i $time_work $time_breake >> $LOCAL_DIR/log)&
        echo $! > $LOCAL_DIR/id
        ;;
    "stop")
        echo $(date +%Y/%m/%d--%H:%M:%S)\>\>BREAKE CYCLE >> $LOCAL_DIR/log
        kill $(cat $LOCAL_DIR/id)
        echo 
        rm $LOCAL_DIR/id
        ;;
    *)
        echo "not valide value"
        ;;
esac
