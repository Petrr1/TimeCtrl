#include "include/timer.hpp"
#include "include/bus.hpp"
#include <atomic>
#include <chrono>
#include <condition_variable>
#include <iostream>
#include <mutex>
#include <vector>

using namespace std;

int main() {
    condition_variable notify_cv;
    atomic<comands_> comm;
    comands_ i = null_com;
    bool play = true;

    vector<chrono::seconds> timers_v = {chrono::seconds(10), chrono::seconds(5), chrono::seconds(15)};

    Buss buss(&comm, &notify_cv);
    Timer timer(timers_v, &notify_cv);


    while (play) {
        int id = timer.wait();
        if (id != -1) {
            buss.push(-2);
        } else if (comm != null_com) {
            i = comm;
            comm = null_com;
            switch (i) {
                case kill:
                    timer.stop();
                    play = false;
                case stop:
                    timer.stop();
                    break;
                case start:
                    timer.run(0);
                    break;
                default:
                    buss.push(-1);
            }
        }
    }

    return 0;
}
