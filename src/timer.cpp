#include "include/timer.hpp"
#include <iostream>
#include <mutex>

// construct/destruct
Timer::Timer(const std::vector<std::chrono::seconds> timers, std::condition_variable* notife_cv) {
    this->timers = timers;
    this->curent_id = -1;
    if (notife_cv) {
        this->alarm_cv = notife_cv;
        this->alarm_out = true;
    } else {
        this->alarm_cv = new std::condition_variable();
        this->alarm_out = false;
    }
}

// public  metods
void Timer::run(int id) {
    this->stop();
    this->curent_id = id;
    this->timer_th = std::thread(&Timer::timer_run, this, timers[id]);
}

void Timer::stop() {
    if (this->timer_th.joinable()) {
        this->curent_id = -1;
        this->timer_stop_cv.notify_all();
        this->timer_th.join();
    }
}

int Timer::wait() {
    if (this->alarm_out || this->timer_th.joinable()) {
        std::unique_lock lk(this->wait_m);
        this->alarm_cv->wait(lk);
        if (!this->raning && this->timer_th.joinable()) {
            this->timer_th.join();
            int _id = this->curent_id;
            this->curent_id = -1;
            return _id;
        }
    }
    return -1;
}

// privot metods
void Timer::timer_run(std::chrono::seconds timeout) {
    this->raning = true;
    std::unique_lock lk(this->timer_m);
    this->timer_stop_cv.wait_for(lk, timeout, [this]{return this->curent_id == -1;});
    this->raning = false;
    alarm_cv->notify_all();
}
