set modelines=0              
set encoding=utf-8
set number
set smartindent
set autoindent
set smarttab
set tabstop=2
set shiftwidth=2
set expandtab
set cc=80
set splitright
set splitbelow               

set nobackup  
set noswapfile
set autoread

set nocompatible 
set ambiwidth=double
set vb t_vb=
set nowrap
set mouse=a
set mousehide
syntax on
filetype on

set sm!
set cursorline
set hlsearch
set showmatch
set ruler
set novisualbell
set showcmd

set completeopt=longest,menu
set backspace=indent,eol,start

set guioptions-=l
set guioptions-=L
set guioptions-=r
set guioptions-=R

set guioptions-=m
set guioptions-=T

set nofoldenable             

" 设置状态行-----------------------------------
" 设置状态行显示常用信息
" %F 完整文件路径名
" %m 当前缓冲被修改标记
" %m 当前缓冲只读标记
" %h 帮助缓冲标记
" %w 预览缓冲标记
" %Y 文件类型
" %b ASCII值
" %B 十六进制值
" %l 行数
" %v 列数
" %p 当前行数占总行数的的百分比
" %L 总行数
" %{...} 评估表达式的值，并用值代替
" %{"[fenc=".(&fenc==""?&enc:&fenc).((exists("+bomb") && &bomb)?"+":"")."]"} 显示文件编码
" %{&ff} 显示文件类型

set laststatus=2
set statusline=%1*%F%m%r%h%w%=\ %2*\ %Y\ %3*%{\"\".(\"\"?&enc:&fenc).((exists(\"+bomb\")\ &&\ &bomb)?\"+\":\"\").\"\"}\ %4*[%l,%v]\ %5*%p%%\ \|\ %6*%LL\  

" 设置netrw-------------------------------------
let g:netrw_banner = 1       "设置是否显示横幅
let g:netrw_liststyle = 3    "设置目录列表样式：树形
"let g:netrw_browse_split = 4 "在之前的窗口编辑文件
"let g:netrw_altv = 1         "水平分割时，文件浏览器始终显示在左边
"let g:netrw_winsize = 25     "设置文件浏览器窗口宽度为25%
"自动打开文件浏览器
"augroup ProjectDrawer
"    autocmd!
"    autocmd VimEnter * :Vexplore
"augroup END

nnoremap <C-n> :Lexplore<CR>    " 打开或关闭目录树

" 快捷键映射-------------------------------------
let mapleader=',' "leader映射','
inoremap <leader>w <Esc>:w<CR>  
inoremap jj <Esc>

" 运行对应文件的映射-----------------------------
map <F5> :call CompileRunGcc()<CR>
func! CompileRunGcc()
  exec "w"
  if &filetype == 'c'
    exec "!g++ % -o %<"
    exec "!time ./%<"
  elseif &filetype == 'cpp'
    exec "!g++ % -o %<"
    exec "!time ./%<"
  elseif &filetype == 'java'
    exec "!javac %"
    exec "!time java %<"
  elseif &filetype == 'sh'
    :!time bash %
  elseif &filetype == 'python'
    exec "!clear"
    exec "!time python3 %"
  elseif &filetype == 'html'
    exec "!time open % &"
  elseif &filetype == 'go'
    " exec "!go build %<"
    exec "!time go run %"
  elseif &filetype == 'javascript'
    exec "!clear"
    exec "!node %"
  elseif &filetype == 'mkd'
    exec "!~/.vim/markdown.pl % > %.html &"
    exec "!time open %.html &"
  endif
endfunc

