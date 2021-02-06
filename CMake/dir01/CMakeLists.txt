cmake_minimum_required(VERSION 3.12)

#setting the project name
#project(rough)
project(rough VERSION 1.1.0)
set(MY_STRING "this is my string")
set(MY_OTHER_STRING "this is a string")
set(my_val 1)

while(my_val LESS 50)
	message(STATUS "my_value is ${my_val}")
	math(EXPR my_val "${my_val} + 1")
endwhile()
