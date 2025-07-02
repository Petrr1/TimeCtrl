#include <atomic>
#include <chrono>
#include <condition_variable>
#include <iostream>
#include "include/timer.hpp"
#include "include/bus.hpp"
#include <mutex>
#include <string>
#include <sys/poll.h>
#include <thread>
#include <poll.h>

using namespace std;
condition_variable timer_cv;
mutex consol_m;
mutex timer_m;
atomic<int> input_det;
atomic<comands_> pip;
//atomic<int> pip;

void timer(int t){
    cout << "Start timer.\n";
    unique_lock lk_timer(timer_m);
    timer_cv.wait_for(lk_timer, chrono::seconds(t));
    lk_timer.unlock();
    pip=stop;
    pip.notify_all();
    cout << "Finish timer.\n";
}

int main() {
    Buss buss(&pip);
    pip = start;
    comands_ i = pip;
    thread tim(timer, 10);
    pip.wait(i);
    i=pip;
    switch (i) {
        case stop:
            timer_cv.notify_all();
            tim.join();
            break;
        case start:
            buss.push(2);
            break;
        default:
            cout << "NULL\n";
    }

    return 0;
}
