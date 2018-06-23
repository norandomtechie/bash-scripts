#!/bin/bash
# Second script. This one grabs top headlines from newsapi.org
# in JSON format, parses them and prints them out in nicely
# formatted strings.
# Author: Niraj Menon, 2018

printf "\n"
tput clear

text=$(curl https://newsapi.org/v2/top-headlines -G -d sources=bbc-news -d apiKey=891aa9896d21492ea6eee28a1355b6c6 -s)
i="0"

echo $(tput bold && tput setaf 7)"From the BBC:"
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


##############################################################################################
IGNORE ALL TEXT HERE:

###################################################
# Custom commands
gsettings set org.gnome.mutter overlay-key "'Super_L'"
gsettings set org.pantheon.desktop.gala.behavior overlay-action "'wingpanel --toggle-indicator=app-launcher'"

alias update-bash='source ~/.bashrc'
alias download='bash ~/download.sh'
alias headlines='bash ~/headlines.sh'
alias fixwifi='cd ~/rtlwifi_new && sudo modprobe -rv rtl8723be && sudo modprobe -v rtl8723be ant_sel=2 && cd ~'
alias settings='nano ~/.bashrc'
alias hennessy='ssh menon18@ecegrid.ecn.purdue.edu'
alias piConnect='ssh nirajmmenon@128.211.231.220'
alias settings='nano ~/.bashrc'
alias mysshkey='cat ~/.ssh/id_rsa.pub'
alias socks5='ssh -D 9056 -f -C -q -N ubuntu@ec2-35-154-146-143.ap-south-1.compute.amazonaws.com && ps aux | grep ssh'
alias mountWin='sudo mount -o ro /dev/sda4 ~/Windows'

export PATH=~/xmr-stak/build/bin:$PATH
fortune | cowthink -g
echo
###################################################
