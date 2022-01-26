#!/bin/bash

# Script that adds a record to the Species.csv file when run.  

# while loop that allows for 4 inputs : speciesName, location, 
# date and email and validates date, email and Eircode. 
# Validations were found online.  http://www.stackoverflow.com/

count=0
while [ $count -le 3 ]
do
  ## Species Name ##
  if [ $count -eq 0 ]
  then
    echo -e "\e[1;33mEnter CTRL C at any time to exit program or n to return to main menu \e[0m" 
    echo -e "\e[1;34mPlease enter the species name : \e[0m"
    read speciesName
      ## Ensure species name is not blank
      if [ "$speciesName" == "n" ]
        then
          ./menu.sh
        elif [ ! -z "$speciesName" ]
        then
          count=$((count+1))
          echo "Species Name : $speciesName"
        else
          echo -e "\033[31;5mmYou cannot enter a blank value! \033[0m"
        fi
      fi

    ## Eircode ##
    if [ $count -eq 1 ]
    then
      echo -e "\e[1;34mPlease enter the species location in Eircode format : \e[0m"
      read speciesEircode
      ## Eircode validation
      if [[ "$speciesEircode" =~ ^[ACDEFHKNPRTVWXY]{1}[0-9]{2}[[:space:]]{1}[ACDEFHKNPRTVWXY0-9]{4}$ ]]
      then
        count=$((count+1))
      else
	echo -e "\033[31;5mYou have entered an invalid Eircode.  Please try again : \033[0m"
      fi
    fi

    ## Date ##
    if [ $count -eq 2 ]
    then
      echo -e "\e[1;34mPlease enter the date of recording in the following format YYYY-MM-DD : \e[0m"
      read dateOfRecording
      ## date validation
      if [[ $dateOfRecording =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2}$ ]] && date -d "$dateOfRecording" >/dev/null 2>&1
      then
        count=$((count+1))
        echo "Date Ok"
      else
        echo -e "\033[31;5mYou must enter a valid date. \033[0m"
        echo
      fi
    fi

    ## Email ##
    if [ $count -eq 3 ]
    then
      echo -e "\e[1;34mPlease enter the contact email. \e[0m"
      read recordersEmail
      ## Email validation
      regex="^[a-z0-9!#\$%&'*+/=?^_\`{|}~-]+(\.[a-z0-9!#$%&'*+/=?^_\`{|}~-]+)*@([a-z0-9]([a-z0-9-]*[a-z0-9])?\.)+[a-z0-9]([a-z0-9-]*[a-z0-9])?\$"
      i=$recordersEmail
      if [[ $i =~ $regex ]]
      then
        count=$((count+1))
        echo "Email OK"
      else
        echo -e "\033[31;5mEmail Address Invalid! \033[0m"
      fi
    fi
done

# End of While Loop that adds a record from user input.

# Checks with user that information is accurate and asks how they would like to proceed.

echo -e "\e[1;33m_____________________________Record To Be Added_____________________________ \e[0m"
echo
echo $speciesName ":" $speciesEircode ":" $dateOfRecording ":" $recordersEmail
echo -e "\e[1;33m_____________________________________________________________________________\e[0m"
echo
echo -n "Are you sure you want to add this record? (y/n) or any key to exit : "
read answer

# Checks if user is happy with the input and wants to add the record.  If not exit or start again ##

if [[ "$answer" == "y" || "$answer" == "Y" ]]
  then
    echo -e "\e[1;34m_____________________________________________________________________ \e[0m"
    echo
    echo -e "\e[1;33m$speciesName ":" $speciesEircode ":" $dateOfRecording ":" $recordersEmail added successfully\e[0m"
    echo $speciesName" : "$speciesEircode" : "$dateOfRecording" : "$recordersEmail >> Species.csv
  elif [[ "$answer" == "n" || "$answer" == "N" ]]
    then
    echo -e "\e[1;31mRecord has not been added \e[0m"
fi

# Asks user how they want to proceed.

echo 
echo -e "\e[1;34mDo you want to add another record?\e[0m"
echo
echo "Enter y to proceed, n to return to main menu or any other key to exit"
read answer

case $answer in
  [yY] | [yY][eE][sS] )
    ./addRecord.sh;;
  [nN] | [nN][oO] )
    ./menu.sh;;
  *) echo exit;;
esac

exit
