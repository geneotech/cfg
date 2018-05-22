
command! -bar DuplicateTabpane
      \ let s:sessionoptions = &sessionoptions |
      \ try |
      \   let &sessionoptions = '' |
      \   let s:file = tempname() |
      \   execute 'mksession ' . s:file |
      \   tabnew |
      \   execute 'source ' . s:file |
      \ finally |
      \   silent call delete(s:file) |
      \   let &sessionoptions = s:sessionoptions |
      \   unlet! s:file s:sessionoptions |
      \ endtry

nnoremap <silent> <C-j> :tabprevious<CR>
nnoremap <silent> <C-k> :tabnext<CR>
nnoremap <silent> <C-n> :DuplicateTabpane<CR>

" Also prevents the editor from being closed when the last tab closes
nnoremap <silent> <C-w> :close<CR>:GitGutter<CR>
" inoremap <silent> <C-w> <ESC>:close<CR>

"nmap <silent> <S-j> :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
"nmap <silent> <S-k> :execute 'silent! tabmove ' . (tabpagenr()+1)<CR>
