SORCE=./src
source $SORCE/tools/environments.env

# super user
sudo sh -c "\
    if [ $(ls /usr/local/bin | grep $PROGECT_NAME) ]; then\
        rm -rf /usr/local/bin/$PROGECT_NAME/*;\
        rm /usr/local/bin/$PROGECT_NAME.sh;\
        rm /usr/local/bin/${PROGECT_NAME}d.sh;\
        rm /usr/lib/systemd/system-sleep/TimeCtrl-sleep.sh\
        rm /usr/lib/systemd/user/TimeCtrl.service\
    else\
        cp -r $SORCE/* /usr/local/bin/\
        cp ./TimeCtrl-sleep.sh /usr/lib/systemd/system-sleep/TimeCtrl-sleep.sh\
        cp ./TimeCtrl.service /usr/lib/systemd/user/TimeCtrl.service\
    fi;\
"

# user
if ! [ $(ls $HOME/.local/share | grep $PROGECT_NAME) ]; then
    mkdir $HOME/.local/share/$PROGECT_NAME
    mkfifo $HOME/.local/share/$PROGECT_NAME/command_pipe
fi
if ! [ $(ls $HOME/.config | grep $PROGECT_NAME.conf) ]; then
    cp ./config.conf $HOME/.config/$PROGECT_NAME.conf
fi
