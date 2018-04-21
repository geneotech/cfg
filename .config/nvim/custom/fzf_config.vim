let $FZF_DEFAULT_OPTS='--nth=-1 --delimiter=/'
let $FZF_DEFAULT_COMMAND = 'ag --hidden -U -g ""'

" So that we also search through hidden files

function! s:find_git_root()
  return system('cd ' . expand("%:h") . '; git rev-parse --show-toplevel 2> /dev/null')[:-2]
endfunction

let g:fzf_action = {
  \ 'enter': 'tab drop',
  \ 'ctrl-s': 'vsplit',
  \ 'ctrl-i': 'CopyIncludePath',
  \ 'ctrl-c': 'CopyPath' }

let g:fzf_layout = { 'down': '~24%' }

" Make ESC always quit the fzf prompt and not just enter normal mode
autocmd! FileType fzf tnoremap <buffer> <Esc> <c-q>

command! ProjectFiles execute 'Files' s:find_git_root()

" Our global version of file searching

let g:ctrlp_global_command = 'tabnew'

function! CtrlpGlobal()
	" Looks like rofi is faster for exact matching,
	" and we really want exact matching for so many files
	
	let newloc = system("echo $(ag --hidden -U -g '' $(cat ~/.config/i3/find_all_locations) 2> /dev/null | rofi -hide-scrollbar -dmenu -i -p 'ag')")

	if strlen(newloc) > 1 
		execute (g:ctrlp_global_command . " " . newloc)
	endif
endfunction

" F26 is bound to Ctrl+Shift+P in Alacritty
nnoremap <silent> <F26> :ProjectFiles<CR>
" F27 is bound to Win+P in Alacritty
nnoremap <silent> <F27> :call CtrlpGlobal()<CR>
nnoremap <silent> <C-t> :Tags<CR>
nnoremap <silent> <C-p> :GFiles<CR>
nnoremap <silent> <C-e> :History<CR>
nnoremap <silent> <M-p> :execute ("Files " . expand("%:h"))<CR>

" facilitate the above in insert mode as well
imap <c-p> <ESC><c-p>
imap <M-p> <ESC><M-p>
imap <F27> <ESC><F27>
imap <F28> <ESC><F28>
imap <C-t> <ESC><C-t>
imap <C-p> <ESC><C-p>

nnoremap \a :Ag<CR>
