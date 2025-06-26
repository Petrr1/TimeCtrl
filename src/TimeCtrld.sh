#!/bin/bash
#pash: /usr/local/bin
BAZIC_DIR="/usr/local/bin"
for __src in $(ls $BAZIC_DIR/TimeCtrl); do source $BAZIC_DIR/TimeCtrl/$__src; done
if [ $# == 2 ]; then
    LOCAL_DIR=$1
    CONFIG=$2
fi

source $CONFIG

# menegment's envaroment
# status="PLAY"|"PAUSE"|"ZERO"
status="ZERO"
timerS="work"

echo "RUN DEAMON"
while [ 1 ]; do
    commanDTC=($(cat $LOCAL_DIR/command_pipe))
    case "$commanDTC" in
        # managmant deamon
#       "runD")
#           echo "RUN DEAMON"
#           ;;
        "killD")
            if [ $status != "ZERO" ]; then
                status="ZERO"
                add_log "STOP"
                kill $id
            fi
            echo "KILL DEAMON"
            break
            ;;

        # managmant timer
        "start")
            if [ $status == "ZERO" ]; then
                status="PLAY"
                add_log "START"
                pauseT=0
                workTimer $time_work&
                id=$!
                timerT=($(date +%H\ %M\ %S))
            fi
            ;;
        "stop")
            if [ $status != "ZERO" ]; then
                status="ZERO"
                add_log "STOP"
                kill $id
            fi
            ;;
        "play")
            if [ $status == "PAUSE" -a $timerS == "work" ]; then
                status="PLAY"
                add_log "RESUME"
                fastVar=$(($(calc_time_toS ${timerT[@]})-$pauseT))
                timerT=($(date +%H\ %M\ %S))
                workTimer $fastVar&
                id=$!
            fi
            ;;
        "pause")
            if [ $status == "PLAY" -a $timerS == "work" ]; then
                status="PAUSE"
                add_log "PAUSE"
                pauseT=$((${pauseT}+$(calc_time_toS $(calc_time_rang ${timerT[@]} $(date +%H\ %M\ %S)))))
                kill $id
            fi
            ;;
        "switch-pause")
            if [ $timerS == "work" ]; then
                case $status in
                    "PAUSE")
                        status="PLAY"
                        add_log "RESUME"
                        fastVar=$(($(calc_time_toS ${timerT[@]})-$pauseT))
                        timerT=($(date +%H\ %M\ %S))
                        workTimer $fastVar&
                        id=$!
                        ;;
                    "PLAY")
                        status="PAUSE"
                        add_log "PAUSE"
                        pauseT=$((${pauseT}+$(calc_time_toS $(calc_time_rang ${timerT[@]} $(date +%H\ %M\ %S)))))
                        kill $id
                        ;;
                esac
            fi
            ;;
        # data managmant
        "$id")
            timerT=($(date +%H\ %M\ %S))
            case $timerS in
                "break")
                    pauseT=0
                    timer_event "WORK" ${timerT[@]}
                    timerS="work"
                    workTimer $time_work&
                    id=$!
                    ;;
                "work")
                    timer_event "BREAKE" ${timerT[@]}
                    timerS="break"
                    breakeTimer $time_breake "TEXT"&
                    id=$!
                    ;;
                *)
                    echo "INVALID DO"
                    ;;
            esac
            ;;
        "reload")
            source $CONFIG
            ;;
        # other
        "giv_stat")
        echo "$(calc_time_toHMS $(($pauseT+$(calc_time_toS $(calc_time_rang ${timerT[@]} $(date +%H\ %M\ %S))))))"\
                | env DISPLAY=:0 yad --text-info --geometry=100x50
            ;;
        *)
            echo "OTHER"
            ;;
    esac
done
