# Bigin
## Using libs and utilits
- yad
- bash shell
## Install
1. Install using utilits;
1. Run install.sh
1. Edit .config/TimeCtrl.conf
1. `systemctl --user enable TimeCtrl.service`
1. _opt_ add `TimeCtrl.sh pause` and `TimeCtrl.sh play` in your session-idle(exp:swayidle)
    May be not stable.
## Using
1. Run:
> `TimeCtrl.sh start`
2. Pause/Resum:
> `TimeCtrl.sh pause`
> `TimeCtrl.sh play`
3. Stop:
> `TimeCtrl.sh stop`

# wall map
- [-] ui:
    - [x] messeg
    - [x] config file
    - [ ] tasks
    - [x] arguments
    - [-] loger
    - [ ] get stut
- [x] config:
    - [x] value timers
- [x] deamon
    - [x] arg:KillD add finish for pause
    - [x] pause-resume of suspend system
- [ ] managment tasks
    - [ ] set curent tasks
    - [ ] show curent tasks
    - [ ] count time for task
    - [ ] jurnal tasks
    - [ ] integrate with [calcuse TODO](~/.local/share/calcuse/todo)
- [ ] managment project:
    - [x] installer
    - [ ] uninstaller
    - [x] systemctl deamon
