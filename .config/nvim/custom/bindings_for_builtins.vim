"""""""""" Faster bindings for built-in vim functionality

cnoreabbrev W w

" In quickfix, let "o" open the location, it's closer than Enter
autocmd BufReadPost quickfix nnoremap <buffer> o <CR>

" We often play with vimrc
nnoremap <Space>s :source $MYVIMRC<CR>
nnoremap <Space>v :e $MYVIMRC<CR>

" We center the view often
nnoremap z zz

" Switch between .h and .cpp back and forth
noremap <F2> :e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR>

" Deletes current file
nnoremap <Space><Del> :call delete(expand('%')) <bar> bdelete!

" Leaves only the current window open
nnoremap <silent> <Space>o :on<CR>:GitGutter<CR>

" Toggles whitespace view
nnoremap <silent> <Space>w :set list!<CR>

" Better go-to file under cursor
nnoremap gf gFzz

" Fix path for it by the way
set path+=src/**

" Y copies the current line without surrounding whitespace and newline
nnoremap Y ^yg_

" Standard-issue Control+A behaviour
nnoremap <silent> <C-a> GVgg
inoremap <silent> <C-a> <ESC>GVgg

" C-v just pastes the register in insert and command mode
inoremap <C-v> <ESC>pa
cnoremap <C-v> <C-R>=@+<CR>

" My fingers hurt when I try to alternate between C-n and C-p
" when wanting to execute previous or next command
cnoremap J <C-n>
cnoremap K <C-p>
tnoremap J <C-N>
tnoremap K <C-P>

" Move cursor in insert, terminal and command modes,
" without the need to reach for arrows.
cnoremap <C-h> <Left>
cnoremap <C-l> <Right>
tnoremap <C-h> <Left>
tnoremap <C-l> <Right>
inoremap <C-h> <C-G>U<Left>
inoremap <C-l> <C-G>U<Right>

" Unmap C-j as command confirmation because it is too close to my fingers,
" and shit may hit the fan. I prefer Enter, really.
cnoremap <C-j> <NOP>
cnoremap <C-k> <NOP>

" Terminal 'ease of access'
tnoremap <Esc> <C-\><C-n><C-w><C-p>
tnoremap <C-v> <C-\><C-n>pi

" Switch windows 
" Don't map Tab button! For some reason, it screws up the <C-I> binding
" Yeah, I know C-z mapping is strange, but I really have no keys left...
nnoremap <C-z> <C-w><C-w>

" Write current file with sudo
cnoremap w!! w !sudo tee %

" Move selection to our home trash
vmap <silent> <Space>d :w >> /home/pbc/vtrash<CR>gvd

function! SucklessHash()
	let @/ = expand("<cword>")
	normal N
endfunction

nnoremap <silent> # :call SucklessHash()<CR>
