" Vundle plugin
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" All plugins available here https://vimawesome.com
Plugin 'VundleVim/Vundle.vim'
Plugin 'sgur/vim-editorconfig'
Plugin 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plugin 'vim-scripts/AutoComplPop'
Plugin 'scrooloose/syntastic'
Plugin 'jiangmiao/auto-pairs'
Plugin 'vim-ruby/vim-ruby'
Plugin 'tpope/vim-fugitive'
Plugin 'kien/ctrlp.vim'
Plugin 'tpope/vim-rails'
Plugin 'mattn/emmet-vim'
Plugin 'cakebaker/scss-syntax.vim'
Plugin 'posva/vim-vue'
Plugin 'dracula/vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'
Plugin 'kchmck/vim-coffee-script'
Plugin 'leafgarland/typescript-vim'
Plugin 'udalov/kotlin-vim'
Plugin 'dart-lang/dart-vim-plugin'
Plugin 'fatih/vim-go'
Plugin 'evanleck/vim-svelte'
call vundle#end()
filetype plugin indent on


syntax on
color dracula
set number
set nocompatible
set cursorline
set wrap
set encoding=utf-8
set hlsearch
set incsearch
set ignorecase
set termencoding=utf-8
set smartcase
set autoindent
set smartindent
set history=120
set undolevels=1024
set undodir=~/.vim/undodir/
set undofile
set undoreload=10000
set fileformat=unix
set fileencoding=utf-8
set expandtab
set tabstop=2
set shiftwidth=2
set backupdir=/tmp//
set directory=/tmp//
set undodir=/tmp//
set backspace=indent,eol,start


" Mapping keys
map <C-n> :NERDTreeToggle<CR>
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>
noremap <PageUp> <NOP>
noremap <PageDown> <NOP>


" Ruby on Rails
autocmd BufRead,BufNewFile *.es6.erb set syntax=javascript
autocmd BufRead,BufNewFile *.es6.erb set filetype=javascript


" SailsJS
autocmd BufRead,BufNewFile *.ejs set syntax=html
autocmd BufRead,BufNewFile *.ejs set filetype=html


" ReactJS JSX
let g:jsx_ext_required = 0
let g:jsx_pragma_required = 0

" Svelte
autocmd BufRead,BufNewFile *.svelte set filetype=svelte
let g:svelte_indent_script = 0
let g:svelte_indent_style = 0
let g:svelte_preprocessors = ['typescript']

