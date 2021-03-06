"""""""""" Faster bindings for built-in vim functionality

nnoremap <Space>w :w<CR>
nnoremap <Space>x :x<CR>

" In quickfix, let "o" open the location, it's closer than Enter
autocmd BufReadPost quickfix nnoremap <buffer> o <CR>

" We often play with vimrc
nnoremap <silent> <Space>s :source $MYVIMRC<CR>
nnoremap <silent> <Space>v :e $MYVIMRC<CR>

" We center the view often
nnoremap z zz

function! SwitchSourceHeader()
  let tail = expand("%:t")

  if (tail[-4:] == "\.cpp")
    e %:h/%:t:r.h
  elseif  (tail[-2:] == "\.h")
    e %:h/%:t:r.cpp
  elseif  (tail[-7:] == "\.prefab")
    e %:h/%:t:r.prefab.meta
  elseif  (tail[-12:] == "\.prefab.meta")
    e %:h/%:t:r
  elseif  (tail[-3:] == "\.cs")
    e %:h/%:t:r.cs.meta
  elseif  (tail[-8:] == "\.cs.meta")
    e %:h/%:t:r
  elseif  (tail[-6:] == "\.asset")
    e %:h/%:t:r.asset.meta
  elseif  (tail[-11:] == "\.asset.meta")
    e %:h/%:t:r
  elseif  (tail[-5:] == "\.anim")
    e %:h/%:t:r.anim.meta
  elseif  (tail[-10:] == "\.anim.meta")
    e %:h/%:t:r
  elseif  (tail[-11:] == "\.controller")
    e %:h/%:t:r.controller.meta
  elseif  (tail[-16:] == "\.controller.meta")
    e %:h/%:t:r
  elseif  (tail[-4:] == "\.mat")
    e %:h/%:t:r.mat.meta
  elseif  (tail[-9:] == "\.mat.meta")
    e %:h/%:t:r
  endif
endfunction

" Switch between .h and .cpp back and forth
noremap <silent> <F2> :call SwitchSourceHeader()<CR>

" Deletes current file
nnoremap <Space><Del> :call delete(expand('%')) <bar> bdelete!

" Leaves only the current window open
nnoremap <silent> <Space>o :on<CR>:GitGutter<CR>

" Toggles whitespace view
"nnoremap <silent> <Space>w :set list!<CR>

" Better go-to file under cursor
nnoremap gf gFzz

" Fix path for it by the way
set path+=src/**

if g:is_ue4_project 
	set path+=/opt/unreal-engine/Engine/Source/Runtime
endif

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
cnoremap <C-j> <C-n>
cnoremap <C-k> <C-p>

" Move cursor in insert, terminal and command modes,
" without the need to reach for arrows.
cnoremap <C-h> <Left>
cnoremap <C-l> <Right>
tnoremap <C-h> <Left>
tnoremap <C-l> <Right>
inoremap <C-h> <C-G>U<Left>
inoremap <C-l> <C-G>U<Right>

inoremap <C-k> <C-left>
inoremap <C-j> <C-right>

inoremap <C-e> <Backspace>
cnoremap <C-e> <Backspace>
tnoremap <C-e> <Backspace>

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
vmap <silent> <Space>d :w >> $HOME/vtrash<CR>gvd

function! SucklessHash()
	let @/ = '\<' . expand("<cword>") . '\>'
	normal N
endfunction

nnoremap <silent> # :call SucklessHash()<CR>

nnoremap yia yi<
nnoremap cia ci<
nnoremap dia di<

nnoremap yaa ya<
nnoremap caa ca<
nnoremap daa da<

autocmd CmdwinEnter * nnoremap <buffer> <C-m> :let g:CmdWindowLineMark=line(".")<CR><CR>q::execute "normal ".g:CmdWindowLineMark."G"<CR>

" F34 is bound to ctrl+shift+e in alacritty
" Open ranger and select the current file
nnoremap <F34> :call jobstart('WAYLAND_DISPLAY= alacritty -e ranger --selectfile="' . expand("%:f") . '"') <CR>

" Go to next/prev match for the last tag
nnoremap <M-]> :tn<CR>
nnoremap <M-[> :tp<CR>

nnoremap <silent> <Esc> :noh<CR>
