#!/bin/sh
servlist=$(vim --serverlist)

if [[ ! -z $servlist ]]
then
    vim --remote-tab-silent $@
else
	$($TERMINAL -e zsh -c "vim --servername VIM $@")
fi
