" Environment variables setup
let $FZF_DEFAULT_OPTS='--nth=-1 --delimiter=/'
let $FZF_DEFAULT_COMMAND = 'ag --hidden -U -g ""'

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
Plugin 'AndrewRadev/bufferize.vim'
Plugin 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plugin 'junegunn/fzf.vim'
Plugin 'vim-scripts/ibmedit.vim'
Plugin 'elmindreda/vimcolors'
Plugin 'fcpg/vim-farout'
Plugin 'machakann/vim-highlightedyank'
Plugin 'easymotion/vim-easymotion'
Plugin 'tpope/vim-git'
Plugin 'powerman/vim-plugin-viewdoc'

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
" Use system clipboard
set clipboard=unnamedplus

" always append newline when appending to a register
set cpoptions+=>

set notimeout
"
" Keep the yank highlight 
let g:highlightedyank_highlight_duration = -1

""""""""" I/O fixes

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

" Don't complete brackets for me (don't know why does this option have this name)
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
" On composing substitute command, see to-be-applied changes live
set inccommand=nosplit

" Highlight current line
set cursorline

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
"set number relativenumber
" set number

" Let us only see the filename
set titlestring="VIM"

""""""""" General custom commands

command! -nargs=0 Td echo system("timedatectl")
cnoreabbrev td Td

""""""""" Plugin configuration
let g:no_viewdoc_maps = 1

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

let g:grepper.switch = 0
""""""""""  General bindings
nmap <Leader>s :execute "CopyPath " . 'cd $(dirname ' . expand("%:p") . ")"<CR>
nmap <Space>f :set foldenable!<CR>

" Switch windows 
" Don't map Tab button! For some reason, it screws up the <C-I> binding
" Yeah, I know C-z mapping is strange, but I really have no keys left...
nnoremap <C-z> <C-w><C-w>

nmap gf gFz
" Quickly select whole hunk the cursor is currently in
nmap H vic

nnoremap Y ^yg_
" F32 is bound to shift+backspace in alacritty
nnoremap <F32> ^yg_"_dd
inoremap <F32> <BS>
tnoremap <F32> <BS>
cnoremap <F32> <BS>

" C-v just pastes the register in insert mode
inoremap <C-v> <ESC>pa
cnoremap <C-v> <C-R>=@+<CR>
cnoremap J <C-n>
cnoremap K <C-p>
" Delete whole word backwards - F25 is bound to ctrl+backspace
cnoremap <F25> <C-w>
tnoremap <F25> <C-w>

" set scroll=20

" Faster moving around

" Standard move viewport
nnoremap <F14> 10<C-e>
nnoremap <F15> 10<C-y>
vnoremap <F14> 10<C-e>
vnoremap <F15> 10<C-y>

" Move viewport more
nnoremap <F16> 20<C-e>
nnoremap <F18> 20<C-y>
vnoremap <F16> 20<C-e>
vnoremap <F18> 20<C-y>

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

" Alacritty bindings:
" F28 = Ctrl + ;
" F29 = Ctrl + '
" F30 = Ctrl + .
" F31 = Ctrl + /

nmap <silent> <F29> :call WrapCommand('up', 'c')<CR>
nmap <silent> <F28> :call WrapCommand('down', 'c')<CR>

nmap <silent> <F31> :call WrapCommand('up', 'l')<CR>
nmap <silent> <F30> :call WrapCommand('down', 'l')<CR>

function! StartDebugging()
	let gdbcmd = "Nbgdb ConfHyper"
	execute gdbcmd 
endfunction

let g:last_error_path = '/tmp/last_error.txt'
let g:last_error_path_color = '/tmp/last_error_color.txt'
let g:run_result_path = '/tmp/run_result.txt'
let g:bt_path = '/tmp/bt.txt'

function! OnBuildEvent(job_id, data, event) dict
	if filereadable(g:last_error_path)
		execute "lfile " . g:last_error_path
		normal zz
	elseif filereadable(g:bt_path)
		execute "lfile " . g:bt_path
	elseif filereadable(g:run_result_path)
		"lfile g:run_result_path
		let fff = readfile(g:run_result_path)

		if len(fff) > 0 
			echomsg fff[0]
		endif
	else
		echomsg "Build successful."
	endif
endfunction

function! OnDebugBuildEvent(job_id, data, event) dict
	if filereadable(g:last_error_path)
		execute "lfile " . g:last_error_path
		normal zz
	else
		echomsg "Build successful."

		call StartDebugging()
	endif
