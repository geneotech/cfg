---
title: Vim ToDo
hide_sidebar: true
permalink: todo
summary: What needs to be done for vim.
---

- make tags jump to column

- better scripts for browsing past versions of repos?
	- what is done:
		- gallexisted + grestore
	- past diffs could be good
		- wrappers for Gdiff --cached and Gdiff HEAD?

- DEBUGGING SUPPORT
	- leave it for later once we actually have a bug to test on
	- GDB
		- https://reverseengineering.stackexchange.com/questions/1392/decent-gui-for-gdb 
		- check out "vimgdb" 
			- also check if lldb isn't more accurate here
			- if lldb is better we'll need to rewrite the perl script
	- LLDB
		- will be our weapon of choice due to clang super fast compilation times
		- check out VSC + LLDB
		- if not, check out native debug: https://marketplace.visualstudio.com/items?itemName=webfreak.debug

- rename untitled files with first line of content
	- unt -> untitled

## Disregarded

- improve speed of easymotion
	- will be damn hard, we've tried though

- make n ALWAYS go forward, even when using #
	- will be hard as well


## Maybe done

- make those regexps damn consistent across ctrl+f and /?
	- we'll need to use \v in vim to create queries for mass renaming
	- then once it's created, just press q/ and copy it
	- then paste it into ctrl+f
	- and then construct normal replace pattern
	- escaping has been fixed somewhat now that vim_query uses \v at the beginning
		- so all will have special meaning in vim query, as in ctrl+f

- fix escaping for searches
	- i think it works though for most cases

- test out the vimagit
- maybe fix some bindings in ex mode so that we can easily navigate with ctrl+arrows?
- remember most problems with alacritty will be gone once neovim terminal used
	- fix suggestions with tab cause it works just like it wants
		- especially for some long names for downloads
- always use zz whenever navigating through anything?
	- except N, n, /, ? etc
If we're playing with neovim terminal, set scrollback=1 clears scrollback

## Done

- make sideways work with <> cause we will use it surely

- fix that reverse command search to not suck
	- What?

- check if cores produced by clang builds can be read by gdb
	- DONE - they can.

- fix gitgutter on write
- fix replacing offset by one character
 
- write a script that transforms gdb's stack trace to quickfix format
- c+n should open a new buffer in some predefined folder
- let us use neovim's terminal
	- make it so that it has different title
		- maybe use a different vimrc?
	- fix history arrows
	- fix scrollback and add macro for clearing via scrollback=0?
	- fix colors (maybe zsh plugins will do the trick?)

- consider a script that launches multiple vims with multiple workspaces at once
	- it just won't work
		- anyway it originated from an idea to have a separate workspace for new files but that's just honestly stupid
	- will have to set unique title for each
		- we don't care anyway for window titles except when switching focus after build

- install https://github.com/powerman/vim-plugin-viewdoc

- fix that escaping in grepper, perhaps use "
	- it works. it's just that word anchors are different here, not \< and \>

- Ctrl+Shift+C should copy exact path quoted (e.g. for cmake)
- install something for parenthesizing 
- install something for commenting and uncommenting
 
## Nice schemes

https://github.com/nightsense/office
Plugin 'acarapetis/vim-colors-github'
