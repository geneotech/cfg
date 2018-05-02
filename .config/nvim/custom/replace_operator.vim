" Our custom replacement script

fu! s:SID()
    return matchstr(expand('<sfile>'),'<SNR>\zs\d\+\ze_SID$')
endfu

function! s:setOpfunc (name) 
    exe 'set opfunc=<SNR>'.s:SID().'_'.a:name.'Opfunc'
    return 'g@' 
endfu

nnoremap <expr> <Plug>ReplaceOperator   <SID>setOpfunc('replace')
vnoremap <Plug>ReplaceOperator  :<C-u>call <SID>replaceOpfunc(visualmode())<CR>

fu! s:replaceOpfunc (motion) 
    let type     = get(a:, 'motion')
    call s:replace(type)
endfu

function! s:replace (type) 
    let type = get(a:, 'type')

    if     type==#'char' | let expr = "`[v`]"
    elseif type==#'line' | let expr = "'[v']"
    elseif type==#'v'    | let expr = "`<v`>"
    elseif type==#'V'    | let expr = "'<V'>"
    else | return | end

    exe 'normal! '.expr
    exe "normal! \"_c\<C-r>+\<ESC>"
endfu

nmap <Return> <Plug>ReplaceOperator
vmap <Return> <Plug>ReplaceOperator

" Shortcuts for frequently used cases
nmap <Return>w "_ciw<C-r>+<ESC>
nmap <Return>W "_ciW<C-r>+<ESC>
nmap <Return>b "_cib<C-r>+<ESC>
nmap <Return>B "_ciB<C-r>+<ESC>
nmap <Return>< "_ci<<C-r>+<ESC>
nmap <Return>ia "_ci<<C-r>+<ESC>
nmap <Return>aa "_ca<<C-r>+<ESC>
nmap <Return>" _ci"<C-r>+<ESC>
nmap <Return>' "_ci'<C-r>+<ESC>
nmap <Return>s "_ddP
