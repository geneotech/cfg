function! FeedReplace()
	let expanded = expand('<cword>') 

	if strlen(expanded) > 0 
		call feedkeys(':%s/' . expanded . '//g' . "\<left>\<left>")
	else
		call feedkeys(':%s///g' . "\<left>\<left>\<left>")
	endif 
endfunc

nmap R :call FeedReplace()<CR>

function! FeedReplaceVisual(kind)
	if a:kind ==# "v"
		return "\"hy:%s/\<C-r>h//g\<left>\<left>"
	endif

	return ":s///g\<left>\<left>\<left>"
endfunc

xnoremap <expr> R FeedReplaceVisual(mode())
nmap <C-h> :cdo s///g <bar> update<left><left><left><left><left><left><left><left><left><left><left>
