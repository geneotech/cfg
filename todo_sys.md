---
title: System ToDo
hide_sidebar: true
permalink: todo
summary: What needs to be done on the system. 
---


- fix bindings for copying paths?

- use sxiv bash script so we have more customization opts

- primary facilities
	- NEOVIM (short: VIM)
		- TEXT EDITING
		- NAVIGATION
			- only through projects/cwds
			- open non-text files through rifle
		- FILESYSTEM OPS
			- only for single files (e.g. current)
			- deletion, rename, new
	- RANGER
		- NAVIGATION
		- MASS OPTIONS		

- search modes
	- exact matching is accomplished with ^
		- sucks though to have to go that far
	- notice that speed is only important when we're working on a project
		- there also comes accuracy, but we can write specific file paths
		Don't we really only care about vim's behaviour?
			- If it's not a text file, let's just offload it to rifle
				- NO! From vim, always open in vim!
				- From ranger, always open in ranger.
				- when we want to look for some png files, we'll always just launch ranger.
					- we can anyway do ctrl+s+e from vim if we want current file
				- Actually it would be cool because we have all the bindings here
				- we'll only define a set of extensions that we want to offload to rifle? 

		- (RANGER) - system-wide
			- ctrl+g - WORKING
		- (RANGER) - all in cwd
			- ctrl+f - WORKING
		- (TERMINAL) all in cwd starting from nearest git root
			- fzfg
				- if not found, use cwd
		- (TERMINAL) - system-wide
			- fzfs
		- (TERMINAL) all in cwd
			- fzfd
	- common points
		- all ignore .git files
			- ag provides candidates?

- drivers for corsair

- sxiv
	- a binding to edit in gimp?
	- fix fullscreen?

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

- search
	- modes
		- (VIM) instant-startup git-ls-files selected-workspace-wide
			- ctrl+p - WORKING
		- (VIM) all in cwd starting from nearest git root
			- ctrl+shift+p - WORKING
		- (VIM) history
			- ctrl+e - WORKING
		- (VIM) new files/documents
			- just do ctrl+n and then search? - WORKING
				- then press c+s+p - WORKING
		- (VIM) system-wide 
			- should match exactly as there's so many files
			- don't use gitignores for accuracy
			- alt+p - WORKING

- look into zsh plugins

- fix rofi and caps
	- caps lock might have been not bound accidentally? like mouse sometimes malfunctions
	- actually that rofi position is better given that vim displays matches at the bottom as well 

 Don't freeze editor on Ctrl+S
 Looks like we no longer need it though
 stty -ixon

function reb() {
	git fetch upstream
	git checkout master
	git rebase upstream/master
}

