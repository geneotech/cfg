---
title: System ToDo
hide_sidebar: true
permalink: todo
summary: What needs to be done on the system. 
---

- Proper recording facility
	- Recording screen regions is fucked up because of sound encoding issues
	- Cursor is being shown in screenshots which is annoying as fuck
	- region select is fucked up too

- sxiv: copy to clipboard image or path

- We should really consider dropping the nvim terminal altogether
	- but  then we can't use scrollback content properly
		- Maybe there's an option to open scrollback buffer in vim
	- but then fzf's history search corrupts the scrollback

- Alacritty tabs should reflect the cwd instead of just "Alacritty"
	- This works automatically with Alacritty on its own

- more comprehensive open_with for ranger

- dmenu for important directories

- introduce shift+esc for in-line normal mode in terminal

- Fix fzf hacks (alt+c and ctrl+t) for neovim terminal

- Write scripts to facilitate switching pulseaudio on and off

- Some prettifier for C++ errors? especially for formatting the template names

- fix bindings for alacritty to resemble our vim-likes
	- we won't use it as the terminal but other programs will use alacritty directly
	- a different, non-vim config for alacritty would be the best
		- then ranger and cmus and alike could simply use them
					
- refactor i3/config
- make ranger use trash
- drivers for corsair

## Disregarded

- properly reload images on applying waifu2x in sxiv

- ranger binding for copying current path?
- remember that if you want to configure fzf for terminal, nvim sets its own global fzf command variables
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

- Fix volume tweaking by putting a mutex. That is the probable cause
	- Or just wait each time until no alsa processes are found?
		- Is this reliable? Two instances might still fire at the same time.
		- File locks will be better.

- really something for that screen recording?
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

- sxiv
	- a binding to edit in gimp?
	- fix fullscreen?

- might be good to ditch rofi because it doesnt use bindings properly
	- it will be OKAY though if we fix those bindings!
		- pretty much nothing wrong with it other than that
		- then we can still properly use it 
	- so just fix bindings for rofi

