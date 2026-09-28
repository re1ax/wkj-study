cmake_minimum_required(VERSION 3.15)
project(CMAKE_LAB VERSION 2.0)
# set(SRC add.cpp; del.cpp; main.cpp)

# aux_source_directory(${PROJECT_SOURCE_DIR} SRC)

file(GLOB SRC ${CMAKE_CURRENT_SOURCE_DIR}/src/*.cpp)
include_directories(${CMAKE_CURRENT_SOURCE_DIR}/include)

set(CMAKE_CXX_STANDARD 17)
# set(EXECUTABLE_OUTPUT_PATH ..)
# add_executable(app ${SRC})

# 动态库
add_library(calc SHARED ${SRC})

# # 静态库
# add_library(calc STATIC ${SRC})

set(LIBRARY_OUTPUT_PATH ${CMAKE_CURRENT_SOURCE_DIR}/lib)