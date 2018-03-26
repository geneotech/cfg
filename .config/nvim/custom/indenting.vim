autocmd FileType cpp setlocal nocindent
autocmd FileType cpp setlocal indentkeys+=;,>,),],/
set noautoindent 
set nosmartindent

" The openers are in this order:
" Matches at least one < or [ or { or ( 
" Matches comment beginning: /*
" Matches long assignment breaked over the line
" Matches return statement breaked over lines

let g:indent_eol_openers = [
	\'[\[<({]\{1,}',
	\'/\*', 
	\'=',
	\'return'
\]

" The closers are in this order:

" Matches ] or ) or > or )  or ]; or ); or ...
" Matches comment closing: */
" After lambda definition and call in one go
" Matches end of a long argument list for a function declaration: ) {
" Matches end of a long argument list for a function declaration: ) const {
" After long assignment

let g:indent_eol_closers = [
	\'[\]>)}]\{1,}[;,]\{,1}', 
	\'\*/', 
	\'}();',  
	\')\s*{',
	\')\s*const;',
	\')\s*const\s*{',
	\';\{1,}' 
\]

let g:indent_decreasers = [
	\'public:', 
	\') \:',
	\'protected:', 
	\'private:'
\]

function! ListToPattern(mylist, prologue, epilogue)
	let result_pattern = ''

	for elem in a:mylist
		if strlen(result_pattern) > 0
			let result_pattern = result_pattern . '\|' 
		endif

		let result_pattern = result_pattern . a:prologue . elem . a:epilogue
	endfor	

	return result_pattern
endfunction

let g:indent_opener_pattern = ListToPattern(g:indent_eol_openers, '', '\s*$')
let g:indent_closer_pattern = ListToPattern(g:indent_eol_closers, '^\s*', '\s*$')
let g:indent_decreaser_pattern = ListToPattern(g:indent_decreasers, '^\s*', '\s*$')
let g:indent_zeroer_pattern = '^\s*#'

function! GenericIndent(lnum)
  " Find a non-blank line above the current line.
  let curline = getline(a:lnum)

  if (curline =~ g:indent_zeroer_pattern)
	  return 0
  endif

  let lnum = prevnonblank(a:lnum - 1)

  while lnum > 0 && (getline(lnum) =~ '^\s*$' || getline(lnum) =~ g:indent_decreaser_pattern || getline(lnum) =~ g:indent_zeroer_pattern) 
    let lnum = prevnonblank(lnum - 1)
  endwhile
  if lnum == 0
    return 0
  endif
  let prevline = getline(lnum)
  let indent = indent(lnum)
  let g:indent_of_prev = indent
  if ( prevline =~ g:indent_opener_pattern ) 
    "echomsg "matchprev sw: " . &sw
    let indent = indent + &sw
  endif
  if (curline =~ g:indent_closer_pattern || curline =~ g:indent_decreaser_pattern )
    "echomsg "matchprev sw: " . &sw
    let indent = indent - &sw
  endif
  " Additionally, if it is a label, decrease indent"
  "echomsg "Cur:" . a:lnum . " Prev: " . prevline . "ind: " . indent . " indofprev: " . g:indent_of_prev
  return indent
endfunction

autocmd FileType cpp setlocal indentexpr=GenericIndent(v:lnum)

" On paste, fix indentation
autocmd FileType cpp nnoremap <buffer> p p=`]`]
autocmd FileType cpp nnoremap <buffer> P P=`]`[

" But let C-v never indent
nnoremap <C-v> p

