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
    Plugin 'scrooloose/nerdcommenter' " Commenting
    Plugin 'rust-lang/rust.vim' " Rust
    Plugin 'OmniSharp/omnisharp-vim' " C#
    Plugin 'SirVer/ultisnips'  " Snippets
    Plugin 'ctrlp.vim'  " fuzzy file search
    Plugin 'prabirshrestha/asyncomplete.vim'
    Plugin 'prabirshrestha/async.vim'
    Plugin 'janko/vim-test'
    Plugin 'mrk21/yaml-vim'
    Plugin 'mustache/vim-mustache-handlebars'
    Plugin 'hashivim/vim-terraform'  " Terraform

    call vundle#end()
    filetype plugin indent on

" Basics
    set encoding=utf-8
    set backspace=indent,eol,start  " backspace will actually work

    set scrolloff=99  " Stay pretty centered in screen
    set splitbelow splitright " Always split under and to the right

    syntax on


" New line without going into insert mode
    nnoremap <leader>o o<Esc>
    nnoremap <leader>O O<Esc>

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

" Enable folding and with space
    set foldmethod=indent
    set foldlevel=99
    nnoremap <space> za

" Filetypes
    filetype plugin indent on
    set tabstop=4  " existing tab is 4 spaces wide
    set shiftwidth=4 " indenting with > will be 4 spaces
    set expandtab  " pressing tab will make 4 spaces

    autocmd BufNewFile,BufRead *.zsh-theme set syntax=sh
    autocmd BufNewFile,BufRead *.json set filetype=javascript
    autocmd BufNewFile,BufRead *.py
        \ set tabstop=4 |
        \ set softtabstop=4 |
        \ set shiftwidth=4 |
        \ set expandtab |
        \ set autoindent |
        \ set fileformat=unix |
        \ set colorcolumn=120 |
        \ highlight ColorColumn ctermbg=8
    " Run the current python file and show result in terminal
    autocmd BufNewFile,BufRead *.py nnoremap <leader>c :w<CR>:exec '!python3' shellescape(@%, 1)<CR>

    autocmd BufNewFile,BufRead *.cs
        \ set tabstop=4 |
        \ set softtabstop=4 |
        \ set shiftwidth=4 |
        \ set expandtab |
        \ set autoindent |
                  inoremap <expr> <Tab> pumvisible() ? '<C-n>' : \ getline('.')[col('.')-2] =~# '[[:alnum:].-_#$]' ? '<C-x><C-o>' : '<Tab>'

    " Call 'dotnet run' and show result on terminal
    autocmd BufNewFile,BufRead *.cs nnoremap <leader>c :w<CR>:exec '!dotnet run' shellescape(@%, 1)<CR>

    " YAML
    au! BufNewFile,BufReadPost *.{yaml,yml} set filetype=yaml foldmethod=indent
    autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab


" Change copy to clipboard
    noremap <leader>y "*y
    noremap <leader>A ggVG"*y  " Copy entire file into clipboard

" Navigate to splits with Ctrl+direction
    nnoremap <C-J> <C-W><C-J>
    nnoremap <C-K> <C-W><C-K>
    nnoremap <C-L> <C-W><C-L>
    nnoremap <C-H> <C-W><C-H>

" Resize splits with arrow keys
    nnoremap <Left> <C-W><
    nnoremap <Right> <C-W>>
    nnoremap <Up>  <C-W>+
    nnoremap <Down> <C-W>-

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
    nnoremap <leader>pb :edit ~/Documents/temp/scrap.py<CR>

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
    let g:jedi#show_call_signatures = 1
    let g:jedi#show_call_signatures_delay = 20
    " Set text color for call signature
    hi jediFunction term=None cterm=None ctermfg=Black ctermbg=Magenta
    " Set current argument color with ctermfg
    hi jediFat term=bold cterm=bold ctermfg=White ctermbg=Magenta

