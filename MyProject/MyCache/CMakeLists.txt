#要求 CMake 最低版本
cmake_minimum_required(VERSION 3.10)

#项目名字
project(MyCache)

#使用C++17
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

include_directories(include)

add_executable(main
    src/main.cpp
)

add_executable(test_lru
    tests/test_lru.cpp
)

add_executable(test_lfu
    tests/test_lfu.cpp
)

add_executable(test_all_cache_policy
    tests/test_all_cache_policy.cpp
)

add_executable(test_thread_safety
    tests/test_thread_safety.cpp
)

add_executable(test_hash_lru
    tests/test_hash_lru.cpp
)

add_executable(test_hash_lfu
    tests/test_hash_lfu.cpp
)

add_executable(test_lfu_aging
    tests/test_lfu_aging.cpp
)
