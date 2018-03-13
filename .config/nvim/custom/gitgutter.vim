nmap U :execute "GitGutterUndoHunk"<CR>
nmap ! :GitGutterPreviewHunk<CR>
runtime plugin/gitgutter.vim
GitGutterLineHighlightsEnable
nnoremap - :GitGutterStageHunk<CR>

" Prevent live updating of git gutter, it annoys me while writing
autocmd! gitgutter CursorHold,CursorHoldI
let g:gitgutter_diff_args = '-w'

" Update gitgutter on writes
autocmd BufWritePost * GitGutter
" Quickly select whole hunk the cursor is currently in
nmap H vic

nnoremap <Space>l :GitGutterLineHighlightsToggle<CR>
