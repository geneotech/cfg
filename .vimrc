set nocompatible              " be iMproved, required
filetype off                  " required

set rtp+=/home/pbc/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'mhinz/vim-grepper'
Plugin 'airblade/vim-gitgutter'
Plugin 'bluz71/vim-moonfly-colors'
Plugin 'ludovicchabant/vim-gutentags'
Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'francoiscabrol/ranger.vim'
Plugin 'wojtekmach/vim-rename'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'huawenyu/neogdb.vim'
Plugin 'AndrewRadev/bufferize.vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

if !has('nvim')
	" Get the defaults that most users want.
	source $VIMRUNTIME/defaults.vim
endif

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

""""""""" General behaviour
" always append newline when appending to a register
set cpoptions+=>

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

autocmd FileType cpp setlocal fo=
autocmd FileType cpp setlocal nocindent
autocmd FileType cpp setlocal indentkeys+=;,>,),],/

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

set splitright " For GDB terminal
set listchars=eol:⏎,tab:>-,trail:␠,nbsp:⎵

" disable status line
set laststatus=0

" disable folding
" set nofoldenable

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
let g:grepper.tools = ['ag']
let g:grepper.ag.grepprg = 'ag --hidden --vimgrep'
let g:grepper.stop = 300

let g:grepper.operator.dir = 'repo'
let g:grepper.operator.highlight = 1
let g:grepper.operator.tools = ['ag']
let g:grepper.operator.ag.grepprg = 'ag --hidden --vimgrep'
let g:grepper.operator.stop = 300

""""""""""  General bindings

" wrap :cnext/:cprevious and :lnext/:lprevious
function! WrapCommand(direction, prefix)
    if a:direction == "up"
        try
            execute a:prefix . "previous"
        catch /^Vim\%((\a\+)\)\=:E553/
            execute a:prefix . "last"
        catch /^Vim\%((\a\+)\)\=:E\%(776\|42\):/
        endtry
    elseif a:direction == "down"
        try
            execute a:prefix . "next"
        catch /^Vim\%((\a\+)\)\=:E553/
            execute a:prefix . "first"
        catch /^Vim\%((\a\+)\)\=:E\%(776\|42\):/
        endtry
    endif
endfunction

" <Home> and <End> go up and down the quickfix list and wrap around
nnoremap <silent> [q :call WrapCommand('up', 'c')<CR>
nnoremap <silent> ]q :call WrapCommand('down', 'c')<CR>

" <C-Home> and <C-End> go up and down the location list and wrap around
nnoremap <silent> [l :call WrapCommand('up', 'l')<CR>
nnoremap <silent> ]l :call WrapCommand('down', 'l')<CR>

function! StartDebugging()
	wa
	let gdbcmd = "GdbLocal ConfHyper"
	execute gdbcmd 
endfunction

let g:last_error_path = '/tmp/last_error.txt'
let g:last_error_path_color = '/tmp/last_error_color.txt'

function! OnBuildEvent(job_id, data, event) dict
	if filereadable(g:last_error_path)
		execute "lfile " . g:last_error_path
	else
		echomsg "Build successful."
	endif
endfunction

function! OnDebugBuildEvent(job_id, data, event) dict
	if filereadable(g:last_error_path)
		execute "lfile " . g:last_error_path
	else
		echomsg "Build successful."

		call StartDebugging()
	endif
endfunction

function! SucklessMake(targetname)
	wa

    let callbacks = {
    \ 'on_exit': function('OnBuildEvent')
    \ }

	let jobcmd = "zsh -c 'vim_target " . a:targetname . "'"
	"echomsg jobcmd

    let job1 = jobstart(jobcmd, callbacks)
endfunction

function! SucklessMakeDebug(targetname)
	wa

    let callbacks = {
    \ 'on_exit': function('OnDebugBuildEvent')
    \ }

	let jobcmd = "zsh -c 'vim_target " . a:targetname . "'"
	"echomsg jobcmd

    let job1 = jobstart(jobcmd, callbacks)
endfunction

function! ConfHyper() abort
    " user special config
	let current_wp = system("echo -n $WORKSPACE/")

    let this = {
        \ "Scheme" : 'gdb#SchemeCreate',
        \ "autorun" : 1,
        \ "reconnect" : 1,
        \ "showbreakpoint" : 1,
        \ "showbacktrace" : 0,
        \ "conf_gdb_layout" : ["vsp"],
        \ "conf_gdb_cmd" : ['cd $WORKSPACE; gdb -q -f -cd hypersomnia', current_wp . "build/current/Hypersomnia-Debug"],
        \ "window" : [
        \   {   "name":   "gdbserver",
        \       "status":  0,
        \   },
        \ ],
        \ "state" : {
        \ }
        \ }

    return this
endfunc