" Ale
    let g:ale_lint_on_enter = 1
    let g:ale_echo_msg_format = '[%linter%] %s'
    let g:ale_linters = {'python': ['flake8', 'pylint'], 'rust': ['cargo', 'rls'], 'cs': ['OmniSharp']}
    let g:ale_python_flake8_options = '--ignore E501'
    let g:ale_python_pylint_options = '--disable C0301,R0913,W1203,R0914,C0103,W0703'
    let b:ale_fixers = {'rust': ['rustfmt']}
    let g:ale_fix_on_save = 1

" DelitMate
    au FileType python let b:delimitMate_nesting_quotes = ['"'] " auto triple quotes
    au FileType cs let b:delimitMate_expand_cr = 1

" OmniSharp
    let g:OmniSharp_server_stdio = 1 " Use server
    let g:OmniSharp_highlight_types = 2 " Better highlighting
    augroup omnisharp_commands
        autocmd!

        " The following commands are contextual, based on the cursor position.
        autocmd FileType cs nnoremap <buffer> <Leader>g :OmniSharpGotoDefinition<CR>
        autocmd FileType cs nnoremap <buffer> <Leader>fi :OmniSharpFindImplementations<CR>
        autocmd FileType cs nnoremap <buffer> <Leader>fs :OmniSharpFindSymbol<CR>
        autocmd FileType cs nnoremap <buffer> <Leader>fu :OmniSharpFindUsages<CR>

        " Finds members in the current buffer
        autocmd FileType cs nnoremap <buffer> <Leader>fm :OmniSharpFindMembers<CR>

        autocmd FileType cs nnoremap <buffer> <Leader>fx :OmniSharpFixUsings<CR>
        autocmd FileType cs nnoremap <buffer> <Leader>tt :OmniSharpTypeLookup<CR>
        autocmd FileType cs nnoremap <buffer> <Leader>h :OmniSharpDocumentation<CR>
        autocmd FileType cs nnoremap <buffer> <C-\> :OmniSharpSignatureHelp<CR>
        autocmd FileType cs inoremap <buffer> <C-\> <C-o>:OmniSharpSignatureHelp<CR>

        " Find all code errors/warnings for the current solution and populate the quickfix window
        autocmd FileType cs nnoremap <buffer> <Leader>cc :OmniSharpGlobalCodeCheck<CR>
    augroup END

    nnoremap <Leader>f :OmniSharpCodeFormat<CR>

" asyncomplete
    set completeopt=menuone,noinsert,noselect,preview
    let g:asyncomplete_auto_popup = 1
    let g:asyncomplete_auto_completeopt = 0
    let g:asyncomplete_force_refresh_on_context_changed = 1

    let g:OmniSharp_server_stdio = 1
    let g:OmniSharp_highlight_types = 2

    " if using ultisnips, set g:OmniSharp_want_snippet to 1
    let g:OmniSharp_want_snippet = 1
    let g:omnicomplete_fetch_full_documentation = 1

    " Close preview window after selecting
    autocmd CompleteDone * pclose

" Ultisnips
    " Avoid mapping conflicts
    let g:UltiSnipsRemoveSelectModeMappings = 0
    let g:UltiSnipsExpandTrigger = '<C-l>'
    let g:UltiSnipsJumpForwardTrigger = '<C-g>'
    let g:UltiSnipsJumpBackwardTrigger = '<C-t>'

" vim-test
    nmap <silent> <leader>tf :TestFile<CR>
    nmap <silent> <leader>ts :TestSuite<CR>

" ---My Stuff---

" Grep in .py files in current project
    command -nargs=1 Pygrep vimgrep /<args>/gj ./*/*.py

" Safe paste
    let &t_SI .= "\<Esc>[?2004h"
    let &t_EI .= "\<Esc>[?2004l"

    inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()

    function! XTermPasteBegin()
        set pastetoggle=<Esc>[201~
        set paste
        return ""
    endfunction

    " Indent json files on save
    autocmd FileType json autocmd BufWritePre <buffer> %!jq .
