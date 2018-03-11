""""""""" One-shot plugin configuration (longer configs go to separate files)

nmap <Space>r :call feedkeys(":Rename " . expand('%@'))<CR>
nmap <Space>h :execute "ViewDocHelp " . expand("<cword>")<CR>

" F34 is bound to ctrl+shift+e in alacritty
nmap <F34> :Ranger<CR>

let g:bufferize_command='tabnew'

" Gutentags settings
runtime plugin/gutentags.vim
let g:gutentags_cache_dir='/tmp'

" Keep the yank highlight infinite
let g:highlightedyank_highlight_duration = -1

" Ease of access for bufferizing last echomsgs

nnoremap <silent> <F1> :Bufferize messages<CR>
vnoremap <silent> <F1> :Bufferize messages<CR>
inoremap <silent> <F1> <ESC>:Bufferize messages<CR>

nnoremap <silent> { :SidewaysLeft<CR>
nnoremap <silent> } :SidewaysRight<CR>
