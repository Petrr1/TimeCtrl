#include <atomic>
#include <condition_variable>
#include <chrono>
#include <mutex>
#include <thread>
#include <thread>
#include <vector>

class Timer {
    public:
        Timer(const std::vector<std::chrono::seconds> timers, std::condition_variable* notify = nullptr);
        ~Timer() = default;

        void run(int id);
        void stop();
        int wait();

    private:
        void timer_run(std::chrono::seconds timeout);

        std::vector<std::chrono::seconds> timers;
        // timer controll
        std::thread timer_th;
        std::condition_variable timer_stop_cv;
        std::mutex timer_m;
        std::atomic<int> curent_id;
        std::atomic<bool> raning;
        // event notify
        std::condition_variable* alarm_cv;
        bool alarm_out;
        std::mutex wait_m;
};
