---
title: System ToDo
hide_sidebar: true
permalink: todo
summary: What needs to be done on the system. 
---

- drivers for corsair
- use other terminal for normal work, that has a scrollback
	- do some research
	- still use alacritty for neovim work

- fix rofi and caps
	- caps lock might have been not bound accidentally? like mouse sometimes malfunctions
	- actually that rofi position is better given that vim displays matches at the bottom as well 

- look into zsh plugins

system maintenance
	- update activity-watch
	- uninstall unimportant packages

- consider having some rcs in ramfs?

plan carefully the system's bash scripts behaviour for building, running etc 
	- with bullet poitns!
	- introduce convenient single-file cpp build
		- (perhaps should work on f5/f6/f7 or just s+f7?)
		- should run a command like gdb sth sth

## Done

 Don't freeze editor on Ctrl+S
 Looks like we no longer need it though
 stty -ixon

function reb() {
	git fetch upstream
	git checkout master
	git rebase upstream/master
}

