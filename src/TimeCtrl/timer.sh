#!/bin/bash/

function breakeTimer() {
    my_id=$BASHPID
    step=$(($1/100))
    if [ $step == 0 ]; then
        step=1
    fi
    step_end=$(($1%$step))
    (for i in $(seq 1 $step $(($1-$step_end))); do
        sleep $(($step+s))
        echo $i,$1
        echo $(($i*100/$1))
    done
    if [ $step_end!=0 ]; then
        sleep $(($step_end+s))
        echo $((100))
    fi) | env DISPLAY=:0 \
        yad --progress --text="$2" #--auto-close
    echo $my_id > $LOCAL_DIR/command_pipe
}

function workTimer(){
    my_id=$BASHPID
    sleep $1s
    echo $my_id > $LOCAL_DIR/command_pipe
}

function calc_time_toS(){
    echo $((${1}*3600+${2}*60+${3}))
}

function calc_time_toHMS(){
    H=$(($1/3600))
    M=$((($1-${H}*3600)/60))
    S=$(($1-${H}*3600-${M}*60))
    echo "($H $M $S)"
}

function calc_time_rang(){
    echo "($(($4-$1)) $(($5-$2)) $(($6-$3)))"
}

function calc_need_time(){
    timeD=($(($4-$1)) $(($5-$2)) $(($6-$3)))
    echo $(($7-$(calc_time_toS ${timeD[@]})))
}
