#!/bin/bash

cd build
cmake -S ../ -B ./

make

echo -e "\nRUNNING EXECUTABLE FILES...\n"

./prime

echo -e "\n"

read -p "Enter yes to cleaning build directory...: " Y
if [ $Y == "yes" ]
then
	echo -e "\n build directory is clean...\n"
	rm -rf *
else
	echo -e "\nbuild directory is not clean...\n"
fi
