#!/bin/bash
make --file=Makefile1 all
make --file=Makefile1 run
read -p "Enter yes to clean generated files: " Y

if [ $Y == "yes" ]
then
	make --file=Makefile1 clean
else
	echo "files are not clean"
fi
