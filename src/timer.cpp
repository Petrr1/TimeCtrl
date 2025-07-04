#include "include/timer.hpp"
#include <iostream>

// construct/destruct
Timer::Timer(std::condition_variable* notife_cv, int time_sec) {
    _time = time_sec;
    event_cv = notife_cv;
    event_id = nullptr;
    stat = stop_s;
}

Timer::Timer(std::atomic<int>* timer_pip, int id_timer, std::condition_variable* notife_cv, int time_sec) {
    _time = time_sec;
    event_cv = notife_cv;
    event_id = timer_pip;
    stat = stop_s;
    _id = id_timer;
}

Timer::~Timer() {
    this->stop();
}

// public  metods
void Timer::run() {
    if (stat == stop_s) {
        stat = run_s;
        timer_trad = std::thread(&Timer::run_timer, this);
    }
}

void Timer::stop() {
    if(stat == run_s) {
        stat = proc_stop_s;
        stop_trig.notify_all();
    }
    if (timer_trad.joinable()) {
        timer_trad.join();
    }
}

status_ Timer::get_stat() {
    return stat;
}

// privot metods
void Timer::run_timer(){
    std::unique_lock lk(timer_ctrl);
    stop_trig.wait_for(lk, std::chrono::seconds(_time), [this](){ return stat==proc_stop_s; });
    std::cerr << "timer(" << _id <<") stoped\n";
    stat = stop_s;
    stat.notify_one();
    if (event_id) { event_id->store(_id); }
    event_id->notify_all();
}
