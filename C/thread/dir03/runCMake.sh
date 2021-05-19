#!/bin/bash

cd build/
cmake -S ../ -B ./

echo -e "\nRUNNING Makefile...\n"
make

echo -e "\n--------------RUNNING EXECUTABLE FILE--------------\n"
./thread

echo -e "\n"
read -p "press yes to clean the build directory: " Y
if [ $Y == "yes" ]
then
	echo -e "\n---------------Cleaning build dir---------------\n"
	rm -rf *
else
	echo -e "\n----------------build directory is not cleaned----------------\n"
fi
