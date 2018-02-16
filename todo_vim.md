---
title: Vim ToDo
hide_sidebar: true
permalink: todo
summary: What needs to be done for vim.
---

- consider a script that launches multiple vims with multiple workspaces at once
	- it just won't work
		- anyway it originated from an idea to have a separate workspace for new files but that's just honestly stupid
	- will have to set unique title for each
		- we don't care anyway for window titles except when switching focus after build
- c+n should open a new buffer in some predefined folder
	- c+s+n just fzf with all new files in that foder
- write a script that transform gdb's stack trace to quickfix format
- better scripts for browsing past versions of repos?
 
## Done

- let us use neovim's terminal
	- make it so that it has different title
		- maybe use a different vimrc?
	- fix history arrows
	- fix scrollback and add macro for clearing via scrollback=0?
	- fix colors (maybe zsh plugins will do the trick?)

## Maybe done

- test out the vimagit
- maybe fix some bindings in ex mode so that we can easily navigate with ctrl+arrows?
- remember most problems with alacritty will be gone once neovim terminal used
	- fix suggestions with tab cause it works just like it wants
		- especially for some long names for downloads
- always use zz whenever navigating through anything?
	- except N, n, /, ? etc
If we're playing with neovim terminal, set scrollback=1 clears scrollback

