""""""""" One-shot plugin configuration (longer configs go to separate files)

nnoremap <Space>r :call feedkeys(":Rename " . expand('%@'))<CR>
nnoremap <silent> <Space>h :execute "ViewDocHelp " . expand("<cword>")<CR>

" F34 is bound to ctrl+shift+e in alacritty
nnoremap <F34> :Ranger<CR>

let g:bufferize_command='tabnew'

" Gutentags settings
let g:gutentags_cache_dir='/tmp'
let g:gutentags_ctags_extra_args=['-nu']

nnoremap <M-]> :tn<CR>
nnoremap <M-[> :tp<CR>

" Keep the yank highlight infinite
let g:highlightedyank_highlight_duration = -1

" Ease of access for bufferizing last echomsgs

nnoremap <silent> <F1> :Bufferize messages<CR>
vnoremap <silent> <F1> :Bufferize messages<CR>
imap <silent> <F1> <ESC><F1>

nnoremap <silent> { :SidewaysLeft<CR>
nnoremap <silent> } :SidewaysRight<CR>

omap aa <Plug>SidewaysArgumentTextobjA
xmap aa <Plug>SidewaysArgumentTextobjA
omap ia <Plug>SidewaysArgumentTextobjI
xmap ia <Plug>SidewaysArgumentTextobjI
