function! WrapCommand(direction, prefix)
    if a:direction == "up"
        try
            execute a:prefix . "previous"
        catch /^Vim\%((\a\+)\)\=:E553/
            execute a:prefix . "first"
        catch /^Vim\%((\a\+)\)\=:E\%(776\|42\):/
        endtry
    elseif a:direction == "down"
        try
            execute a:prefix . "next"
        catch /^Vim\%((\a\+)\)\=:E553/
            execute a:prefix . "last"
        catch /^Vim\%((\a\+)\)\=:E\%(776\|42\):/
        endtry
    endif

	normal zz
endfunction

" F28 = Ctrl + ;
" F29 = Ctrl + '
nmap <silent> <F29> :call WrapCommand('up', 'c')<CR>
nmap <silent> <F28> :call WrapCommand('down', 'c')<CR>

" F21 = Ctrl + ,
" F22 = Ctrl + .
nmap <silent> <F21> :call WrapCommand('up', 'l')<CR>
nmap <silent> <F22> :call WrapCommand('down', 'l')<CR>
