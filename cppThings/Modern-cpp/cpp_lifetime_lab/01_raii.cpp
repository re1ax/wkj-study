#include <cstring>
#include <iostream>

class String {
private:
    char* ptr;
    size_t size;

public:
    String(const char* str) {
        size = std::strlen(str);
        ptr = new char[size + 1];
        for (size_t i = 0; i <= size; i++) {
            ptr[i] = str[i];
        }
        std::cout << "String is constructed!" << std::endl;
    }

    String(const String& other) : size(other.size) {
        std::cout << "String is Copied!" << std::endl;
        this->ptr = new char[size + 1];
        for (size_t i = 0; i <= size; i++) {
            ptr[i] = other.ptr[i];
        }
    }

    ~String() {
        delete[] ptr;
        std::cout << "String is deleted!" << std::endl;
    }

    String& operator=(const String& other) {
        for (int i = 0; i <= other.size; i++) {
            this->ptr[i] = other.ptr[i];
        }
        this->size = other.size;

        return *this;
    }

    // 移动构造函数（转移所有权）
    String(String&& other) noexcept
        : ptr(std::move(other.ptr)), size(std::move(other.size)) {
        other.ptr = nullptr;  // 必须将源对象置空
        other.size = 0;
        std::cout << "String move constructed\n";
    }

    void print() {
        for(size_t i = 0; i < size; i++) {
            std::cout << ptr[i];
        }
        std::cout << std::endl;
    }
};

int main() {
    String str(std::move(String("string")));
    String str2 = str;
    while(true) {
        
    }
    return 0;
}