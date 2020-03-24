" Tab autocompletion
function InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction

imap <TAB> <C-r>=InsertTabWrapper()<CR>
set complete=.,k,b,t

"<<<
set encoding=utf-8
set nocompatible
">>>

set ttyfast
set nomodeline

filetype plugin indent on

"<<<
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
">>>

set ruler
set relativenumber
set mouse=a

set undofile

nnoremap / /\v
vnoremap / /\v
set ignorecase
set smartcase
set gdefault
set incsearch
set showmatch
set hlsearch

set wrap
set textwidth=79
set formatoptions=qrn1
set colorcolumn=80

set list
set listchars=tab:▸\ ,eol:¬

"<<<
nnoremap j gj
nnoremap k gk
">>>

inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

nnoremap ; :

set viminfo='20,\"50
set history=50

set autowrite
set guioptions=aegirL

syntax on

set cursorline
hi CursorLine term=bold cterm=bold guibg=Grey40