endfunction

function! SucklessMake(targetname)
	wa

	let runscript = expand("%:h") . "/run.sh"

    let callbacks = {
    \ 'on_exit': function('OnBuildEvent')
    \ }

	let jobcmd = "zsh -c 'source ~/cfg/vim_builders.sh; vim_target " . a:targetname . "'"

	if filereadable(runscript)
		let jobcmd = "zsh -c 'cd " . expand("%:h") . "; source " . runscript . "'"
	endif

	"echomsg jobcmd
    let job1 = jobstart(jobcmd, callbacks)
endfunction

function! SucklessMakeDebug(targetname)
	wa

"	if exists('g:gdb')
"		echomsg "Stopping existing GDB session"
	"endif

    let callbacks = {
    \ 'on_exit': function('OnDebugBuildEvent')
    \ }

	let jobcmd = "zsh -c 'source ~/cfg/vim_builders.sh; vim_target " . a:targetname . "'"
	"echomsg jobcmd

    let job1 = jobstart(jobcmd, callbacks)
endfunction

function! ConfHyper() abort
	let WORKSPACE_NAME=system("echo -n $(basename " . $PWD . ")")
	let WORKSPACE_EXE= $PWD . "/build/current/" . WORKSPACE_NAME

    " user special config
    let this = {
        \ "Scheme" : 'gdb#SchemeCreate',
        \ "autorun" : 1,
        \ "reconnect" : 1,
        \ "showbreakpoint" : 1,
        \ "showbacktrace" : 0,
        \ "conf_gdb_layout" : ["vsp"],
        \ "conf_gdb_cmd" : ["cd " . $PWD . "; gdb -q -f -cd hypersomnia", WORKSPACE_EXE],
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

function! NeogdbvimNmapCallback()
	" Let fzf.vim open files in the current buffer by default.
	" This is so that, when navigating files,
	" we don't switch to a new tab and thus *always* see the neogdb's splits. 
    let g:fzf_action = { 'enter': 'edit' }
    let g:ctrlp_global_command = 'edit'

	nmap <silent> <F29> :call WrapCommand('up', 'c')<CR>
	nmap <silent> <F28> :call WrapCommand('down', 'c')<CR>

	nmap <silent> <F31> :call WrapCommand('up', 'l')<CR>
	nmap <silent> <F30> :call WrapCommand('down', 'l')<CR>
endfunc

function! NeogdbvimUnmapCallback()
	" Quitting to normal editing. Let fzf.vim open files in the new tab.
    let g:ctrlp_global_command = 'tabnew'
    let g:fzf_action = { 'enter': 'tabnew' }

	nmap <silent> <F29> :call WrapCommand('up', 'c')<CR>
	nmap <silent> <F28> :call WrapCommand('down', 'c')<CR>

	nmap <silent> <F31> :call WrapCommand('up', 'l')<CR>
	nmap <silent> <F30> :call WrapCommand('down', 'l')<CR>
endfunc

nmap <Space>p :call gdb#Send("print " . expand('<cword>'))<CR>

let g:gdb_keymap_continue = '<f8>'
let g:gdb_keymap_next = '<f10>'
let g:gdb_keymap_step = '<f11>'
" Usually, F23 is just Shift+F11
let g:gdb_keymap_finish = '<f23>'
let g:gdb_keymap_toggle_break = '<f9>'
" Usually, F33 is just Ctrl+F9
let g:gdb_keymap_toggle_break_all = '<f33>'
let g:gdb_keymap_frame_up = '<c-u>'
let g:gdb_keymap_frame_down = '<c-i>'
" Usually, F21 is just Shift+F9
let g:gdb_keymap_clear_break = '<f21>'
" Usually, F17 is just Shift+F5
let g:gdb_keymap_debug_stop = '<f17>'

let g:gdb_require_enter_after_toggling_breakpoint = 0

" What?
let g:gdb_keymap_until = '<f13>'
let g:gdb_keymap_refresh = '<f12>'

" Build bindings

" F19 = S+F7
nmap <silent> <F19> :call SucklessMake(ToRepoPath(expand("%:f")) . ".o")<CR>
nmap <silent> <F7> :call SucklessMake("all")<CR>
nmap <silent> <F6> :call SucklessMakeDebug("all")<CR>
nmap <silent> <F5> :call SucklessMake("run")<CR>

imap <silent> <F19> <ESC><F19>
imap <silent> <F5> <ESC><F5>
imap <silent> <F6> <ESC><F6>
imap <silent> <F7> <ESC><F7>

nmap <Space>h :execute "ViewDocHelp " . expand("<cword>")<CR>

" F25 is bound to Control + Backspace in Alacritty
inoremap <F25> <C-w>

" fzf bindings

" So that we also search through hidden files

function! s:find_git_root()
  return system('cd ' . expand("%:h") . '; git rev-parse --show-toplevel 2> /dev/null')[:-2]
endfunction

function! ToRepoPath(fpath)
	return substitute(expand(a:fpath), $PWD, "", "")
endfunc

function! ToCppIncludePath(fpath)
	return '#include "' . ToRepoPath(substitute(expand(a:fpath), "src/", "", "")) . '"' 
endfunc

command! -nargs=1 CopyPath let @+ = <q-args>
command! -nargs=1 CopyIncludePath let @+ = ToCppIncludePath(<q-args>) . "\n"

let g:fzf_action = {
  \ 'enter': 'tab drop',
  \ 'ctrl-s': 'vsplit',
  \ 'ctrl-i': 'CopyIncludePath',
  \ 'ctrl-c': 'CopyPath' }

command! ProjectFiles execute 'Files' s:find_git_root()

let g:fzf_layout = { 'down': '~24%' }

nmap <silent> <C-t> :Tags<CR>
imap <silent> <C-t> <ESC>:Tags<CR>

function! OpenInBrowserImpl(link)
	silent call jobstart("firefox " . a:link . '; $(i3-msg "[title=Firefox] focus")')
endfunction

command! -nargs=1 OpenInBrowser call OpenInBrowserImpl(<q-args>)

function! BrowseDocs()
    let old_fzf_action = g:fzf_action 
	let old_fzf_opts = $FZF_DEFAULT_OPTS
	let $FZF_DEFAULT_OPTS='--nth=-2,-1 --delimiter=/'
    let g:fzf_action = { 'enter': 'OpenInBrowser' }

	silent execute "Files " . "/home/pbc/doc/std/en/cpp"
	let g:fzf_action = old_fzf_action
	let $FZF_DEFAULT_OPTS= old_fzf_opts
endfunction

nnoremap <F22> :execute ("Files " . expand("%:h"))<CR>
nnoremap <C-x> :call BrowseDocs()<CR>

nmap <silent> <C-p> :GFiles<CR>
imap <silent> <C-p> <ESC>:GFiles<CR>

let g:ctrlp_global_command = 'tabnew'

function! CtrlpGlobal()
	" Looks like rofi is faster for exact matching,
	" and we really want exact matching for so many files
	
	let newloc = system("echo $(ag --hidden -U -g '' $(cat ~/.config/i3/find_all_locations) 2> /dev/null | rofi -hide-scrollbar -dmenu -i -p 'ag')")

	if strlen(newloc) > 1 
		execute (g:ctrlp_global_command . " " . newloc)
	endif
endfunction

" F26 is bound to Ctrl+Shift+P in Alacritty
nmap <silent> <F26> :ProjectFiles<CR>

" F27 is bound to Win+P in Alacritty
nmap <silent> <F27> :call CtrlpGlobal()<CR>

" facilitate the above in insert mode as well
nmap <F20> <ESC><F20>
imap <c-p> <ESC><c-p>
imap <F27> <ESC><F27>
imap <F28> <ESC><F28>

" F34 is bound to ctrl+shift+e in alacritty
nmap <F34> :Ranger<CR>
cnoremap w!! w !sudo tee %

" General keybindings
vmap <silent> <Space>d :w >> /home/pbc/vtrash<CR>gvd

nmap <silent> <F1> :Bufferize messages<CR>
vmap <silent> <F1> :Bufferize messages<CR>
imap <silent> <F1> <ESC>:Bufferize messages<CR>

" Allow for switching tabs even while in command mode
cmap <C-j> <NOP>
cmap <C-k> <NOP>

" move cursor
cnoremap <C-h> <Left>
cnoremap <C-l> <Right>

" Terminal bindings
tnoremap <Esc> <C-\><C-n><C-w><C-p>
tnoremap <C-v> <C-\><C-n>pi

" Make ESC always quit the fzf prompt and not just enter normal mode
autocmd! FileType fzf tnoremap <buffer> <Esc> <c-q>

" QUESTION: Determine good bindings for moving around windows in terminal?
" SOLUTION: No need to. On escaping terminal, we'll always move to the
" previously used window for convenience. See escape binding.

" Allow for switching tabs even while in terminal
tmap <C-h> <Esc><C-h>
tmap <C-j> <Esc><C-j>
"
" move cursor
tnoremap <C-h> <Left>
tnoremap <C-l> <Right>


" Allows choosing the candidates in fzf.vim with shift+j and shift+k \
" instead of arrow keys

tnoremap <S-k> <C-P>
tnoremap <S-j> <C-N>

nmap <Space><Del> :call delete(expand('%')) <bar> bdelete!
nmap <Space>r :call feedkeys(":Rename " . expand('%@'))<CR>
nmap <Space>o :on<CR>:GitGutter<CR>
nmap ! :GitGutterPreviewHunk<CR>

" Appending macros

" If cpo-< ik not specified, then for some reason, having a newline anywhere in the register
" makes appending to it add newlines automatically.
" We have however specified it so we only need the comma
"nnoremap - :let @a=""<CR>
nnoremap , "A
"nnoremap ; :let @a=@a."\n"<CR>"A

nmap <silent> <C-e> :History<CR>
nmap <silent> <C-c> :let @+ = ToCppIncludePath(expand("%:f")) . "\n"<CR>

nmap <Space>s :source $MYVIMRC<CR>

function! OpenLastErrors()
	let opencmd = "tabnew term://bash -c 'cat " . g:last_error_path_color . "; bash'"
	echomsg opencmd
	execute opencmd
endfunction

nmap <Space>e :call OpenLastErrors()<CR>
nmap <Space>v :e ~/cfg/.vimrc<CR>
nmap <Space>w :set list!<CR>

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
    exe "normal! \"_c\<C-r>\"\<ESC>"
endfu

nmap <Return> <Plug>ReplaceOperator
vmap <Return> <Plug>ReplaceOperator

" Shortcuts for frequently used cases
nmap <Return>w "_ciw<C-r>"<ESC>
nmap <Return>W "_ciW<C-r>"<ESC>
nmap <Return>b "_cib<C-r>"<ESC>
nmap <Return>B "_ciB<C-r>"<ESC>
nmap <Return>< "_ci<<C-r>"<ESC>
nmap <Return>" "_ci"<C-r>"<ESC>
nmap <Return>' "_ci'<C-r>"<ESC>
nmap <Return>s "_ddP

map <F2> :e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR>

" Also prevents the editor from being closed when the last tab closes
nmap <silent> <C-w> :close<CR>:GitGutter<CR>
imap <silent> <C-w> <ESC>:close<CR>

function! OpenNextUntitled()
	let idx = 1

	while idx < 1000	
		let newfname = '/home/pbc/doc/new/unt' . idx

		if filereadable(newfname)
			let fff = readfile(newfname)

			if len(fff) > 0 
				let idx += 1
				continue
			endif
		endif

		execute 'tabnew ' . newfname
		break
	endwhile
endfunction

nmap <silent> <C-j> :tabprevious<CR>
nmap <silent> <C-k> :tabnext<CR>
nmap <silent> <C-n> :call OpenNextUntitled()<CR>
" So that we can switch tabs at any time
imap <silent> <C-j> <ESC>:tabprevious<CR>
imap <silent> <C-k> <ESC>:tabnext<CR>
imap <silent> <C-n> <ESC>:call OpenNextUntitled()<CR>

"nmap <silent> <S-j> :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
"nmap <silent> <S-k> :execute 'silent! tabmove ' . (tabpagenr()+1)<CR>

""" Replacing """
nmap <C-h> :cdo s///g <bar> update<left><left><left><left><left><left><left><left><left><left><left>

function! FeedReplace()
	let expanded = expand('<cword>') 

	if strlen(expanded) > 0 
		call feedkeys(':%s/' . expanded . '//g' . "\<left>\<left>")
	else
		call feedkeys(':%s///g' . "\<left>\<left>\<left>")
	endif 
endfunc

" F35 is bound to C-S-h in Alacritty
nmap R :call FeedReplace()<CR>
vmap R :s///g<left><left><left>

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

function! FindWhereThisFileIsIncluded()
	execute ("Grepper -tool ag -noprompt -query '" . ToCppIncludePath(expand("%:f")) . "'")
endfunc

" Find where the current file is included
" F13 is bound to Ctrl+Shift+I in Alacritty
nmap <silent> <F13> :call FindWhereThisFileIsIncluded()<CR>

" vim-fugitive bindings 

" Browse commits with the current file
map <S-l> :execute "silent Glog -- %" <bar> redraw!<CR> 
" Browse commits in the whole repository
map <C-l> :execute "silent Glog --" <bar> redraw!<CR> 

map <silent> <C-s> :Gstatus <bar> wincmd T<CR>

map <silent> <C-d> :execute "Gdiff"<CR>
" We will anyway do it from the status window
" map <C-C> :execute "Gcommit"<CR>
nmap <silent> <C-a> GVgg
imap <silent> <C-a> <ESC>GVgg

nmap U :execute "GitGutterUndoHunk"<CR>

runtime plugin/gitgutter.vim
execute "GitGutterLineHighlightsEnable"
"execute "GitGutterSignsDisable"
nnoremap - :GitGutterStageHunk<CR>

" Prevent live updating of git gutter, it annoys me while writing
set updatetime=999999999
autocmd! gitgutter CursorHold,CursorHoldI
let g:gitgutter_diff_args = '-w'

execute "set t_8f=\e[38;2;%lu;%lu;%lum"
execute "set t_8b=\e[48;2;%lu;%lu;%lum"

runtime plugin/gutentags.vim
" Gutentags settings
let g:gutentags_cache_dir='/tmp'

if strlen($LAUNCH_TERMINAL) > 0
	colorscheme moonfly
	set termguicolors
else
	colorscheme moonfly
	set termguicolors
endif

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
	\') \:',
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

" On paste, fix indentation
autocmd FileType cpp nnoremap <buffer> p p=`]`]
autocmd FileType cpp nnoremap <buffer> P P=`]`[

" But let C-v never indent
nnoremap <C-v> p

nnoremap , ,
nnoremap z zz

map J <Plug>(easymotion-j)
map K <Plug>(easymotion-k)

map <F36> <Plug>(easymotion-w)
map <F37> <Plug>(easymotion-b)

let g:EasyMotion_keys = 'asdghklzxcvbnqwertyuiopjfm'
let g:EasyMotion_do_shade = 1

nnoremap <Up> <NOP>
nnoremap <Down> <NOP>
nnoremap <Left> <NOP>
nnoremap <Right> <NOP>

tnoremap <Up> <NOP>
tnoremap <Down> <NOP>

"map  / <Plug>(easymotion-sn)
"omap / <Plug>(easymotion-tn)

" These `n` & `N` mappings are options. You do not have to map `n` & `N` to
" EasyMotion.
" " Without these mappings, `n` & `N` works fine. (These mappings just provide
" " different highlight method and have some other features )
"map  n <Plug>(easymotion-next)
"map  N <Plug>(easymotion-prev)

autocmd BufReadPost quickfix nnoremap <buffer> o <CR>

" Update gitgutter on writes
autocmd BufWritePost * GitGutter

function! FoldMaps()
	setlocal foldmethod=syntax
	"nnoremap <buffer> o za
	"onoremap <buffer> o <C-C>za
	"vnoremap <buffer> o zf
endfunction

autocmd FileType gitcommit setlocal nofoldenable | call FoldMaps()
autocmd FileType git setlocal foldenable | call FoldMaps()

inoremap <C-h> <C-G>U<Left>
inoremap <C-l> <C-G>U<Right>

if strlen($LAUNCH_TERMINAL) > 0
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
	tnoremap <Up> <NOP>

	tnoremap <Down> <NOP>

	tnoremap <Down> <NOP>

	nnoremap I m'I
	nnoremap A m'A
	nnoremap i m'i
	nnoremap o m'i<Return>

	tnoremap <Esc> <C-\><C-n>

	nnoremap <C-c> m'i<C-c><C-\><C-n><C-o>

	nnoremap <F32> :call delete(expand('%')) <bar> bdelete! <bar> terminal<CR>

"	tunmap <S-k>
"	tunmap <S-j>

	terminal
	
	" So the build errors don't switch to the terminal window
	set notitle
	"hi Search ctermfg=black ctermbg=yellow
	startinsert
else
	if @% =~ "Untitled"
		silent edit /home/pbc/agenda.md
	endif
endif
