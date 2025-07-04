#include <atomic>
#include <condition_variable>
#include <chrono>
#include <stdexcept>
#include <mutex>
#include <thread>
#include <thread>

enum status_ {
    stop_s,
    run_s,
    proc_stop_s,
};

class Timer {
    public:
        Timer(std::condition_variable* notife_cv, int time_sec);
        Timer(std::atomic<int>* timer_pip, int id_timer, std::condition_variable* notife_cv, int time_sec);
        ~Timer();

        void run();
        void stop();
        status_ get_stat();

    private:
        int _time;
        int _id=0;
        void run_timer();
        std::atomic<status_> stat;

        std::thread timer_trad;
        std::condition_variable stop_trig;
        std::mutex timer_ctrl;

        std::condition_variable* event_cv;
        std::atomic<int>* event_id;
};
