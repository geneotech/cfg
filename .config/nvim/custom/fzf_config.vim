let g:my_normal_fzf_opts = '--bind=ctrl-j:jump-accept --bind=ctrl-k:jump-accept --bind=alt-k:previous-history --bind=alt-j:next-history'

let g:fzf_only_filename = g:my_normal_fzf_opts . ' --nth=-1 --delimiter=/'
let g:fzf_only_filename_and_last_folder = g:my_normal_fzf_opts . ' --nth=-2,-1 --delimiter=/'

let $FZF_DEFAULT_OPTS=g:fzf_only_filename
let $FZF_DEFAULT_COMMAND = 'ag --hidden -U -g ""'

" So that we also search through hidden files

function! s:find_git_root()
  return system('cd ' . expand("%:h") . '; git rev-parse --show-toplevel 2> /dev/null')[:-2]
endfunction

let g:fzf_action = {
  \ '': 'tab drop',
  \ 'enter': 'tab drop',
  \ 'ctrl-i': 'CopyIncludePath',
  \ 'ctrl-c': 'CopyPath' }

let g:fzf_layout = { 'down': '~24%' }

" Make ESC always quit the fzf prompt and not just enter normal mode
autocmd! FileType fzf tnoremap <buffer> <Esc> <c-q>

command! ProjectFiles execute 'Files' s:find_git_root()

" Our global version of file searching

let g:ctrlp_global_command = 'tab drop'

function! CtrlpGlobal(locations)
	let old_opts = $FZF_DEFAULT_OPTS

	let $FZF_DEFAULT_OPTS = g:my_normal_fzf_opts
	call fzf#run(fzf#wrap('global', {'sink' : g:ctrlp_global_command, 'source' : "ag --hidden -U -g '' $(cat ~/cfg/sh/open/" . a:locations . ") 2> /dev/null "}, 1))
	let $FZF_DEFAULT_OPTS = old_opts
endfunction

function! CtrlpGlobalSsh()
	call CtrlpGlobal("find_all_locations_ssh")
endfunction

" F26 is bound to Ctrl+Shift+P in Alacritty
nnoremap <silent> <F26> :ProjectFiles<CR>
" F27 is bound to Win+P in Alacritty
nnoremap <silent> <F27> :call CtrlpGlobal("find_all_locations")<CR>
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

let g:fzf_history_dir = '~/.local/share/fzf-history'
