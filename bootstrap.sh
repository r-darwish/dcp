#!/bin/bash -e

echo "Installing dependencies"
hash apt-get 2>/dev/null && sudo apt-get update
hash apt-get 2>/dev/null && sudo apt-get install git tmux zsh vim python
hash yum 2>/dev/null && sudo yum install epel-release
hash yum 2>/dev/null && sudo yum install git tmux zsh vim python
hash pacman 2>/dev/null && sudo pacman -Sy --needed git tmux zsh vim python

echo "Cloning DCP"
git clone https://github.com/r-darwish/dcp.git ~/.dcp

echo "Installing DCP"
cd ~/.dcp
./install

echo "Changing the default shell to ZSH"
chsh -s $(which zsh)

echo "Executing ZSH"
exec zsh
