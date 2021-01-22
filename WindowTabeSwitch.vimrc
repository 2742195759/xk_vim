function! WindowJudgeAndProcess()
	let c = getchar()
	if c == "j" 
		exec "normal! :tabnext"
	endif
endfunction
nnoremap    <M-1>   :tabprevious<cr>
nnoremap    <M-2>   :tabnext<cr> 
inoremap    <M-1>   <ESC>:tabprevious<cr>
inoremap    <M-2>   <ESC>:tabnext<cr> 
"nnoremap    <tab>   <C-W>W
"noremap <space> :tabnext<cr>
noremap <tab> <C-w>
noremap <tab><tab> <C-w>w
