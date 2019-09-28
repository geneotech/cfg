""""""""" Plugin configuration
let g:no_viewdoc_maps = 1

runtime plugin/grepper.vim
let g:grepper.dir = 'repo'
let g:grepper.highlight = 1
let g:grepper.tools = ['ag']
let g:grepper.ag.grepprg = 'ag --hidden --vimgrep'
let g:grepper.ag.escape = ''
let g:grepper.stop = 2500

let g:grepper.operator.dir = 'repo'
let g:grepper.operator.highlight = 1
let g:grepper.operator.tools = ['ag']
let g:grepper.operator.ag.grepprg = 'ag --hidden --vimgrep'
let g:grepper.operator.ag.escape = ''
let g:grepper.operator.stop = 2500

let g:grepper.switch = 0

""" Searching current file """

autocmd VimEnter * nmap <Leader>f :Grepper -buffer -tool ag -noprompt -query ''<left>

" Search word under cursor
nmap <F3> :execute "Grepper -buffer -tool ag -cword -noprompt"<CR>
vmap <F3> "hy:execute "Grepper -buffer -tool ag -noprompt -query " . shellescape(escape('<C-r>h', '\^$.*+?()[]{}<bar>'))<CR>

""" Searching whole project """

" General
nmap <C-f> :Grepper -tool ag -noprompt -query ''<left>

" Search word under cursor
nmap <F4> :execute "Grepper -tool ag -cword -noprompt"<CR>

" Search selection
vmap <F4>   <plug>(GrepperOperator)

" For motions
nmap gs  <plug>(GrepperOperator)

function! FindWhereThisFileIsIncluded()
	execute ("Grepper -tool ag -noprompt -query '" . ToCppIncludePath(expand("%:f")) . "'")
endfunc

" Find where the current file is included
" F13 is bound to Ctrl+Shift+I in Alacritty
nmap <silent> <F13> :call FindWhereThisFileIsIncluded()<CR>
