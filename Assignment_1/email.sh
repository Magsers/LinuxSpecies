#!/bin/bash

# Script that provides the ability to email certain users or all contacts selected 
# records from the system. 

# First we list all the records in the Species.csv file

cat -b Species.csv

# We then ask the user to select which species they want to email the records of.

echo
echo -n -e "\e[1;34mEnter the name of the species that you would like to email the records of : \e[0m"
echo
echo -n -e "\e[1;33mEnter CTRL C at any time to exit the program or 'n tor return to main menu \e[0m"
echo

read speciesName
if [ "$speciesName" == "n" ]
then
  ./menu.sh
elif [ ! -z $speciesName ]
then
  if grep -q -w -s -i "$speciesName" Species.csv 
  then
    grep -i $speciesName Species.csv > record.txt
    echo
    echo -e "\e[1;34mDo you want to email the $speciesName records to all users? \e[0m"
    echo
    echo -e "\e[1;33mPress 'y' for yes or 'n' to just email the contributors of the selected records \e[0m"
    echo
    read answer
    case $answer in
    # Email all users the selected species.
	[yY] | [yY][eE][sS] )
        echo -e "\e[1;31m Recipients emailed!\e[0m"
	awk -F ':' '{print $4}' Species.csv | sort | uniq > emails.txt
	cat emails.txt | while read addr
	do
	echo "Record(s) Attached.  Please find a report of all the $speciesName records as requested." | mail -s "Species Report" "$addr" -A record.txt
	done;;
    # Email only the users who have submitted the species selected.
	[nN] | [nN][oO] )
        grep -i "$speciesName" Species.csv | sort | uniq | awk -F ':' '{print $4}' > emails.txt 
	echo -e "\e[1;31mRecipients Emailed! \e[0m"
	cat emails.txt | while read addr
	do
	echo "Record(s) Attached.  Please find all the $speciesName records as requested." | mail -s "Species Report" "$addr" -A record.txt	
	done;;
	*) echo -e "\e[1;32m No records emailed.....Exiting...... \e[0m";;
        esac
   else 
   echo -e "\e[1;31m$speciesName is not a valid input \e[0m"
   fi
else 
  echo -e "\e[1;31mYou must enter a valid input \e[0m "
  fi

echo -e "\e[1;35mEmail another record(s)? \e[0m"
echo
echo "Enter 'y' to proceed, 'n' to return to main menu or any other key to exit "
echo

# handles user input giving option to return to main menu or to proceed.

read answer
case $answer in
  [yY] | [yY][eE][sS] )
  ./email.sh;;
  [nN] | [nN][oO] )
  ./menu.sh;;
  *) echo exit;;
esac
