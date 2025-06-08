#!/bin/bash/
#pash: /usr/local/bin
BAZIC_DIR=$(dirname $0)
for __src in $(ls $BAZIC_DIR/tools); do source $BAZIC_DIR/tools/$__src; done
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
                workTimer $(calc_need_time ${timerT[@]} ${pauseT[@]} $time_work)&
                id=$!
            fi
            ;;
        "pause")
            if [ $status == "PLAY" -a $timerS == "work" ]; then
                status="PAUSE"
                add_log "PAUSE"
                pauseT=($(date +%H\ %M\ %S))
                kill $id
            fi
            ;;
        "switch-pause")
            if [ $timerS == "work" ]; then
                case $status in
                    "PAUSE")
                        status="PLAY"
                        add_log "RESUME"
                        workTimer $(calc_need_time ${timerT[@]} ${pauseT[@]} $time_work)&
                        id=$!
                        ;;
                    "PLAY")
                        status="PAUSE"
                        add_log "PAUSE"
                        pauseT=($(date +%H\ %M\ %S))
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
                    workTimer $time_work&
                    timer_event "WORK" ${timerT[@]}
                    timerS="work"
                    id=$!
                    ;;
                "work")
                    timer_event "BREAKE" ${timerT[@]}
                    breakeTimer $time_breake "TEXT"&
                    timerS="break"
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
        *)
            echo "OTHER"
            ;;
    esac
done
