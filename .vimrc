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
Plugin 'vim-scripts/Conque-GDB'
Plugin 'ludovicchabant/vim-gutentags'
Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'francoiscabrol/ranger.vim'
Plugin 'wojtekmach/vim-rename'

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

endif " has("autocmd")

""""""""" I/O fixes

set clipboard=unnamedplus
set backupdir=/tmp
set undodir=/tmp
set swapfile
set dir=/tmp

set nobackup
set noswapfile
set noundofile


"""""""""" Formatting

autocmd FileType * set fo=
autocmd FileType * setlocal nocindent
autocmd FileType * setlocal indentkeys+=;,(,)

" Don't complete brackets for me (don't know why does this option has this name)
set noshowmatch

set noautoindent 
set nosmartindent

set nofixendofline

"""""""""" Searching

" When searching try to be smart about cases
set smartcase
set ignorecase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

" For regular expressions turn magic on
set magic

"""""""""" Viewing

" disable status line
set laststatus=0

" disable folding
set nofoldenable

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
let g:grepper.tools = ['git', 'grep']
let g:grepper.stop = 300

let g:grepper.operator.dir = 'repo'
let g:grepper.operator.highlight = 1
let g:grepper.operator.tools = ['git']
let g:grepper.operator.stop = 300

""""""""""  General bindings
nmap <S-e> :Ranger<CR>
cmap w!! w !sudo tee %

" General keybindings
nmap <Space><Del> :call delete(expand('%')) <bar> bdelete!
nmap <Space>r :call feedkeys(":Rename " . expand('%@'))<CR>
nmap <Space>o :on<CR>

nmap <Space>s :source $MYVIMRC<CR>
nmap <Space>e :e /tmp/last_error.txt<CR>
nmap <Space>v :e ~/cfg/.vimrc<CR>
nmap <Space>w :set list!<CR>

nmap <Return>w ciw<C-r>0<ESC>
nmap <Return>W ciW<C-r>0<ESC>
nmap <Return>s S<C-r>0<ESC>

map <F2> :e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR>

" ConqueGdb settings and keybindings
runtime plugin/conque_gdb.vim

let g:ConqueTerm_ReadUnfocused = 1
let g:ConqueTerm_Color = 1
let g:ConqueTerm_InsertOnEnter = 1
let g:ConqueTerm_CloseOnEnd = 1
let g:ConqueTerm_CWInsert = 0
"let g:ConqueTerm_UnfocusedUpdateTime = 0
"let g:ConqueTerm_FocusedUpdateTime = 0

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
nmap <silent> <S-F5> :execute 'ConqueGdbCommand kill' <bar> only<CR>
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

nmap <silent> <M-h> :winc h<CR>
nmap <silent> <M-j> :winc j<CR>
nmap <silent> <M-k> :winc k<CR>
nmap <silent> <M-l> :winc l<CR>

imap <silent> <M-h> <ESC>:winc h<CR>
imap <silent> <M-j> <ESC>:winc j<CR>
imap <silent> <M-k> <ESC>:winc k<CR>
imap <silent> <M-l> <ESC>:winc l<CR>

" Also prevents the editor from being closed when the last tab closes
nmap <silent> <c-w> :close<CR>
imap <silent> <c-w> <ESC>:close<CR>

nmap <silent> <c-x> :x<CR>

nmap <silent> <C-j> :tabprevious<CR>
nmap <silent> <C-k> :tabnext<CR>
nmap <silent> <C-n> :tabnew<CR>
" So that we can switch tabs at any time
imap <silent> <C-j> <ESC>:tabprevious<CR>
imap <silent> <C-k> <ESC>:tabnext<CR>
imap <silent> <C-n> <ESC>:tabnew<CR>

nmap <silent> <S-j> :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
nmap <silent> <S-k> :execute 'silent! tabmove ' . (tabpagenr()+1)<CR>

""" Replacing """
nmap <C-h> :cdo s///g <bar> update<left><left><left><left><left><left><left><left><left><left><left>

""" Searching current file """

autocmd VimEnter * nmap <Leader>f :execute "Grepper -buffer -tool grep -noprompt -query ''"<left><left>

" General

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
map <C-l> :execute "silent Glog -- %" <bar> redraw!<CR> 
map <silent> <C-s> :execute "Gstatus"<CR>
map <silent> <C-d> :execute "Gdiff"<CR>
" We will anyway do it from the status window
" map <C-C> :execute "Gcommit"<CR>
nmap <silent> <C-a> GVgg
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
let g:gutentags_cache_dir='/tmp'

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

" Colors for diff in general
highlight DiffAdd    ctermbg=16 guibg=#001c09 guifg=NONE
highlight DiffDelete ctermbg=17 guibg=#1c0000 guifg=NONE
highlight DiffChange ctermbg=17 guibg=#101010 guifg=NONE  
" Changed text inside the changed line
highlight DiffText   ctermbg=88 guibg=#323210 guifg=NONE  

" Colors for diff markers on the left column
highlight GitGutterAdd guifg=darkgreen 
highlight GitGutterChange guifg=darkyellow 
highlight GitGutterChangeDelete guifg=darkyellow 
highlight GitGutterDelete guifg=darkred

" Wrap lines in diff mode by default
autocmd FilterWritePre * if &diff | setlocal wrap< | endif
autocmd FilterWritePre * if &diff | highlight DiffChange guibg=#001538 | endif

set listchars=eol:⏎,tab:>-,trail:␠,nbsp:⎵
highlight SpecialKey guifg=#505050
highlight NonText guifg=#505050

" For my gf
set path+=src/**

" Make tab names show only the filename
" Thanks to
" https://github.com/mkitt/tabline.vim

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

function! GenericIndent(lnum)
  if !exists('b:indent_ignore')
    " this is safe, since we skip blank lines anyway
    let b:indent_ignore='^$'
  endif
  " Find a non-blank line above the current line.
  let lnum = prevnonblank(a:lnum - 1)
  while lnum > 0 && getline(lnum) =~ b:indent_ignore
    let lnum = prevnonblank(lnum - 1)
  endwhile
  if lnum == 0
    return 0
  endif
  let curline = getline(a:lnum)
  let prevline = getline(lnum)
  let indent = indent(lnum)
  if ( prevline =~ '[({]\s*$')
    let indent = indent + &sw
  endif
  if (curline =~ '^\s*[)}]*[;,]\{,1}\s*$')
    let indent = indent - &sw
  endif
  return indent
endfunction

set indentexpr=GenericIndent(v:lnum)

nnoremap p p=`]
nnoremap P P=`]
