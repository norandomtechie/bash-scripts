#!/bin/bash

# Author: Niraj Menon, 2018
# This script sets up RSA public-private key pair access to the server passed as an argument to this script.
# Part of the reason why I learnt bash was just so I could do this, lmao.

# To the layman, this script lets you connect without a password to a server you provide using a pair of files
# known to both you and the server, called a key file pair. You have the public and private keys, and the
# server will have the public key. When you attempt to connect, the server will, in a sense, compare your
# public key files in order to make sure it is indeed you who is connecting.

# Remember to give your username as well in the format username@server.com
# You will be asked to provide your password twice.
SERVER=$1
USEKEY='Y'

if [ "$#" -lt 1 ]
then
        exit
else
	printf "\nSSH-RSA Setup:\n"
	printf "Copyright, Niraj Menon, 2018\n"
	printf "Scanning for public/private keys in ~/.ssh...\n\n"
fi

if [ -f ~/.ssh/id_rsa ]
then
        printf "A key-pair already exists. Do you wish to use this key-pair?\n"
        printf "If you're unsure of what to do, just type Y and enter.\n"
        read usekey
else
	printf "Key files not found, generating new pair...\n"
        usekey='N'
fi

if [ "$usekey" == 'n' -o "$usekey" == 'N' ]
then
	printf "\n"
        rm -f ~/.ssh/id_rsa*
        ssh-keygen -f ~/.ssh/id_rsa -t rsa -N ''
fi

printf "\nWhile adding your key-file to the server, we will request your password twice."
printf "\nThis is required in order to copy the file and add it to your list of authorized users. \n\n"
printf "Attempting to access server...\n"
RETURNCODE=$(scp ~/.ssh/id_rsa.pub $SERVER:~/.ssh/pubkey.pub)

if [[ "$RETURNCODE" -eq 0 ]]
then
        printf "Success!\n"
        printf "\nAdding public key to server...\n"
        ssh -q $SERVER 'cat ~/.ssh/pubkey.pub >> ~/.ssh/authorized_keys && rm -f ~/.ssh/pubkey.pub'

        printf "\nThe key has been added to the server. Run the command:\n"
        printf "ssh $SERVER\n"
        printf "to access your server without a password!\n\n"
else
        printf "The SSH attempt returned the error code $RETURNCODE\n"
fi
