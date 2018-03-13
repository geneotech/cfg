set background=dark


"highlight LineNr ctermbg=black guibg=#080808
"highlight CursorLineNR guibg=#080808 guifg=NONE
highlight CursorLine guibg=#181818
highlight TabLineFill guifg=#080808 guibg=#080807
highlight TabLineSel guibg=#202020 guifg=white
highlight TabLine guibg=#080808 

" Colors for diff in general
highlight DiffAdd    ctermbg=16 guibg=#001c09 guifg=NONE
highlight DiffDelete ctermbg=17 guibg=#1c0000 guifg=NONE
highlight DiffChange ctermbg=17 guibg=#001538 guifg=NONE  

" Changed text inside the changed line
highlight DiffText   ctermbg=88 guibg=#323210 guifg=NONE  

" Colors for diff markers on the left column
highlight GitGutterAdd guifg=darkgreen 
highlight GitGutterChange guifg=darkyellow 
highlight GitGutterChangeDelete guifg=darkyellow 
highlight GitGutterDelete guifg=darkred

" Wrap lines in diff mode by default
autocmd FilterWritePre * if &diff | setlocal wrap< | endif
autocmd FilterWritePre * if &diff | highlight DiffChange guibg=#001538 | endif

highlight SpecialKey guifg=#505050
highlight NonText guifg=#505050

highlight HighlightedyankRegion guifg=NONE guibg=#3f1000

hi Underlined ctermbg=239 ctermfg=187 cterm=NONE guibg=#6B4035 guifg=#E0CCAE gui=NONE
hi TabLine guibg=bg gui=NONE
