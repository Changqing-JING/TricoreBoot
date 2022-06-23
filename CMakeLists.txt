cmake_minimum_required(VERSION 3.5)
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_C_COMPILER $ENV{TRICORE_GCC_PATH}/tricore-elf-gcc)
set(CMAKE_CXX_COMPILER $ENV{TRICORE_GCC_PATH}/tricore-elf-g++)

project(TricoreBoost)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

set(CPUFlag "-mcpu=tc39xx")

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${CPUFlag}")

set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${CPUFlag}")

set(linkerScript ${CMAKE_CURRENT_SOURCE_DIR}/link_c.ld)

set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS}  -Wl,-T ${linkerScript}")

add_executable(cpp_demo cpp_demo.cpp)
add_executable(c_demo c_demo.c)

set_target_properties(cpp_demo PROPERTIES LINK_DEPENDS ${linkerScript})
set_target_properties(c_demo PROPERTIES LINK_DEPENDS ${linkerScript})