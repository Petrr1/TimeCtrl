#include <condition_variable>
#include <iostream>
#include "include/timer.hpp"
#include <mutex>
#include <ostream>
#include <thread>
#include <unistd.h>

using namespace std;
condition_variable manager;
mutex mutex;

void func(){
    sleep(5);
}

void func_inp(){
}

int main() {
    unique_lock lk(manager);
    return 0;
}
