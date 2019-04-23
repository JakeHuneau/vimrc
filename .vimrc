set nocompatible              " required
filetype off                  " required

set encoding=utf-8
set nu " Line numbering
set backspace=indent,eol,start  " backspace

:set scrolloff=15  " Stay pretty centered in screen
set splitbelow " Always split under
set splitright " Always split to the right

" Enable folding
set foldmethod=indent
set foldlevel=99

" Set leader key
let mapleader = ","

" PYTHON STUFF -------------
au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix

" KEY BINDS ----------------

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


" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" PLUGINS START ----------------

Plugin 'gmarik/Vundle.vim' " Package manager
Plugin 'tmhedberg/SimpylFold' " Better folds for python
Plugin 'vim-scripts/indentpython.vim' " Python indenting
Plugin 'vim-syntastic/syntastic' " syntax
Plugin 'tpope/vim-fugitive' " git
Plugin 'Raimondi/delimitMate' " automatic closing of quotes, parenthesis
Plugin 'yggdroot/indentline' " Show indent lines (useful for loops)
Plugin 'davidhalter/jedi-vim' " python autocompletion
Plugin 'ervandew/supertab' " <Tab> for code completion
Plugin 'scrooloose/nerdTree' " Documents tree

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

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_python_checkers = ['pylint']

let g:jedi#force_py_version = 3
au FileType python let b:delimitMate_nesting_quotes = ['"'] " auto triple quotes
autocmd FileType python setlocal completeopt-=preview " no window on autocomplete
let g:jedi#show_call_signatures = "0"
