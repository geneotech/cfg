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

map J <Plug>(easymotion-j)
map K <Plug>(easymotion-k)

map <F36> <Plug>(easymotion-w)
map <F37> <Plug>(easymotion-b)

let g:easymotion_paste_at_origin=0

function! EMwInsert()
	let g:easymotion_paste_at_origin=1
	call feedkeys("\<F36>")
endfunction

function! EMbInsert()
	let g:easymotion_paste_at_origin=1
	call feedkeys("\<F37>")
endfunction

imap <F36> <ESC>:call EMwInsert()<CR>
imap <F37> <ESC>:call EMbInsert()<CR>

let g:EasyMotion_keys = 'asdghklzxcvbnqwertyuiopjfm'
let g:EasyMotion_do_shade = 1
