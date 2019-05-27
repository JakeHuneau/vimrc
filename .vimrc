set nocompatible              " required
filetype off                  " required

set encoding=utf-8
set nu " Line numbering
set backspace=indent,eol,start  " backspace will actually work

set scrolloff=25  " Stay pretty centered in screen
set splitbelow " Always split under
set splitright " Always split to the right

" Status line
set statusline=%02n:%f\ Line\ %l\ Column\ %c\ %m
set laststatus=2

" Guide line
set colorcolumn=120
highlight ColorColumn ctermbg=8

" Enable folding
set foldmethod=indent
set foldlevel=99

" Relative number stuff
set number relativenumber

augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter * set norelativenumber
augroup END

" Save all .swp files in ~/.vim/tmp/
set directory^=$HOME/.vim/tmp//

" Set leader key
let mapleader = ","

au BufNewFile,BufRead *.zsh-theme set syntax=sh

" PYTHON STUFF -------------
au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix

" KEY BINDS ----------------

" Change copy to clipboard
noremap <leader>y "*y
noremap <leader>A ggVG"*y  " Copy entire file into clipboard

" split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" better navigation
noremap K {
noremap J }
noremap H ^
noremap L $

" Esc with jk or kj really fast
imap jk <Esc>
imap kj <Esc>

" Enable folding with the spacebar
nnoremap <space> za

" Buffer stuff
nnoremap <leader>l :ls<CR>
nnoremap <leader>b :bp<CR>
nnoremap <leader>f :bn<CR>
nnoremap <leader><BS> :e#<CR>
nnoremap <leader>1 :1b<CR>
nnoremap <leader>2 :2b<CR>
nnoremap <leader>3 :3b<CR>
nnoremap <leader>4 :4b<CR>
nnoremap <leader>5 :5b<CR>
nnoremap <leader>6 :6b<CR>
nnoremap <leader>7 :7b<CR>
nnoremap <leader>8 :8b<CR>
nnoremap <leader>9 :9b<CR>

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" PLUGINS START ----------------

Plugin 'gmarik/Vundle.vim' " Package manager
Plugin 'tmhedberg/SimpylFold' " Better folds for python
Plugin 'vim-scripts/indentpython.vim' " Python indenting
Plugin 'tpope/vim-fugitive' " git
Plugin 'Raimondi/delimitMate' " automatic closing of quotes, parenthesis
Plugin 'yggdroot/indentline' " Show indent lines (useful for loops)
Plugin 'davidhalter/jedi-vim' " python autocompletion
Plugin 'ervandew/supertab' " <Tab> for code completion
Plugin 'scrooloose/nerdTree' " Documents tree
Plugin 'pearofducks/ansible-vim' " Ansible stuff
Plugin 'w0rp/ale' " Linting
Plugin 'rust-lang/rust.vim' " Rust

" PLUGINS END ----------------
call vundle#end()            " required
filetype plugin indent on    " required

let python_highlight_all=1
syntax on

" Open nerdtree
map <leader>n :NERDTreeToggle<CR>
let NERDTreeIgnore=['\.pyc$', '\~$']

" Jedi changes
let g:jedi#goto_command = "<leader>g"
let g:jedi#goto_assignment_command = "<leader>g"
let g:jedi#goto_definitions_command = "<leader>g"
let g:jedi#documentation_command = "<leader>h"
let g:jedi#usages_command = "<leader>u"
let g:jedi#rename_command = "<leader>r"

let g:ale_lint_on_enter = 0
let g:ale_echo_msg_format = '[%linter%] %s'
let g:ale_linters = {'python': ['flake8', 'pylint'], 'rust': ['cargo', 'rls']}
let b:ale_fixers = {'rust': ['rustfmt']}
let g:ale_fix_on_save = 1

let g:jedi#force_py_version = 3
au FileType python let b:delimitMate_nesting_quotes = ['"'] " auto triple quotes
autocmd FileType python setlocal completeopt-=preview " no window on autocomplete
let g:jedi#show_call_signatures = "0"

" My commands
command -nargs=1 Pygrep vimgrep /<args>/gj ./*/*.py
