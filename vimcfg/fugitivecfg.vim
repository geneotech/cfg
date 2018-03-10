" vim-fugitive bindings 

" Browse commits with the current file
map <S-l> :execute "silent Glog -- %" <bar> redraw!<CR> 
" Browse commits in the whole repository
map <C-l> :execute "silent Glog --" <bar> redraw!<CR> 

map <silent> <C-s> :Gstatus <bar> wincmd T<CR>

map <silent> <C-d> :execute "Gdiff"<CR>
" We will anyway do it from the status window
" map <C-C> :execute "Gcommit"<CR>
