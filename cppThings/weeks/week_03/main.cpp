#include <iostream>
#include <thread>
#include <mutex>

int count = 0;
std::mutex mtx;

void work(unsigned int time) {
    for (int i = 0; i < time; ++i) {
        std::lock_guard<std::mutex> lock(mtx);
        count++;
    }
}

int main() {
    std::thread t1(work, 10000);
    std::thread t2(work, 10000);

    t1.join();
    t2.join();

    std::cout << count << '\n';
}