" GDB bindings
" F17 is bound to S+F5 in Alacritty
nmap <silent> <F17> :GdbDebugStop<CR>
" F21 is bound to Shift+F9 in Alacritty
nmap <silent> <F21> :GdbClearBreak<CR>
nmap <silent> <F33> :GdbClearBreak<CR>

nmap <silent> <C-U> :GdbFrameUp<CR>
nmap <silent> <C-I> :GdbFrameDown<CR>
nmap <Space>p :call gdb#Send("print " . expand('<cword>'))<CR>

let g:gdb_keymap_continue = '<f8>'
let g:gdb_keymap_next = '<f10>'
let g:gdb_keymap_step = '<f11>'
" F23 is bound to S+F11 in Alacritty
let g:gdb_keymap_finish = '<f23>'
let g:gdb_keymap_toggle_break = '<f9>'
let g:gdb_keymap_toggle_break_all = '<f33>'

" What?
let g:gdb_keymap_until = '<f13>'
let g:gdb_keymap_refresh = '<f12>'

" Build bindings

nmap <silent> <F7> :call SucklessMake("all")<CR>
nmap <silent> <F6> :call SucklessMakeDebug("all")<CR>
nmap <silent> <F5> :call SucklessMake("run")<CR>

imap <silent> <F5> <ESC><F5>
imap <silent> <F6> <ESC><F6>
imap <silent> <F7> <ESC><F7>

nmap <Space>h :execute "help " . expand("<cword>")<CR>

" F25 is bound to Control + Backspace in Alacritty
inoremap <F25> <C-W>

" ctrlp bindings
function! CtrlpCurrentRepo()
let g:ctrlp_working_path_mode = 'r'
execute("CtrlP")
let g:ctrlp_working_path_mode = ''
endfunction

let g:ctrlp_global_command = 'tabnew'

function! CtrlpGlobal()
	let g:ctrlp_user_command = "cd %s && find -L $(cat ~/.config/i3/find_all_locations) -not -iwholename '*.git*' -not -iwholename '*_site*'"
	let g:ctrlp_working_path_mode = ''
	let newloc = system("LOCATION=$(find -L $(cat ~/.config/i3/find_all_locations) -not -iwholename '*.git*' -not -iwholename '*_site*' 2> /dev/null | sed 1d | rofi -hide-scrollbar -dmenu -i -p 'find:'); echo $LOCATION")

	if strlen(newloc) > 1 
		execute (g:ctrlp_global_command . " " . newloc)
	endif

	let g:ctrlp_working_path_mode = ''
	let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
endfunction

" F26 is bound to Ctrl+Shift+P in Alacritty
nmap <silent> <F26> :call CtrlpCurrentRepo()<CR>

" F27 is bound to Win+P in Alacritty
nmap <silent> <F27> :call CtrlpGlobal()<CR>

" facilitate the above in insert mode as well
imap <c-p> <ESC><c-p>
imap <F27> <ESC><F27>
imap <F28> <ESC><F28>

let g:ctrlp_working_path_mode = ''
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
let g:ctrlp_by_filename = 1

" Open in new tab by default
let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<c-t>'],
    \ 'AcceptSelection("t")': ['<cr>', '<2-LeftMouse>'],
    \ }

nmap <S-e> :Ranger<CR>
cmap w!! w !sudo tee %

" General keybindings
nmap <silent> <F1> :Bufferize messages<CR>
vmap <silent> <F1> :Bufferize messages<CR>
imap <silent> <F1> <ESC>:Bufferize messages<CR>

" Terminal bindings
tnoremap <Esc> <C-\><C-n>

tmap <M-h> <C-\><C-N><M-h>
tmap <M-j> <C-\><C-N><M-j>
tmap <M-k> <C-\><C-N><M-k>
tmap <M-l> <C-\><C-N><M-l>

tmap <C-h> <C-\><C-N><C-h>
tmap <C-j> <C-\><C-N><C-j>
tmap <C-k> <C-\><C-N><C-k>
tmap <C-l> <C-\><C-N><C-l>

inoremap <C-d> <C-\><C-o>dB

nmap <Space><Del> :call delete(expand('%')) <bar> bdelete!
nmap <Space>r :call feedkeys(":Rename " . expand('%@'))<CR>
nmap <Space>o :on<CR>

" If cpo-< ik not specified, then for some reason, having a newline anywhere in the register
" makes appending to it add newlines automatically.
" We have however specified it so we only need the comma
nnoremap - :let @a=""<CR>
nnoremap , "A
"nnoremap ; :let @a=@a."\n"<CR>"A


nmap <silent> <C-c> :let @+ = '#include "' . substitute(substitute(expand("%:f"), "src/", "", ""), "/home/pbc/Hypersomnia/", "", "") . '"' . "\n" <CR>

nmap <Space>s :source $MYVIMRC<CR>

