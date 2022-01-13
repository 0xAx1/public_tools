#! /bin/bash

sudo apt-get install -y vim 
sudo sh -c " echo 'alias vi=vim' >> /etc/profile"
sudo source /etc/profile
echo "set nocompatible" >> ~/.vimrc
sudo update-alternatives --config editor
sudo apt install bash-completion

sudo timedatectl set-timezone Europe/Paris

sudo usermod -aG systemd-journal $(whoami)
sudo usermod -aG adm $(whoami)
