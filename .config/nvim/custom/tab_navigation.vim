
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

nmap <silent> <C-j> :tabprevious<CR>
nmap <silent> <C-k> :tabnext<CR>
nmap <silent> <C-n> :DuplicateTabpane<CR>

" So that we can switch tabs at any time
imap <silent> <C-j> <ESC>:tabprevious<CR>
imap <silent> <C-k> <ESC>:tabnext<CR>

" Allow for switching tabs even while in terminal
tmap <C-h> <Esc><C-h>
tmap <C-j> <Esc><C-j>

" Also prevents the editor from being closed when the last tab closes
nmap <silent> <C-w> :close<CR>:GitGutter<CR>
imap <silent> <C-w> <ESC>:close<CR>

"nmap <silent> <S-j> :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
"nmap <silent> <S-k> :execute 'silent! tabmove ' . (tabpagenr()+1)<CR>
