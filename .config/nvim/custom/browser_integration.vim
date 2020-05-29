function! OpenInBrowserImpl(link)
	silent call jobstart("firefox " . a:link . '; $(i3-msg "[title=Firefox] focus")')
endfunction

command! -nargs=1 OpenInBrowser call OpenInBrowserImpl(<q-args>)

function! BrowseDocs()
    let old_fzf_action = g:fzf_action 
	let old_fzf_opts = $FZF_DEFAULT_OPTS
	let $FZF_DEFAULT_OPTS = g:fzf_only_filename_and_last_folder
    let g:fzf_action = { '': 'OpenInBrowser', 'enter': 'OpenInBrowser' }

	silent execute "Files " . "$HOME/offline/en/cpp"

	" Cleanup
	let g:fzf_action = old_fzf_action
	let $FZF_DEFAULT_OPTS = old_fzf_opts
endfunction

" nnoremap <C-x> :call BrowseDocs()<CR>
