#include <cstring>
#include <iostream>

class String {
private:
    char* ptr;
    int size;

public:
    String(const char* str) {
        size = strlen(str);
        ptr = new char[size + 1];
        for (int i = 0; i <= size; i++) {
            ptr[i] = str[i];
        }
        std::cout << "String is constructed!" << std::endl;
    }
    // 拷贝构造
    String(const String& other) {
        std::cout << "String is constructed by coping!" << std::endl;
        size = strlen(other.ptr);
        this->ptr = new char[size + 1];
        
        for (int i = 0; i <= size; i++) {
            ptr[i] = other.ptr[i];
        }
    }
    ~String() {
        delete[] ptr;
        std::cout << "String is deleted!" << std::endl;
    }
    // 拷贝赋值
    String& operator=(const String& other) {
        std::cout << "String is assignment by coping!" << std::endl;
        if (this != &other) {
            size = strlen(other.ptr);
            ptr = new char[size + 1];
            for (int i = 0; i <= size; i++) {
                ptr[i] = other.ptr[i];
            }
        }
        return *this;
    }

    String(String&& other) {
        std::cout << "String is constructed by move!" << std::endl;
        this->ptr = other.ptr;
        this->size = other.size;
        other.ptr = nullptr;
        other.size = 0;
    }

    String& operator=(String&& other) {
        std::cout << "String is assignment by move!" << std::endl;
        if (&other != this) {
            this->ptr = other.ptr;
            this->size = other.size;
            other.ptr = nullptr;
            other.size = 0;
        }
        return *this;
    }
};

int main() {
    String str1 = "string1";
    String str2 = std::move(str1);
    str1 = std::move(str2);
    return 0;
}