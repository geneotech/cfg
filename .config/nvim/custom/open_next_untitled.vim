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

" F35 is bound to ctrl+shift+n
nmap <silent> <F35> :call OpenNextUntitled()<CR>
imap <silent> <C-n> <ESC>:call OpenNextUntitled()<CR>
