#include "include/bus.hpp"

// construct|destruct
Buss::Buss(std::atomic<comands_>* output) {
    std::cout << "Start Buss\n";
    command_cv = nullptr;
    run = true;
    reader= std::thread(&Buss::pull, this);
    command_pipe = output;
}

Buss::Buss(std::atomic<comands_>* output, std::condition_variable* event){
    std::cout << "Start Buss\n";
    command_cv = event;
    run = true;
    reader= std::thread(&Buss::pull, this);
    command_pipe = output;
}

Buss::~Buss() {
    run = false;
    reader.join();
    std::cout << "Finish Buss\n";
}

// public metods
void Buss::push(int data) {
    std::cout << "Get data: " << data << "\n";
}

// private metods
void Buss::pull() {
    std::string str;
    struct pollfd fds;
    fds.fd = STDIN_FILENO;
    fds.events = POLLIN;
    while (run) {
        if (poll(&fds, 1, 200) > 0) { 
            std::cin >> str;
            if (str == "start") {
                set_comm(start);
            }else if (str == "stop") {
                set_comm(stop);
            }else {
                this->push(-1);
            }
        }
    }
}

void Buss::set_comm(comands_ arg){
    *command_pipe = arg;
    command_pipe->notify_all();
    if (command_cv) {command_cv->notify_all();}
}
