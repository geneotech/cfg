---
title: System ToDo
hide_sidebar: true
permalink: todo
summary: What needs to be done on the system. 
---

- really something for that screen recording?
- refactor i3/config
- make ranger use trash
- drivers for corsair

- remember that if you want to configure fzf for terminal, nvim sets its own global fzf command variables

- sxiv
	- a binding to edit in gimp?
	- fix fullscreen?

## Disregarded

- ranger - some history option?
- use sxiv bash script so we have more customization opts

plan carefully the system's bash scripts behaviour for building, running etc 
	- with bullet points!
	- introduce convenient single-file cpp build
		- (perhaps should work on f5/f6/f7 or just s+f7?)
		- should run a command like gdb sth sth

- consider having some rcs in ramfs?

- primary facilities
	- NEOVIM (short: VIM)
		- TEXT EDITING
		- NAVIGATION
			- only through projects/cwds
			- open non-text files through rifle
		- FILESYSTEM OPS
			- only for single files (e.g. current)
			- deletion, rename, new
	- RANGER (low priority)
		- NAVIGATION
			- project overall exploration
			- light-hearted file exploration
		- FILESYSTEM OPS
			- only bulk operations
	- NEOVIM TERMINAL
		- package installation/uninstallation
		- various maintenance
		- very precise filesystem ops
		- sudo invocation

- search modes
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
## Done

- fix directory view in sxiv and make it show sizes?

- make ranger open zsh instead of dash on shift+S

- update activity-watch
- fix bindings for copying paths?
	- works though
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

