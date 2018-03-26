function! OpenInBrowserImpl(link)
	silent call jobstart("firefox " . a:link . '; $(i3-msg "[title=Firefox] focus")')
endfunction

command! -nargs=1 OpenInBrowser call OpenInBrowserImpl(<q-args>)

function! BrowseDocs()
    let old_fzf_action = g:fzf_action 
	let old_fzf_opts = $FZF_DEFAULT_OPTS
	let $FZF_DEFAULT_OPTS='--nth=-2,-1 --delimiter=/'
    let g:fzf_action = { 'enter': 'OpenInBrowser' }

	silent execute "Files " . "/home/pbc/offline/std/en/cpp"
	let g:fzf_action = old_fzf_action
	let $FZF_DEFAULT_OPTS= old_fzf_opts
endfunction

nnoremap <C-x> :call BrowseDocs()<CR>
