#!/bin/bash

cd build/
cmake -S ../ -B ./

echo -e "\nRUNNING Makefile...\n"
make

echo -e "\nRUNNING EXECUTABLE FILE...\n"
./thread

echo -e "\n"
read -p "press yes to clean the build directory..." Y
if [ $Y == "yes" ]
then
	echo -e "\ncleaning all files and folder from build dir...\n"
	rm -rf *
else
	echo -e "\nbuild directory is not cleaned...\n"
fi
