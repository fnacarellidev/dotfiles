#!/bin/bash
RESET="\033[0m"
RED="\033[31m"
GREEN="\033[32m"
YELLOW="\033[33m"

ls -a ~ | grep .gitconfig > /dev/null
ret=$(echo $?)
if (( ret == 0 ))
then
	echo -e "${RED}Symbolic link was not created, if you want to do that, \
please remove your .gitconfig file first.${RESET}"
else
	ln -s ~/.dotfiles/.gitconfig ~/.gitconfig
	echo -e "${GREEN}.gitconfig set successfully!${RESET}"
fi
