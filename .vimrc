set nocompatible              " be iMproved, required
filetype off                  " required

set rtp+=/home/pbc/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-unimpaired'
Plugin 'mhinz/vim-grepper'
Plugin 'airblade/vim-gitgutter'
Plugin 'bluz71/vim-moonfly-colors'
Plugin 'gryftir/gryffin'
Plugin 'vim-scripts/Conque-GDB'
Plugin 'ludovicchabant/vim-gutentags'
Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'francoiscabrol/ranger.vim'
Plugin 'jiangmiao/auto-pairs'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" Get the defaults that most users want.
source $VIMRUNTIME/defaults.vim

if &t_Co > 2 || has("gui_running")
  " Switch on highlighting the last used search pattern.
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

set autoindent 
set smartindent
set laststatus=0
set ignorecase
set clipboard=unnamedplus
set backupdir=/tmp
set undodir=/tmp
set swapfile
set dir=/tmp

set nobackup
set noswapfile
set noundofile

" disable folding
set nofoldenable

" When searching try to be smart about cases
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

" For regular expressions turn magic on
set magic

" Don't complete brackets for me (don't know why does this option has this name)
set noshowmatch

" How many tenths of a second to blink when matching brackets
set mat=2

set tabstop=4

" Don't know why but somehow this makes indentation work normally
" (puts just one tab instead of two)
set shiftwidth=4

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
" Remember info about open buffers on close
set viminfo^=%

" Let the window's title be the filename
set title

" Let us see relative line numbers by default
set number relativenumber
" set number

" Let us only see the filename
set titlestring="VIM"
nmap <S-e> :Ranger<CR>

" If the current buffer has never been saved, it will have no name,
" call the file browser to save it, otherwise just save it.
"command -nargs=0 -bar Update if &modified 
                           "\|    if empty(bufname('%'))
                           "\|        browse confirm write
                           "\|    else
                           "\|        confirm write
                           "\|    endif
                           "\|endif
"nnoremap <silent> <C-S> :<C-u>Update<CR>
"inoremap <c-s> <Esc>:Update<CR>

function! s:get_visual_selection()
    " Why is this not a built-in Vim script function?!
    let [line_start, column_start] = getpos("'<")[1:2]
    let [line_end, column_end] = getpos("'>")[1:2]
    let lines = getline(line_start, line_end)
    if len(lines) == 0
        return ''
    endif
    let lines[-1] = lines[-1][: column_end - (&selection == 'inclusive' ? 1 : 2)]
    let lines[0] = lines[0][column_start - 1:]
    return join(lines, "\n")
endfunction

" Automatically opens the quickfix window after common commands
" and redraws the window to avoid glitches
"augroup myvimrc
    "autocmd!
    "autocmd QuickFixCmdPost [^l]* cwindow | redraw!
    "autocmd QuickFixCmdPost l* lwindow | redraw!
"augroup END

runtime plugin/grepper.vim
let g:grepper.dir = 'repo'
let g:grepper.highlight = 1
let g:grepper.tools = ['git']
let g:grepper.stop = 300

let g:grepper.operator.dir = 'repo'
let g:grepper.operator.highlight = 1
let g:grepper.operator.tools = ['git']
let g:grepper.operator.stop = 300

" General bindings
cmap w!! w !sudo tee %

" General keybindings
nmap <Space>o :on<CR>

nmap <Space>s :source $MYVIMRC<CR>
nmap <Space>v :e ~/cfg/.vimrc<CR>

" ConqueGdb settings and keybindings
runtime plugin/conque_gdb.vim

let g:ConqueTerm_ReadUnfocused = 1
let g:ConqueTerm_Color = 1
let g:ConqueTerm_InsertOnEnter = 1
let g:ConqueTerm_CloseOnEnd = 1
"let g:ConqueTerm_CWInsert = 1

" So that it does not preffix 'server' to our commands
let g:ConqueGdb_SaveHistory = 1

" Open ConqueGdb window
nmap <silent> <space>g :ConqueGdb <bar> :star <CR>

" Avoid having to go to conque window for confirmations
nnoremap <silent> <space>y :ConqueGdbCommand y<CR>
nnoremap <silent> <space>n :ConqueGdbCommand n<CR>

" We could set those through g:ConqueGdb_* variables,
" but ConqueTerm interferes if there are no mappings set for the F keys
" at the time of its startup.

" We had to comment out one line in plugin/conque_term.vim for F8 to work,
" unfortunately
nmap <silent> <S-F5> :ConqueGdbCommand kill<CR>
nmap <silent> <F8> :ConqueGdbCommand continue<CR>
nmap <silent> <F9> <Leader>b 
nmap <silent> <F10> :ConqueGdbCommand next<CR>
nmap <silent> <F11> :ConqueGdbCommand step<CR>
nmap <silent> <S-F11> :ConqueGdbCommand finish<CR>

nmap <silent> <space>t <Leader>t 
nmap <silent> <space>p <Leader>p 
nmap <silent> <space>u :ConqueGdbCommand up<CR> 
nmap <silent> <space>d :ConqueGdbCommand down<CR> 

