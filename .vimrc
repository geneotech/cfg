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
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
" Plugin 'file:///home/pbc/rep/gregor.vim'

call vundle#end()            " required
filetype plugin indent on    " required

if has("autocmd")
  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!
  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78
  augroup END
else
endif 

""""""""" General behaviour

" Use system clipboard
set clipboard=unnamedplus
" always append newline when appending to a register
set cpoptions+=>
set notimeout

""""""""" I/O fixes

set backupdir=/tmp
set undodir=/tmp
set swapfile
set dir=/tmp
set nobackup
set noswapfile
set noundofile

""""""""" Formatting

autocmd FileType cpp setlocal fo=
" Don't complete brackets for me (don't know why does this option have this name)
set noshowmatch
set nofixendofline

""""""""" Searching

" When searching try to be smart about cases
set smartcase
set ignorecase
" Highlight search results
set hlsearch
" Make search pattern matches show as it is composed
set incsearch
" For regular expressions turn magic on
set magic

""""""""" Viewing

" On composing substitute command, see to-be-applied changes live
set inccommand=nosplit
" Highlight current line
set cursorline
" Default split direction
set splitright
set listchars=eol:⏎,tab:>-,trail:␠,nbsp:⎵
" disable status line
set laststatus=0
" tab width
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

""""""""" General custom commands

command! -nargs=0 Td echo system("timedatectl")
cnoreabbrev td Td

""""""""" 'Unbindings' for breaking bad habits

nnoremap <Up> <NOP>
nnoremap <Down> <NOP>
nnoremap <Left> <NOP>
nnoremap <Right> <NOP>
tnoremap <Up> <NOP>
tnoremap <Down> <NOP>

""""""""" Includes

let $VIM_SCRIPTS='~/cfg/vimscript'

source $VIM_SCRIPTS/bindings_for_builtins.vim
source $VIM_SCRIPTS/quick_plugin_configs.vim

source $VIM_SCRIPTS/backspace_hacks.vim
source $VIM_SCRIPTS/moving_in_text.vim
source $VIM_SCRIPTS/grepper.vim
source $VIM_SCRIPTS/wrap_qf_nextprev.vim
source $VIM_SCRIPTS/make_integration.vim
source $VIM_SCRIPTS/copy_path_to_clipboard.vim
source $VIM_SCRIPTS/fzf_config.vim
source $VIM_SCRIPTS/browser_integration.vim
source $VIM_SCRIPTS/replace_operator.vim
source $VIM_SCRIPTS/open_next_untitled.vim
source $VIM_SCRIPTS/tab_navigation.vim
source $VIM_SCRIPTS/manual_replaces.vim
source $VIM_SCRIPTS/fugitive_config.vim
source $VIM_SCRIPTS/gitgutter.vim
source $VIM_SCRIPTS/tabline.vim
source $VIM_SCRIPTS/indenting.vim
source $VIM_SCRIPTS/folding.vim
source $VIM_SCRIPTS/vimdiff_config.vim

""""""""" Epilogue

if strlen($LAUNCH_TERMINAL) > 0
	source $VIM_SCRIPTS/setup_terminal.vim
else
	colorscheme moonfly
	set termguicolors

	" On normal startup, open an agenda file

	if @% =~ "Untitled"
		silent edit /home/pbc/agenda.md
	endif
endif
