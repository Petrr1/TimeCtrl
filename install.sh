PROGECT_NAME="TimeControl"
SORCE=./src
V="0.0-a"

#super user
sudo sh -c "\
    mkdir /opt/$PROGECT_NAME;\
    cp -r $SORCE/tools /opt/$PROGECT_NAME/;\
    cp $SORCE/main.sh /opt/$PROGECT_NAME/$PROGECT_NAME.sh;\
    echo 'PATH=/opt/$PROGECT_NAME' >> /etc/environment\
"
if ! [ $(ls $HOME/.local | grep $PROGECT_NAME) ]; then
    mkdir $HOME/.local/$PROGECT_NAME
fi
if ! [ $(ls $HOME/.config | grep $PROGECT_NAME.sh) ]; then
    cp ./config.sh $HOME/.config/$PROGECT_NAME.sh
fi
