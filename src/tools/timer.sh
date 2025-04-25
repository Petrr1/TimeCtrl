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
    echo $(date +%Y/%m/%d--%H:%M:%S)\>\>START CYCLE
    for i in $(seq 1 $1); do
        echo $(date +%Y/%m/%d--%H:%M:%S)\>\>START WORK
        workTimer $time_work
        echo $(date +%Y/%m/%d--%H:%M:%S)\>\>START BREAKE
        breakeTimer $time_breake "Breake Namber $i"
    done
    echo $(date +%Y/%m/%d--%H:%M:%S)\>\>FINISH CYCLE
}

time_breake=$4
time_work=$3
$1 $2
