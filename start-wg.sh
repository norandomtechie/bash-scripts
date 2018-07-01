#!/bin/bash

sudo wg-quick up layer-brother
printf "\n"
read -n 1 -s -r -p "Wireguard is up, press any key to stop..."
printf "\n"
sudo wg-quick down layer-brother
