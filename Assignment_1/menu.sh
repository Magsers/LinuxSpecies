#!/bin/bash

# The Main Menu Script
# Includes coloured text for visual impact and to ensure it's legible.
# Warning at the bottom to ensure user doesn't exit accidentally.

echo 
echo
echo -e "\e[1;32mWelcome!!! Please choose one of the following : \e[0m" 
echo -e "\e[1;32m------------------------------------------------------------------ \e[0m"
echo
echo -e "\e[1;33m1. Add a new Recording of a Species"
echo "2. Remove an existing Species Record"
echo "3. Search for Species"
echo "4. E-mail Record(s)"
echo -e "5. Quit \e[0m"
echo
echo -e "\e[1;32m------------------------------------------------------------------- \e[0m"
echo
echo -e "\e[1;34mPlease enter one of the numbers above. \e[0m"
echo -e "\033[31;5mWarning : Invalid input will exit the program. \033[0m"
echo

# case statement to handle user input.  Runs each script corresponding to the number 
# the user enters

read number
case $number in 
	[1] )
	./addRecord.sh;;
	[2] )
	./remove.sh;;
	[3] )
	./search.sh;;
	[4] )
	./email.sh;;
	[5] )
	exit;;
	*)
	echo -e "\e[1;31m Invalid Input : Exiting Program \e[0m";;
	esac

