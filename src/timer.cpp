#include "include/timer.hpp"


Timer::Timer(){
    _time = 10;
    _id = 3;
}

Timer::Timer(int _time): _time(_time){
    _id = 3;
}

Timer::~Timer(){}

void Timer::run(){
    sleep(_time);
}
