PROGECT_NAME="TimeControl"
CONFIG_DIR=$HOME/.config
LOCAL_DIR=$HOME/.local/$PROGECT_NAME
BAZIC_DIR=/opt/$PROGECT_NAME
if [ $2 ]; then
    BAZIC_DIR=$HOME/Cods/MyTools/clokeBig/src
else

exec $CONFIG_DIR/$PROGECT_NAME.sh

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
