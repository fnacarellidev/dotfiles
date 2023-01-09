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

ls -a ~ | grep .zshrc > /dev/null
ret=$(echo $?)
if (( ret == 0 )) 
then
	echo -e "${RED}Symbolic link to repo .zshrc was not created, if you want \\
to do that please backup your current .zshrc file and then delete it.${RESET}"
else
	ln -s ~/.dotfiles/.zshrc ~/.zshrc
	if (( echo $? == 0)); then
		echo -e "${GREEN}.zshrc set successfully!${RESET}"
	else
		echo -e "${RED}.zshrc linkage failed${RESET}"
	fi
fi
