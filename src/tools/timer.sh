function breakeTimer() {
    step=$(($1/100))
    if [ $step == 0 ]; then
        step=1
    fi
    step_end=$(($1%$step))
    (for i in $(seq 1 $step $(($1-$step_end))); do
        sleep $(($step+s))
        echo $(($i*100/$1))
    done
    if [ $step_end!=0 ]; then
        sleep $(($step_end+s))
        echo $((100))
    fi) |\
        yad --progress --text="$2" #--auto-close
}

function workTimer(){
    sleep $1
}

function workCycle()
{
    echo $(add_log "START CYCLE")
    for i in $(seq 1 $1); do
        echo $(add_log "START WORK")
        workTimer $time_work
        echo $(add_log "START BREAKE")
        breakeTimer $time_breake "Breake Namber $i"
    done
    echo $(add_log "FINISH CYCLE")
}
