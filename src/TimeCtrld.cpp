#include <iostream>
#include "include/timer.hpp"
#include <string>
#include <thread>

void func(){
    for (int i = 0; i < 5; i++) {
        sleep(2);
        std::cout << i;
    }
}

void func_inp(){
    std::string str;
    std::cin >> str;
}

int main() {
    Timer test_timer(4);
    std::thread test_thread(func);
    test_thread.join();
    std::cout << "ddd\n";
    return 0;
}
