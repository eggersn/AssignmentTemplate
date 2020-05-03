#!/bin/bash
flag=1

while [ $flag -eq 1 ]
do
clear
echo "Manage your Repository"
echo "[0] Set Title [1] Manage Authors [2] Set Group [3] Exit"
read choice

if ! [ -f config.txt ]
then
	echo -e "Title:" > config.txt
	echo -e "Group:" >> config.txt
fi

if [ $choice -eq 0 ]
then
	echo "Set Title:"
	read title
	sed -i "s/Title:.*\$/Title:$title/g" config.txt
elif [ $choice -eq 1 ]
then
	echo "The following Authors are known:"
	grep -o "Name: .*\$" config.txt
	echo

	echo "[0] Add Author [1] Edit Author [2] Delete Author"
	read choice
	
	if [ $choice -eq 0 ]
	then
		echo "Name:"
		read name
		echo "Student Number:"
		read studentNumber
		echo -e "Name: $name StudentNumber: $studentNumber" >> config.txt
	elif [ $choice -eq 1 ]
	then
		echo "Enter name of the Author:"
		read name
		echo "Enter a new Name:"
		read newName
		echo "Enter a new Student Number:"
		read studentNumber
		sed -i "s/Name: $name .*\$/Name: $newName StudentNumber: $studentNumber/g" config.txt
	elif [ $choice -eq 2 ]
	then 
		echo "Enter name of the Author:"
		read name
		sed -i "/Name: $name .*\$/d" config.txt
	fi
elif [ $choice -eq 2 ]
then
	echo "Set Group: (e.g: \"Group 14 (Tutorname)\"):"
	read group
	sed -i "s/Group:.*\$/Group:$group/g" config.txt

elif [ $choice -eq 3 ]
then
	echo "Exiting..."
	flag=0
else
	echo "Invalid input! Exiting..."
	flag=0
fi
done