function! OpenLastErrors()
	let opencmd = "tabnew term://bash -c 'cat " . g:last_error_path_color . "'"
	echomsg opencmd
	execute opencmd
endfunction

nmap <Space>e :call OpenLastErrors()<CR>
nmap <Space>v :e ~/cfg/.vimrc<CR>
nmap <Space>w :set list!<CR>

nmap <Return>w ciw<C-r>0<ESC>
nmap <Return>W ciW<C-r>0<ESC>
nmap <Return>s S<C-r>0<ESC>

map <F2> :e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR>

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
nmap <C-f> :Grepper -tool ag -noprompt -query ''<left>

" Search word under cursor
nmap <F4> :execute "Grepper -tool ag -cword -noprompt"<CR>

" Search selection
vmap <F4>   <plug>(GrepperOperator)

" For motions
nmap gs  <plug>(GrepperOperator)

" vim-fugitive bindings 

" Browse commits with the current file
map <S-l> :execute "silent Glog -- %" <bar> redraw!<CR> 
" Browse commits in the whole repository
map <C-l> :execute "silent Glog --" <bar> redraw!<CR> 

map <silent> <C-s> :execute "Gstatus"<CR>
map <silent> <C-d> :execute "Gdiff"<CR>
" We will anyway do it from the status window
" map <C-C> :execute "Gcommit"<CR>
nmap <silent> <C-a> GVgg
nmap U :execute "GitGutterUndoHunk"<CR>

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

" Wrap lines in diff mode by default
autocmd FilterWritePre * if &diff | setlocal wrap< | endif
autocmd FilterWritePre * if &diff | highlight DiffChange guibg=#001538 | endif


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

" The openers are in this order:
" Matches at least one < or [ or { or ( 
" Matches comment beginning: /*
" Matches long assignment breaked over the line
" Matches return statement breaked over lines

let g:indent_eol_openers = [
	\'[\[<({]\{1,}',
	\'/\*', 
	\'=',
	\'return'
\]

" The closers are in this order:

" Matches ] or ) or > or )  or ]; or ); or ...
" Matches comment closing: */
" After lambda definition and call in one go
" Matches end of a long argument list for a function declaration: ) {
" Matches end of a long argument list for a function declaration: ) const {
" After long assignment

let g:indent_eol_closers = [
	\'[\]>)}]\{1,}[;,]\{,1}', 
	\'\*/', 
	\'}();',  
	\')\s*{',
	\')\s*const\s*{',
	\';\{1,}' 
\]

let g:indent_decreasers = [
	\'public:', 
	\'protected:', 
	\'private:'
\]

function! ListToPattern(mylist, prologue, epilogue)
	let result_pattern = ''

	for elem in a:mylist
		if strlen(result_pattern) > 0
			let result_pattern = result_pattern . '\|' 
		endif

		let result_pattern = result_pattern . a:prologue . elem . a:epilogue
	endfor	

	return result_pattern
endfunction

let g:indent_opener_pattern = ListToPattern(g:indent_eol_openers, '', '\s*$')
let g:indent_closer_pattern = ListToPattern(g:indent_eol_closers, '^\s*', '\s*$')
let g:indent_decreaser_pattern = ListToPattern(g:indent_decreasers, '^\s*', '\s*$')
let g:indent_zeroer_pattern = '^\s*#'

function! GenericIndent(lnum)
  " Find a non-blank line above the current line.
  let curline = getline(a:lnum)

  if (curline =~ g:indent_zeroer_pattern)
	  return 0
  endif

  let lnum = prevnonblank(a:lnum - 1)

  while lnum > 0 && (getline(lnum) =~ '^\s*$' || getline(lnum) =~ g:indent_decreaser_pattern || getline(lnum) =~ g:indent_zeroer_pattern) 
    let lnum = prevnonblank(lnum - 1)
  endwhile
  if lnum == 0
    return 0
  endif
  let prevline = getline(lnum)
  let indent = indent(lnum)
  let g:indent_of_prev = indent
  if ( prevline =~ g:indent_opener_pattern ) 
    "echomsg "matchprev sw: " . &sw
    let indent = indent + &sw
  endif
  if (curline =~ g:indent_closer_pattern || curline =~ g:indent_decreaser_pattern )
    "echomsg "matchprev sw: " . &sw
    let indent = indent - &sw
  endif
  " Additionally, if it is a label, decrease indent"
  "echomsg "Cur:" . a:lnum . " Prev: " . prevline . "ind: " . indent . " indofprev: " . g:indent_of_prev
  return indent
endfunction

autocmd FileType cpp setlocal indentexpr=GenericIndent(v:lnum)
autocmd FileType cpp nnoremap <buffer> p p=`]`]
autocmd FileType cpp nnoremap <buffer> P P=`]`[

