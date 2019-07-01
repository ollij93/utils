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

" Darcula Color Scheme
if empty(glob('~/.vim/colors/darcula.vim'))
  silent !curl -fLo ~/.vim/colors/darcula.vim --create-dirs
    \ https://raw.githubusercontent.com/blueshirts/darcula/master/colors/darcula.vim
endif
color darcula

" Plugin manager
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" "
" Individual plugins
"
call plug#begin('~/.vim/plugged')

" Fuzzy finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
map ; :Files<CR>

" Status bar
Plug 'itchyny/lightline.vim'
set noshowmode

" NERDTree
Plug 'scrooloose/nerdtree'
map <C-o> :NERDTreeToggle<CR>

" Clang autocomplete
Plug 'Rip-Rip/clang_complete'
let g:clang_library_path='/usr/lib/llvm-6.0/lib/libclang.so.1'

call plug#end()
"
" End of plugin loads
" "

