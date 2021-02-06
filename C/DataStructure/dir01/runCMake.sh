#! /bin/bash
cd build
cmake -S ../ -B ./
make

echo -e "\nRUNNING EXECUTABLE FILE...\n"

./fibonacci
echo -e "\n"
read -p "ENTER YES TO CLEAR BUILD DIRECTORY...: " Y
if [ $Y == "yes" ]
then
	echo -e "\ncleaning build directory...\n"
	rm -rf *
else
	echo -e "\nbuild directory is not clean...\n"
fi
