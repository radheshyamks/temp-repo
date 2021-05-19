#! /usr/bin/env bash
set -x
cd build
cmake -S ../ -B ./
make
./mutex
echo -e 
read -p "enter yes to clean build dir: " Y

if [ $Y=="yes" ]
then
	echo "build dir is cleaned"
	rm -rf *
	if [ $? -eq 0 ]
	then
		echo "build dir is successfully cleaned"
	fi
else
	echo "build dir is not cleaned"
fi
set -x
