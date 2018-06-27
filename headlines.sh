#!/bin/bash
# Second script. This one grabs top headlines from newsapi.org
# in JSON format, parses them and prints them out in nicely
# formatted strings.
# Author: Niraj Menon, 2018

printf "\n"
tput clear

text=$(curl https://newsapi.org/v2/top-headlines -G -d sources=bbc-news -d apiKey=891aa9896d21492ea6eee28a1355b6c6 -s)
i="0"

echo $(tput bold && tput setaf 2)"From the BBC (will change later):"
printf "\n"

while [ $i -lt 25 ] && [ "$(echo $text | jq '.articles['"$i"'].title')" != "null" ]
do
        title=$(echo $text | jq '.articles['"$i"'].title')
        echo $(tput setaf 1 && tput bold)${title}

        desc=$(echo "${text}" | jq '.articles['"$i"'].description')
        echo $(tput setaf 7)${desc}
        printf "        "

        url=$(echo "${text}" | jq '.articles['"$i"'].url')
        echo $(tput sgr0 && tput setaf 7)${url}
        printf "\n"

        i=$[$i+1]
done

exit
