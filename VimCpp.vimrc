"自定义的有用的函数:
"<M-d>自动根据class声明写出代码,要求两个文件在同一个tabn的唯一两个windows中
"				类标志符->"b  	<C-O>为了跳会去,同时这是noremap,不会映射	
function! GetClassName()"{{{
	execute "normal! ?class\<cr>w\"ayw"
	return @a
endfunction"}}}
function! GetCntWord() "获得当前cursor的word"{{{
	execute "normal! lb\"ayw"
	return @a
endfunction"}}}
function! SwitchSourceHeadFile() "获得当前cursor的word"{{{
    let a=@%
    let res = substitute(a , '\.h' , '.cpp' , "eg")
	if a!=res 
		execute "e " . res
	endif
	let res = substitute(a , '\.cpp' , '.h' , "eg")
	if a != res 
		execute "e " . res
	endif
endfunction"}}}
function! GetVarTypeInClass()"{{{
	execute "normal! gel\"ay^"
	return @a
endfunction"}}}
function! GetArgList()"{{{
	execute "normal! hel\"ayf)"
	return @a
endfunction"}}}
function! JumpOtherFileEnd()  "{{{
	execute "normal! \<C-W>WGo\<esc>"
endfunction"}}}
function! JumpClassInternalFirstPublic()"{{{
	execute "normal! ?class\<cr>/{\<cr>/public\<cr>o\<esc>"
endfunction"}}}
function! StoreCursor()"{{{
	execute "normal! mf"
endfunction"}}}
function! RestoreCursor()"{{{
	execute "normal! `f"
endfunction"}}}
function! CreateSetGetFunctionDeclare()"{{{
	call StoreCursor()  
	let var_name = GetCntWord() 
	call RestoreCursor() 
	let var_type = GetVarTypeInClass()
	call RestoreCursor()  
	let cls_type = GetClassName()  
	call RestoreCursor()  
	call JumpClassInternalFirstPublic()
	let GetFunDec = printf("GetFun_%s()" , var_name)   
	let SetFunDec = printf("SetFun_%s(%s & t_%s)" , var_name , var_type , var_name)
	let @a=printf("    %s %s ;\n    void %s;" , var_type , GetFunDec , SetFunDec)  
	execute "normal! \"ap"
	call RestoreCursor()
	call JumpOtherFileEnd()
	let @a=printf("%s %s::%s{return %s;}\nvoid %s::%s{%s= t_%s;}" , var_type,cls_type,GetFunDec,var_name,cls_type,SetFunDec,var_name,var_name)
	execute "normal! \"ap"
	let @/=""
endfunction"}}}
function! SearchClassFunctionDecline()"{{{
	let class_name = @a
	let func_name = @b
	let comb = printf("\\<%s::%s\\>" , class_name , func_name) 
	let @/=comb
endfunction"}}}
function! DeleteFunctionImpliment() "{{{
	call StoreCursor()  
	let fun_name = GetCntWord() 
	call RestoreCursor() 
	let fun_type = GetFunTypeInClass()
	call RestoreCursor()  
	let cls_type = GetClassName()  
	call RestoreCursor()  
	let arg_list = GetArgList()  
	call RestoreCursor()  
	call JumpOtherFileEnd()
	let @a=printf("%s %s::%s%s{\n\n}" , fun_type,cls_type,fun_name,arg_list) 
	execute "normal! \"ap"
	let @/=""
endfunction
"}}}
function! PressEnter()"{{{当点击了\n的时候，进行一些处理
py3 << EOF
l,r = vim.current.window.cursor
if r > 0 and vim.current.line[r-1] == '{' and vim.current.line[r] == '}' : 
	vim.command('normal i\n\nOA\t')  # i \n \n <UP> \t <ESC>
else  : 
	vim.command('normal i\n')          # only \n
EOF
endfunction"}}}
"TRUE MAPPING
"nnoremap  <M-d> :call CreateFunctionImpliment()<cr>ji<tab>
"抓住函数名一定在函数面前,但是可能没有类型值,所以还要进行substitute一些特殊字符.
nnoremap  <M-d> "ayy?class<cr>w"bye<C-O><C-w>wG"apd0/(<cr>B"bPa::<esc>/)<cr>a<space><esc>d$:s/virtual \\|static //ge<cr>A{<cr><cr>}<up><tab>
nnoremap  <M-;> mqA;<esc>`q
nnoremap  <M-a> mqI//<esc>`q
nnoremap  <M-A> mq^2x<esc>`q
"注意这里lb或*N用来选中单词到开头,因为如果不这样,容易在恰好处在开头和结尾处出现问题;
nnoremap  <M-f> mflb"byw?class<cr>w"aye`f<C-w>w:call SearchClassFunctionDecline()<cr>n
inoremap  <M-;> <esc>lmqA;<esc>`qi
"inoremap  <cr>  <esc><left> :call PressEnter()<cr>i
"inoremap  {     <esc> :call PressBigBrace <cr>i
nnoremap  <M-s> :call CreateSetGetFunctionDeclare()<cr>
nnoremap  <M-F> :call SwitchSourceHeadFile()<cr>

"M-D声明函数定义的,.cpp和.h文件同时在一个tab中的两个windows"
"M-F声明函数定义的,寻找class中的函数,会粘和class::funname"
nnoremap  <C-@>g :YcmCompleter GoTo<cr>
nnoremap  <C-@>c :YcmCompleter GoToDeclaration<cr>
nnoremap  <C-@>d :YcmCompleter GoToDefinition<cr>
nnoremap  <C-@>i :YcmCompleter GoToInclude<cr>
nnoremap  <C-@>t :YcmCompleter GetType<cr>
nnoremap  <C-@>p :YcmCompleter GetParent<cr>

