#!/bin/bash/

function add_log(){
    echo $(date +%Y/%m/%d-%H:%M:%S)\>\>"$1" >> $LOCAL_DIR/log
}

function timer_event(){
    echo "$(date +%Y/%m/%d)-$2:$3:$4>>$1" >> $LOCAL_DIR/log
}

function get_log(){
    cat $LOCAL_DIR/log
}
