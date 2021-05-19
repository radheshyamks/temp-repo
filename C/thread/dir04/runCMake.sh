#! /usr/bin/env bash

cd build/

cmake -S ../ -B ./

make

./thread

echo -e "\n"
read -p "enter yes to clean build dir: " Y

if [ $Y == "yes" ]
then
	echo "cleaning build dir"
	rm -rf *
else
	echo "build dir is not cleaned"
fi
