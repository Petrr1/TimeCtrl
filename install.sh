PROGECT_NAME="TimeControl"
SORCE=./src
V="0.0-a"

#super user
sudo sh -c "\
    mkdir /opt/$PROGECT_NAME;\
    cp -r $SORCE/* /opt/$PROGECT_NAME;\
    tee -a 'PATH=/opt/$PROGECT_NAME'\
"
if ! [ $(ls $HOME/.local | grep $PROGECT_NAME); then
    mkdir $HOME/.local/$PROGECT_NAME
fi
if ! [ $(ls $HOME/.config | grep $PROGECT_NAME.sh); then
    cp ./config.sh $HOME/.config/$PROGECT_NAME.sh
fi
