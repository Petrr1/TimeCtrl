SORCE=./src
source $SORCE/TimeCtrl/environments.env

# super user
systemctl --user disable TimeCtrl.service
sudo sh -c "\
    if [ '$(ls /usr/local/bin | grep $PROGECT_NAME)' ]; then\
        rm -rf /usr/local/bin/$PROGECT_NAME*;\
        rm /etc/systemd/user/TimeCtrl*.service;\
    fi;\
    cp $SORCE/* /usr/local/bin/;\
    cp -r $SORCE/$PROGECT_NAME/ /usr/local/bin/;\
    cp ./*.service /etc/systemd/user/;\
"
systemctl --user daemon-reload
systemctl --user enable TimeCtrl.service

# user
if ! [ $(ls $HOME/.local/share | grep $PROGECT_NAME) ]; then
    mkdir $HOME/.local/share/$PROGECT_NAME
    mkfifo $HOME/.local/share/$PROGECT_NAME/command_pipe
fi
if ! [ $(ls $HOME/.config | grep $PROGECT_NAME.conf) ]; then
    cp ./config.conf $HOME/.config/$PROGECT_NAME.conf
fi

systemctl --user restart TimeCtrl.service
