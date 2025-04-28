SORCE=./src
source $SORCE/tools/environments.env

# super user
sudo sh -c "\
    if [ $(ls /opt | grep $PROGECT_NAME) ]; then\
        rm -rf /opt/$PROGECT_NAME/*;\
    else\
        mkdir /opt/$PROGECT_NAME;\
        echo 'PATH=/opt/$PROGECT_NAME' >> /etc/environment;\
    fi;\
    cp -r $SORCE/* /opt/$PROGECT_NAME/\
"

# user
if ! [ $(ls $HOME/.local/share | grep $PROGECT_NAME) ]; then
    mkdir $HOME/.local/share/$PROGECT_NAME
    mkfifo $HOME/.local/share/$PROGECT_NAME/command_pipe
fi
if ! [ $(ls $HOME/.config | grep $PROGECT_NAME.conf) ]; then
    cp ./config.conf $HOME/.config/$PROGECT_NAME.conf
fi
