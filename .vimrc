syntax enable

filetype plugin indent on

set number

set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8

set shortmess=at

set noerrorbells
set novisualbell

set title

set display+=lastline

" Simple defualt indent, ft indentation will override this most of the time
set autoindent

" Nuke tabs from orbit, replace with 4 spaces
set expandtab
set tabstop=4
set shiftwidth=4


set nohlsearch
set laststatus=2

set backspace=indent,eol,start

set gdefault

" Case insensitive search, if search string is all in lowercase
set ignorecase
set smartcase

set incsearch



" Allow repeated shifting in visual mode
vnoremap < <gv
vnoremap > >gv
vnoremap <Left> <gv
vnoremap <Right> >gv

" Remap enter to save in normal mode if it makes sense in this buffer
nnoremap <expr> <cr> &buftype=="" ? ":w<cr>" : "<cr>"

" colors
colorscheme desert
