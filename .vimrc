set nocompatible
set rtp+=~/.vim/bundle/vundle/
set encoding=utf-8
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'https://github.com/scrooloose/nerdtree'
Bundle 'taglist.vim'
Bundle 'https://github.com/Shougo/neocomplete.vim'
Bundle 'https://github.com/tomasr/molokai'
Bundle 'https://github.com/vim-airline/vim-airline'
Bundle 'https://github.com/kien/ctrlp.vim'
Bundle 'https://github.com/Valloric/YouCompleteMe'
Bundle 'https://github.com/Raimondi/delimitMate'


if has("cscope")
  set cscopeprg=/usr/bin/gtags-cscope
  set csto=0
  set cst
  set nocsverb
  " add any database in current directory
  if filereadable("GTAGS")
      cs add GTAGS
  endif
  set csverb
endif

"nmap <C-@>a :cs find a <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>
nmap <F5> :NERDTreeToggle<cr>
nmap <F6> :TlistToggle<cr>

if has ("syntax")
  syntax on
endif

filetype detect

set autoindent
set ts=4
set expandtab
set shiftwidth=4
" 使用>> << 和 ctrl-T ctrl-D 0 ctrl-D 来缩进和反缩进
set nowrap
set hlsearch
set backspace=indent,eol,start whichwrap+=<,>,[,]

set ofu=syntaxcomplete#Complete


set mouse=a

" option for foldmethod
set fdm=marker
set foldcolumn=1

colorscheme molokai
source ~/Important/MyVim/_MY_VIM_/AltKeyStart.vimrc
source ~/Important/MyVim/_MY_VIM_/WindowTabeSwitch.vimrc
if (or(&filetype == 'c',&filetype=='cpp'))
	source ~/Important/MyVim/_MY_VIM_/VimCpp.vimrc
elseif (&filetype == 'vim')
	set commentstring=\"%s
elseif (&filetype == 'python')
    set commentstring=#%s
    source ~/Important/MyVim/_MY_VIM_/VimPython.vimrc
end

map gs :w<cr>
map <space>r :redraw!<cr>
" nmap o  i<cr>
" options for delimitMate
let delimitMate_expand_cr = 1
let delimitMate_expand_space = 1

