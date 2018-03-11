nmap <Space>f :set foldenable!<CR>

function! FoldMaps()
	setlocal foldmethod=syntax
	"nnoremap <buffer> o za
	"onoremap <buffer> o <C-C>za
	"vnoremap <buffer> o zf
endfunction

autocmd FileType gitcommit setlocal nofoldenable | call FoldMaps()
autocmd FileType git setlocal foldenable | call FoldMaps()

