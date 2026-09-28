#include <iostream>

class RAII{
public:
    RAII() {
        std::cout << "acquire" << std::endl;
    }
    ~RAII() {
        std::cout << "release" << std::endl;
    }
};

int main() {
    {
        RAII* raii = new RAII();
    }

    RAII raii2;
    return 0;
}