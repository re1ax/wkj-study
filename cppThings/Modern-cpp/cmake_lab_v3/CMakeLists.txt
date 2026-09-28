cmake_minimum_required(VERSION 3.15)
project(CMAKE_LAB VERSION 2.0)
# set(SRC add.cpp; del.cpp; main.cpp)

# aux_source_directory(${PROJECT_SOURCE_DIR} SRC)

file(GLOB SRC ${CMAKE_CURRENT_SOURCE_DIR}/*.cpp)
include_directories(${CMAKE_CURRENT_SOURCE_DIR}/include)

set(CMAKE_CXX_STANDARD 17)
set(EXECUTABLE_OUTPUT_PATH ..)


# # 静态库
# add_library(calc STATIC ${SRC})
# 链接静态库
# link_libraries(calc)
# link_directories(${CMAKE_CURRENT_SOURCE_DIR}/lib1)

link_directories(${CMAKE_CURRENT_SOURCE_DIR}/lib2)


add_executable(app ${SRC})

# 动态库
# add_library(calc SHARED ${SRC})
target_link_libraries(app PUBLIC calc)


# set(LIBRARY_OUTPUT_PATH ${CMAKE_CURRENT_SOURCE_DIR}/lib)