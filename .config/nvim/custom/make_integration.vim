let g:last_error_path = '/tmp/last_error.txt'
let g:last_error_path_color = '/tmp/last_error_color.txt'
let g:run_result_path = '/tmp/run_result.txt'
let g:bt_path = '/tmp/bt.txt'

function! OnBuildEvent(job_id, data, event) dict
	if filereadable(g:last_error_path)
		execute "lfile " . g:last_error_path
		normal zz
	elseif filereadable(g:bt_path)
		execute "lfile " . g:bt_path
	elseif filereadable(g:run_result_path)
		"lfile g:run_result_path
		let fff = readfile(g:run_result_path)

		if len(fff) > 0 
			echomsg fff[0]
		endif
	else
		echomsg "Build successful."
	endif
endfunction

function! SucklessMake(targetname)
	wa

	let runscript = expand("%:h") . "/run.sh"

    let callbacks = {
    \ 'on_exit': function('OnBuildEvent')
    \ }

	let jobcmd = "zsh -c '. ~/cfg/shell/vim_builders.sh; vim_target " . a:targetname . "'"

	if filereadable(runscript)
		let jobcmd = "zsh -c 'cd " . expand("%:h") . "; . " . runscript . "'"
	endif

	"echomsg jobcmd
    let job1 = jobstart(jobcmd, callbacks)
endfunction

" Build bindings

" F19 = S+F7
nmap <silent> <F19> :call SucklessMake(ToRepoPath(expand("%:f")) . ".o")<CR>
nmap <silent> <F7> :call SucklessMake("all")<CR>
nmap <silent> <F5> :call SucklessMake("run")<CR>

imap <silent> <F19> <ESC><F19>
imap <silent> <F5> <ESC><F5>
imap <silent> <F7> <ESC><F7>

function! OpenLastErrors()
	let opencmd = "tabnew term://bash -c 'cat " . g:last_error_path_color . "; bash'"
	echomsg opencmd
	execute opencmd
endfunction

nmap <Space>e :call OpenLastErrors()<CR>
