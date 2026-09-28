#include <iostream>
#include <memory>

int main() {
    std::unique_ptr<int> uPtr1 = std::make_unique<int>(10);
    //1. 创造智能指针
    std::cout << "uPtr1 Value:" << *uPtr1 << std::endl;

    //2. 拷贝失败
    // std::unique_ptr<int> uPtr2 = uPtr;

    //3. 转移所有权
    std::unique_ptr<int> uPtr2 = std::move(uPtr1);
    std::cout << "uPtr1 is emoty?:" << !uPtr1 << std::endl;
    std::cout << "uPtr2 Value" << *uPtr2 << std::endl;

    //4. reset
    uPtr2.reset(); //释放当前指向的内存，将指针置空
    uPtr2.reset(new int(100)); // 释放当前内存，重新指向新的内存
    //5. release and get
    std::cout << "uPtr2 address:" << uPtr2.get() << std::endl; 
    int* ptr = uPtr2.release();
    std::cout << "ptr address:" << ptr << std::endl;
    std::cout << "uPtr2 address:" << uPtr2.get() << std::endl; //已经释放了的unique指针
    uPtr2.reset();
    
    return 0;
}