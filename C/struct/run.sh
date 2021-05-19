#! /bin/bash
echo -e "\n------------Running Makeile----------\n"
make all

echo -e "\n-------------Running executable file-----------"
make run

read -p "Enter yes to clean genrated files: " Y

if [ $Y == "yes" ]
then
	echo -e "\n-----Cleaning generated files-----\n"
	make clean
else
	echo -e "\n-----Generated files are not deleted-----\n"
fi
