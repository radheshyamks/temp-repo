cmake_minimum_required(VERSION 3.12)
project(PROJECTNAME VERSION 1.1)
#configurefile.hh.in is input file we will write it and cmake will generate configurefilename.hh file
configure_file(configurefile.hh.in configurefilename.hh)
#to create your own variable
set(VARIABLE_NAME "VALUE")
set(target "PROJECTNAME")
set(SOURCE_FILE main.cpp
	)
message("write your message to print on console")
#for the angular bracket
include_directories(${CMAKE_CURRENT_SOURCE_DIR} ${PROJECT_BINARY_DIR})
add_library(${LINKABLE_NAME} filename.cpp)
add_executable(${target} ${SOURCE_FILE})
target_link_libraries(${target} ${LINKABLE_NAME})
