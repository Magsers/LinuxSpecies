#!/bin/bash

# remove.sh Script to remove a record that the user has chosen to remove.

# List the records in the Species.csv file. This is convenient for a small system but
# obviously with a larger system would use a search and email funciton.

cat -n Species.csv

# Request user input giving an option to return to main menu also or quit the program

echo
echo -e "\e[1;34mPlease enter the line number of the species you would like to remove the record of : \e[0m"
echo
echo -e "\e[1;33mPress CTRL C at any time to exit the program or 'n' to return to main menu.\e[0m"

# read user input and remove record selected.

read -r lineNumber

numOfRecords=$( wc -l < "Species.csv" )

# if statement to check that the line number entered by the user has a valid record
# and if so it removes the record.

if [ ! -z "$lineNumber" ]
then
  if [ "$lineNumber" == "n" ]
  then 
    ./menu.sh
  elif [ "$lineNumber" -le "$numOfRecords" 2>/dev/null ]
  then 
    sed -i "${lineNumber}d" Species.csv
    echo -e "\e[1;31mRecord $lineNumber removed! \e[0m"
  else
    echo -e "\e[1;31mYou must enter a valid line number. \e[0m"
  fi 
else
  echo -e "\e[1;31mYou entered a blank value! \e[0m"
fi

##  Checks to see if user wants to continue with the program or to exit to either 
##  the main menu or the program.

echo
echo -e "\e[1;34mDo you want to remove another record? \e[0m"
echo
echo -e "\e[1;33mEnter 'y' to proceed, 'n' to return to main menu or any other key to exit \e[0m"

# read user input and case statement to handle the selection

read answer
echo

case $answer in 
  [yY] | [yY][eE][sS] )
    ./remove.sh;;
  [nN] | [nN][oO] )
    ./menu.sh;;
  *) echo exit;;
esac
