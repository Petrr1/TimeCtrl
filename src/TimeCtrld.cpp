#include "include/timer.hpp"
#include "include/bus.hpp"
#include <atomic>
#include <condition_variable>
#include <mutex>

//atomic<int> comm;

//  void timer(int t){
//      cout << "Start timer.\n";
//      unique_lock lk_timer(timer_m);
//      timer_cv.wait_for(lk_timer, chrono::seconds(t));
//      lk_timer.unlock();
//      comm=stop;
//      comm.notify_all();
//      cout << "Finish timer.\n";
//  }

using namespace std;

int main() {
    condition_variable notify_cv;
    mutex notify_m;
    atomic<int> input_det;
    atomic<comands_> comm;
    comands_ i = null_com;
    atomic<int> timer_final_id = 0;
    bool play = true;

    Buss buss(&comm, &notify_cv);
    Timer timer(&timer_final_id, 1, &notify_cv, 5);


    while (play) {
        unique_lock lk(notify_m);
        notify_cv.wait(lk, [&timer_final_id, &comm]{return timer_final_id!=0 || comm!=null_com;});

        if (timer_final_id != 0) {
            timer_final_id = 0;
            buss.push(-2);
            timer.stop();
        } else if (comm != null_com) {
            i = comm;
            comm = null_com;
            switch (i) {
                case kill:
                    play = false;
                case stop:
                        timer.stop();
                    break;
                case start:
                        timer.run();
                    break;
                case stat:
                    buss.push(timer.get_stat());
                    break;
                default:
                    buss.push(-1);
            }
        }
    }

    return 0;
}
