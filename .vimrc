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

" Simple default indent, ft indentation will override this most of the time
set autoindent

" Nuke tabs from orbit, replace with 4 spaces
set expandtab
set tabstop=4
set shiftwidth=4


set nohlsearch
set laststatus=2

set backspace=indent,eol,start

set gdefault

"Map shift-tab to inverse tab
inoremap <S-Tab> <C-d>

" Case insensitive search, if search string is all in lowercase
set ignorecase
set smartcase

set incsearch

" Tab navigation
map <C-t><up> :tabr<cr>
map <C-t><down> :tabl<cr>
map <C-t><left> :tabp<cr>
map <C-t><right> :tabn<cr>

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

" Git
Plug 'tpope/vim-fugitive'

" Clang autocomplete
Plug 'Rip-Rip/clang_complete'
let g:clang_library_path='/usr/lib/llvm-6.0/lib/libclang.so.1'

" Bazel
Plug 'google/vim-maktaba'
Plug 'bazelbuild/vim-bazel'

call plug#end()
"
" End of plugin loads
" "

" Clang-format
if empty(glob('~/.vim/clang-format.py'))
  silent !curl -fLo ~/.vim/clang-format.py --create-dirs
    \ https://llvm.org/svn/llvm-project/cfe/trunk/tools/clang-format/clang-format.py
endif
function! Formatonsave()
  let l:formatdiff = 1
  py3f ~/.vim/clang-format.py
endfunction
autocmd BufWritePre *.h,*.cc,*.cpp call Formatonsave()

map <C-K> :py3f ~/.vim/clang-format.py<cr>
imap <C-K> <c-o>:py3f ~/.vim/clang-format.py<cr>