" These four executions so that the alt works. Tested under Alacritty.

execute "set <M-h>=\eh"
execute "set <M-j>=\ej"
execute "set <M-k>=\ek"
execute "set <M-l>=\el"

" Easily move between splits

nmap <M-h> :winc h<CR>
nmap <M-j> :winc j<CR>
nmap <M-k> :winc k<CR>
nmap <M-l> :winc l<CR>

imap <M-h> <ESC>:winc h<CR>
imap <M-j> <ESC>:winc j<CR>
imap <M-k> <ESC>:winc k<CR>
imap <M-l> <ESC>:winc l<CR>

" Also prevents the editor from being closed when the last tab closes
nmap <c-w> :close<CR>

nmap <c-x> :x<CR>

nmap <C-j> :tabprevious<CR>
nmap <C-k> :tabnext<CR>
nmap <C-n> :tabnew<CR>
" So that we can switch tabs at any time
imap <C-j> <ESC>:tabprevious<CR>
imap <C-k> <ESC>:tabnext<CR>
imap <C-n> <ESC>:tabnew<CR>

nmap <silent> <S-j> :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
nmap <silent> <S-k> :execute 'silent! tabmove ' . (tabpagenr()+1)<CR>

""" Replacing """
nmap <C-h> :cdo s///g <bar> update<left><left><left><left><left><left><left><left><left><left><left>

""" Searching current file """

" General
nmap <S-f> :execute "Grepper -buffer -tool grep -noprompt -query ''"<left><left>

" Search word under cursor
nmap <F3> :execute "Grepper -buffer -tool grep -cword -noprompt"<CR>

""" Searching whole project """

" General
nmap <C-f> :execute "Grepper -tool git -noprompt -query ''"<left><left>

" Search word under cursor
nmap <F4> :execute "Grepper -tool git -cword -noprompt"<CR>

" Search selection
vmap <F4>   <plug>(GrepperOperator)

" For motions
nmap gs  <plug>(GrepperOperator)



" vim-fugitive bindings 
map <C-l> :execute "silent Glog"<CR> 
map <C-s> :execute "Gstatus"<CR>
map <C-d> :execute "Gdiff"<CR>
" We will anyway do it from the status window
" map <C-C> :execute "Gcommit"<CR>
nmap <C-a> GVgg
nmap U :execute "GitGutterRevertHunk"<CR>

runtime plugin/gitgutter.vim
execute "GitGutterLineHighlightsEnable"
"execute "GitGutterSignsDisable"

" Prevent live updating of git gutter, it annoys me while writing
set updatetime=999999999

execute "set t_8f=\e[38;2;%lu;%lu;%lum"
execute "set t_8b=\e[48;2;%lu;%lu;%lum"

runtime plugin/gutentags.vim
" Gutentags settings
let g:gutentags_cache_dir='/tmp/tagfiles'

" Color fixes
set termguicolors

colorscheme moonfly
highlight LineNr ctermbg=black guibg=#080808
highlight CursorLineNR guibg=#080808 guifg=NONE
highlight TabLineFill guifg=#080808 guibg=#080807
highlight TabLineSel guibg=#202020 guifg=white
highlight TabLine guibg=#080808 

"highlight LineNr ctermbg=black guibg=black
"highlight CursorLineNR guibg=black guifg=NONE
"highlight Normal guibg=black
"colorscheme gryffin

highlight DiffAdd    ctermbg=16 guibg=#001c09 guifg=NONE
highlight DiffDelete ctermbg=17 guibg=#1c0000 guifg=NONE
highlight DiffChange ctermbg=17 guibg=#101010 guifg=NONE  
highlight DiffText   ctermbg=88 guibg=#050505 guifg=NONE  

highlight GitGutterAdd guifg=darkgreen 
highlight GitGutterChange guifg=darkyellow 
highlight GitGutterChangeDelete guifg=darkyellow 
highlight GitGutterDelete guifg=darkred

" For my gf
set path+=src/**

" Thanks to
" https://github.com/mkitt/tabline.vim
if (exists("g:loaded_tabline_vim") && g:loaded_tabline_vim) || &cp
  finish
endif
let g:loaded_tabline_vim = 1

function! Tabline()
  let s = ''
  for i in range(tabpagenr('$'))
    let tab = i + 1
    let winnr = tabpagewinnr(tab)
    let buflist = tabpagebuflist(tab)
    let bufnr = buflist[winnr - 1]
    let bufname = bufname(bufnr)
    let bufmodified = getbufvar(bufnr, "&mod")

    let s .= '%' . tab . 'T'
    let s .= (tab == tabpagenr() ? '%#TabLineSel#' : '%#TabLine#')
    let s .= (bufname != '' ? ' ' . fnamemodify(bufname, ':t') . ' ' : '[No Name] ')

    if bufmodified
      let s .= '[+] '
    endif
  endfor

  let s .= '%#TabLineFill#'
  if (exists("g:tablineclosebutton"))
    let s .= '%=%999XX'
  endif
  return s
endfunction
set tabline=%!Tabline()
