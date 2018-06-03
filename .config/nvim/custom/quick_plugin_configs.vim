""""""""" One-shot plugin configuration (longer configs go to separate files)

" Rename plugin
nnoremap <Space>r :call feedkeys(":Rename " . expand('%@'))<CR>

" ViewDoc plugin for better manpages
nnoremap <silent> <Space>h :execute "ViewDocHelp " . expand("<cword>")<CR>

" Gutentags settings
let g:gutentags_cache_dir='/tmp'
let g:gutentags_ctags_extra_args=['-nu']

" highlightedyank settings
" Keep the yank highlight infinite
let g:highlightedyank_highlight_duration = -1

" Bufferize settings
let g:bufferize_command='tabnew'

nnoremap <silent> <F1> :Bufferize messages<CR>
vnoremap <silent> <F1> :Bufferize messages<CR>
imap <silent> <F1> <ESC><F1>

" Sideways settings
nnoremap <silent> { :SidewaysLeft<CR>
nnoremap <silent> } :SidewaysRight<CR>

omap aa <Plug>SidewaysArgumentTextobjA
xmap aa <Plug>SidewaysArgumentTextobjA
omap ia <Plug>SidewaysArgumentTextobjI
xmap ia <Plug>SidewaysArgumentTextobjI
