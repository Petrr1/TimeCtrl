cmake_minimum_required(VERSION 4.0)
project(TimeCtrl VERSION 0.1)
set(CMAKE_CXX_STANDARD 20)
add_executable(TimeCtrld src/TimeCtrld.cpp src/timer.cpp src/bus.cpp)
