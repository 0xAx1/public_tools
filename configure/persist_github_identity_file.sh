#! /bin/bash

eval "$(ssh-agent -s)"

read -e -p "Give your identity file FULL path:" id_file
id_file=$( echo $id_file | sed "s+~+$HOME+")
ssh-add $id_file

echo "Host github.com" >> ~/.ssh/config 
echo "    User git " >> ~/.ssh/config
echo "    IdentityFile $id_file" >> ~/.ssh/config


sudo apt update 
sudo apt install -y git

read -e -p "user.email:" mail
git config --global user.email "$mail"

read -e -p "user.name:" name
git config --global user.name "$name"
