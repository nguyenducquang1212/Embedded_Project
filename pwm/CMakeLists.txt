cmake_minimum_required(VERSION 3.5)

include($ENV{IDF_PATH}/tools/cmake/project.cmake)
project(pwm)
target_add_binary_data(${CMAKE_PROJECT_NAME}.elf "html/index.html" TEXT)