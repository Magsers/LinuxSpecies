#!/bin/bash

## Script to search for a species by its name.

echo -e "\e[1;34mPlease enter the name of the species you would like to search for\e[0m"
echo
echo -e "\e[1;33mPress CTRL C at any time to exit the program or 'n' to return to main menu\e[0m"

read speciesName

# if statement to check if user input is not empty and if so it searches using 
# a grep and if true it displays the record(s) and the number of records.

if [ "$speciesName" == "n" ]
then
  ./menu.sh
  elif [ ! -z "$speciesName" ]
  then
    if grep -i -q -w "$speciesName" Species.csv
    then
      echo
      echo -e "\e[1;32mMatching Record(s) found! \e[0m"
      echo -e "\e[1;32m------------------------- \e[0m"
      grep --text -i -s "$speciesName" Species.csv
      echo
      echo -e "\e[1;32mNumber of Records Found : \e[0m" 
      grep -i -o -w "$speciesName" Species.csv | wc -l
      echo -e "\e[1;32m------------------------ \e[0m"
      echo
    else
      echo -e "\e[1;31m There are no matching records. \e[0m"
    fi
  else
    echo -e "\033[31;5m You have entered a blank value. \033[0m"
fi

# Checks to see if the user wants to search again

echo -e "\e[1;33mWould you like to search for another record (y), go back to the main menu (n) or any key to exit : \e[0m"
read answer
 
case $answer in
  [yY] | [yY][eE][sS] )
    ./search.sh;;
  [nN] | [nN][oO] )
    ./menu.sh;;
  *) echo exit;;
esac
