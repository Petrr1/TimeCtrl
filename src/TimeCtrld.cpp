#include <iostream>
#include "include/timer.hpp"
#include <thread>

void func(){
    sleep(4);
}

int main() {
    Timer test_timer(4);
    std::thread test_thread(func);
    test_thread.join();
    std::cout << "ddd\n";
    return 0;
}
