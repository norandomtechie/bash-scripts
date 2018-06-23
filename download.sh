#!/bin/bash
#First ever bash script! - Niraj Menon

regex='(https?|ftp|file)://[-A-Za-z0-9\+&@#/%?=~_|!:,.;]*[-A-Za-z0-9\+&@#/%=~_|]'

if [ -z "$1" ]; then
        printf "\nScript requires a download link!\n\n"
        exit
fi

if [ $1 =~ $regex ] 
then
        printf "\nStarting download...\n\n"
        aria2c "$1" -x 8 --file-allocation=none -d / -o home/nirajmmenon/Downloads
else
        printf "\nERROR: You have not entered a valid web address!\n\n"
fi

exit
