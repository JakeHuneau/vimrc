" Leader key
	let mapleader = ","

" Vundle stuff
	set nocompatible  " Lets use of new Vim features
	filetype off

	set rtp+=~/.vim/bundle/Vundle.vim
	call vundle#begin()

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
	Plugin 'vim-python/python-syntax' " Python Syntax better
	Plugin 'rust-lang/rust.vim' " Rust

	call vundle#end()
	filetype plugin indent on

" Basics
	set encoding=utf-8
	set backspace=indent,eol,start  " backspace will actually work

	set scrolloff=99  " Stay pretty centered in screen
	set splitbelow splitright " Always split under and to the right

	syntax on

" Disable automatic commenting on new line
	autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Automatically delete trailing whitespace
	autocmd BufWritePre * %s/\s\+$//e

" Line numbering. Set it so it's relative in navigation and absolute in insert
	set nu  " Line numbering on
	set number relativenumber
	augroup numbertoggle
	  autocmd!
	  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
	  autocmd BufLeave,FocusLost,InsertEnter * set norelativenumber
	augroup END

" Status line
	set statusline=%02n:%f\ Line\ %l\ Column\ %c\ %m
	set laststatus=2

" Grey guide line at 120
	set colorcolumn=120
	highlight ColorColumn ctermbg=8

" Enable folding and with space
	set foldmethod=indent
	set foldlevel=99
	nnoremap <space> za

" Filetypes
	autocmd BufNewFile,BufRead *.zsh-theme set syntax=sh
	autocmd BufNewFile,BufRead *.json set filetype=javascript
	autocmd BufNewFile,BufRead *.py
		    \ set tabstop=4 |
		    \ set softtabstop=4 |
		    \ set shiftwidth=4 |
		    \ set expandtab |
		    \ set autoindent |
		    \ set fileformat=unix

" Change copy to clipboard
	noremap <leader>y "*y
	noremap <leader>A ggVG"*y  " Copy entire file into clipboard

" Navigate to splits with Ctrl+direction
	nnoremap <C-J> <C-W><C-J>
	nnoremap <C-K> <C-W><C-K>
	nnoremap <C-L> <C-W><C-L>
	nnoremap <C-H> <C-W><C-H>

" Naviate between paragraphs and to start/end of line with shift+direction
	noremap K {
	noremap J }
	noremap H ^
	noremap L $

" Esc with jk or kj really fast
	imap jk <Esc>
	imap kj <Esc>

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

" ---PLUGINS---

" Python-Syntax
	let python_highlight_all=1

" Nerdtree
	map <leader>n :NERDTreeToggle<CR>
	let NERDTreeIgnore=['\.pyc$', '\~$']

" Jedi
	let g:jedi#goto_command = "<leader>g"
	let g:jedi#goto_assignment_command = "<leader>g"
	let g:jedi#goto_definitions_command = "<leader>g"
	let g:jedi#documentation_command = "<leader>h"
	let g:jedi#usages_command = "<leader>u"
	let g:jedi#rename_command = "<leader>r"
	let g:jedi#force_py_version = 3
	let g:jedi#show_call_signatures = "0"
	autocmd FileType python setlocal completeopt-=preview " no window on autocomplete

" Ale
	let g:ale_lint_on_enter = 0
	let g:ale_echo_msg_format = '[%linter%] %s'
	let g:ale_linters = {'python': ['flake8', 'pylint'], 'rust': ['cargo', 'rls']}
	let g:ale_python_flake8_options = '--ignore E501'
	let g:ale_python_pylint_options = '--disable C0301,R0913,W1203,R0914,C0103'
	let b:ale_fixers = {'rust': ['rustfmt']}
	let g:ale_fix_on_save = 1

" DelitMate
	au FileType python let b:delimitMate_nesting_quotes = ['"'] " auto triple quotes


" ---My Stuff---

" Grep in .py files in current project
	command -nargs=1 Pygrep vimgrep /<args>/gj ./*/*.py
