CONFIG_DIR=$HOME/.config
LOCAL_DIR=$HOME/.local
BAZIC_DIR=$HOME/Cods/MyTools/clokeBig/src

time_breake=$((1*60))
time_work=$((0*60))

case $1 in
    "start")
        i=$(yad  --entry --text="Start work time")
        (exec $BAZIC_DIR/timer.sh workCycle $i $time_work $time_breake)&
        echo $! > $BAZIC_DIR/id
        ;;
    "stop")
        echo $(date +%Y/%m/%d--%H:%M:%S)\>\>BREAKE CYCLE
        kill $(cat $BAZIC_DIR/id)
        echo 
        rm $BAZIC_DIR/id
        ;;
    *)
        echo "not valide value"
        ;;
esac
