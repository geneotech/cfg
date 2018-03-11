colorscheme moonfly
set termguicolors

let g:terminal_color_0  = '#2e3436'
let g:terminal_color_1  = '#cc0000'
let g:terminal_color_2  = '#4e9a06'
let g:terminal_color_3  = '#c4a000'
let g:terminal_color_4  = '#3465a4'
let g:terminal_color_5  = '#75507b'
let g:terminal_color_6  = '#0b939b'
let g:terminal_color_7  = '#d3d7cf'
let g:terminal_color_8  = '#555753'
let g:terminal_color_9  = '#ef2929'
let g:terminal_color_10 = '#8ae234'
let g:terminal_color_11 = '#fce94f'
let g:terminal_color_12 = '#729fcf'
let g:terminal_color_13 = '#ad7fa8'
let g:terminal_color_14 = '#00f5e9'
let g:terminal_color_15 = '#eeeeec'	

nnoremap I m'I
nnoremap A m'A
nnoremap i m'i
nnoremap o m'i<Return>

tnoremap <Esc> <C-\><C-n>

nnoremap <C-c> m'i<C-c><C-\><C-n><C-o>

" F32 = shift+backspace
nnoremap <F32> :call delete(expand('%')) <bar> bdelete! <bar> terminal<CR>

edit term://zsh

" So the build errors don't switch to the terminal window
set notitle
"hi Search ctermfg=black ctermbg=yellow
startinsert
