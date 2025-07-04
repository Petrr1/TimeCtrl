#include <string>
#include <condition_variable>
#include <iostream>
#include <poll.h>
#include <atomic>
#include <thread>

enum comands_ {
    null_com,
    stop,
    start,
    stat,
    kill
};

class Buss {
    public:
        Buss(std::atomic<comands_>* output);
        Buss(std::atomic<comands_>* output, std::condition_variable* event);
        ~Buss();

        void push(int data);
    private:
        void pull();
        void set_comm(comands_ arg);

        std::thread reader;
        std::atomic<bool> run;

        std::atomic<comands_>* command_pipe;
        std::condition_variable* command_cv;
//      std::mutex use_buss;
};
