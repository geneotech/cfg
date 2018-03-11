""""""""" One-shot plugin configuration (longer configs go to separate files)

nmap <Space>r :call feedkeys(":Rename " . expand('%@'))<CR>
nmap <Space>h :execute "ViewDocHelp " . expand("<cword>")<CR>

" F34 is bound to ctrl+shift+e in alacritty
nmap <F34> :Ranger<CR>

" Gutentags settings
runtime plugin/gutentags.vim
let g:gutentags_cache_dir='/tmp'

" Keep the yank highlight infinite
let g:highlightedyank_highlight_duration = -1

" Ease of access for bufferizing last echomsgs

nmap <silent> <F1> :Bufferize messages<CR>
vmap <silent> <F1> :Bufferize messages<CR>
imap <silent> <F1> <ESC>:Bufferize messages<CR>
