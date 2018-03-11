set nocompatible              " be iMproved, required
filetype off                  " required

set rtp+=~/.config/nvim/bundle/Vundle.vim
call vundle#begin("~/.config/nvim/bundle")
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
Plugin 'fcpg/vim-farout'
Plugin 'machakann/vim-highlightedyank'
Plugin 'easymotion/vim-easymotion'
Plugin 'tpope/vim-git'
Plugin 'powerman/vim-plugin-viewdoc'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'

call vundle#end()            " required
filetype plugin indent on    " required

augroup vimrcEx
	au!
	autocmd FileType text setlocal textwidth=78
augroup END

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

let $CUSTOM='~/.config/nvim/custom'

source $CUSTOM/bindings_for_builtins.vim
source $CUSTOM/quick_plugin_configs.vim

source $CUSTOM/backspace_hacks.vim
source $CUSTOM/moving_in_text.vim
source $CUSTOM/grepper.vim
source $CUSTOM/wrap_qf_nextprev.vim
source $CUSTOM/make_integration.vim
source $CUSTOM/copy_path_to_clipboard.vim
source $CUSTOM/fzf_config.vim
source $CUSTOM/browser_integration.vim
source $CUSTOM/replace_operator.vim
source $CUSTOM/open_next_untitled.vim
source $CUSTOM/tab_navigation.vim
source $CUSTOM/manual_replaces.vim
source $CUSTOM/fugitive_config.vim
source $CUSTOM/gitgutter.vim
source $CUSTOM/tabline.vim
source $CUSTOM/indenting.vim
source $CUSTOM/folding.vim
source $CUSTOM/vimdiff_config.vim

""""""""" Epilogue

if strlen($LAUNCH_TERMINAL) > 0
	source $CUSTOM/setup_terminal.vim
else
	colorscheme moonfly
	set termguicolors

	" On normal startup, open an agenda file

	if @% =~ "Untitled"
		silent edit /home/pbc/agenda.md
	endif
endif

function! FixColors()
	execute("source $CUSTOM/colorscheme_fixes/" . g:colors_name . "_fix.vim")
endfunc

autocmd ColorScheme * call FixColors()
