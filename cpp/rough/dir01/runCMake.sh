#!/bin/bash
cd build
cmake -S ../ -B ./

echo -e "\nRUNNING MAKE FILE...\n"

make

echo -e "\nRUNNING EXECUTABLE FILE...\n"

./rough

echo -e "\n"
read -p "Enter yes to clean build directory: " Y

if [ $Y == "yes" ]
then
	echo -e "\nCleaning build directory...\n"
	rm -rf *
else
	echo -e "\nbuild directory is not clean...\n"
fi
