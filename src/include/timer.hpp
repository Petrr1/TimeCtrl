#include <unistd.h>

class Timer {
    public:
        Timer();
        Timer(int time_s);
        ~Timer();
        void run();
    private:
        int _id;
        int _time;
};
