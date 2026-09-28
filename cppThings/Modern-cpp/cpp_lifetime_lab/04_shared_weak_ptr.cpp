#include <iostream>
#include <memory>

int main() {
    std::shared_ptr<int> sPtr1 = std::make_shared<int>(10);
    std::shared_ptr<int> sPtr2 = sPtr1;
    std::shared_ptr<int> sPtr3 = sPtr1;
    std::shared_ptr<int> sPtr4 = sPtr1;
    std::shared_ptr<int> sPtr5 = sPtr1;

    std::cout << "sPtr1 address:" << sPtr1.get() << std::endl;
    std::cout << "sPtr1 value:" << *sPtr1 << std::endl;
    std::cout << "sPtr2 address:" << sPtr2.get() << std::endl;
    std::cout << "sPtr2 value:" << *sPtr2 << std::endl;

    std::cout << "Before weak_ptr sPtr count:" << sPtr1.use_count()
              << std::endl;
    std::weak_ptr<int> wPtr = sPtr1;
    std::cout << "After weak_ptr sPtr count:" << sPtr1.use_count() << std::endl;
    //
    std::shared_ptr<int> sPtr = std::make_shared<int>(10);
    std::weak_ptr<int> wPtr2 = sPtr;
    std::cout << "wPtr2 value:" << *wPtr2.lock() << std::endl;
    sPtr.reset();
    std::cout << "wPtr2 not null:" << !wPtr2.lock() << std::endl;

    return 0;
}