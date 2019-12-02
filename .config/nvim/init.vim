set directory=~/.vim/backup
set backupdir=~/.vim/backup " keep swap files here
filetype off                " required

call plug#begin('~/.local/share/nvim/plugged')                    " you need to create this directory first (or change it)

Plug 'vim-airline/vim-airline'                                    " bottom status bar
Plug 'vim-airline/vim-airline-themes'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } " fuzzy finder conf
Plug 'junegunn/fzf.vim'                                           " fuzzy finder
Plug 'scrooloose/nerdtree'                                        " folders tree
Plug 'neomake/neomake'                                            " run programs asynchronously and highlight errors
Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}        " LSP client + autocompletion plugin
Plug 'itchyny/lightline.vim'                                      " configurable status line (can be used by coc)
Plug 'Xuyuanp/nerdtree-git-plugin'                                " shows files git status on the NerdTree
Plug 'airblade/vim-gitgutter'                                     " Git diffs in gutter
Plug 'mg979/vim-visual-multi'                                     " Multiple cursors selection

" Haskell
Plug 'alx741/vim-stylishask'                                      " Call stylish-haskell on file save

" Unison
Plug 'unisonweb/unison', { 'rtp': 'editor-support/vim' }

" Beauty plugin
Plug 'kien/rainbow_parentheses.vim'                               " for nested parentheses
Plug 'dracula/vim'                                                " Dracula color theme

" Possibly useful plugins
"Plug 'scrooloose/nerdcommenter'                                   " code commenter
"Plug 'Twinside/vim-hoogle'                                        " Hoogle search (Haskell) in Vim
"Plug 'vmchale/dhall-vim'                                          " Syntax highlighting for Dhall lang

call plug#end()

" End of plugins here
" ===================

" airline: status bar at the bottom
let g:airline_powerline_fonts=1

let g:airline_section_error = '%{airline#util#wrap(airline#extensions#coc#get_error(),0)}'
let g:airline_section_warning = '%{airline#util#wrap(airline#extensions#coc#get_warning(),0)}'

" Highlighting for jsonc filetype
autocmd FileType json syntax match Comment +\/\/.\+$+

" Nerd commenter
filetype plugin on

" Better Unix support
set viewoptions=folds,options,cursor,unix,slash
set encoding=utf-8

"""""""""""""""""""""""""""
" Spacemacs migration guide
"""""""""""""""""""""""""""

" Creating split screens
nnoremap <C-x>3 <C-w>v
nnoremap <C-x>2 <C-w>s
nnoremap <C-x>0 <C-w>q

" Cycle through splits
nnoremap <C-x>o <C-w>w

" Buffers manipulation
nnoremap <silent> <C-x>k :bd<CR>
nnoremap <silent> <C-l> :bn<CR>
nnoremap <silent> <C-h> :bp<CR>

" Clear search highlighting
nnoremap <C-z> :nohlsearch<CR>

" Nerdtree git plugin symbols
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "ᵐ",
    \ "Staged"    : "ˢ",
    \ "Untracked" : "ᵘ",
    \ "Renamed"   : "ʳ",
    \ "Unmerged"  : "ᶴ",
    \ "Deleted"   : "ˣ",
    \ "Dirty"     : "˜",
    \ "Clean"     : "ᵅ",
    \ "Unknown"   : "?"
    \ }

function! TrimWhitespace()
    let l:save_cursor = getpos('.')
    %s/\s\+$//e
    call setpos('.', l:save_cursor)
endfun

command! TrimWhitespace call TrimWhitespace() " Trim whitespace with command
" autocmd BufWritePre * :call TrimWhitespace()  " Trim whitespace on every save
" autocmd InsertLeave * write                   " Save buffer automatically on leaving insert mode

augroup format-haskell
    autocmd!
    autocmd InsertLeave *.hs call stylishask#StylishaskOnSave()
    autocmd InsertLeave * :call TrimWhitespace()  " Trim whitespace on every save
    autocmd InsertLeave * write                   " Save buffer automatically on leaving insert mode
augroup END

"    Nerdtree
map <C-F> :NERDTreeToggle<CR>
map <C-S> :NERDTreeFind<CR>


" Other options
let mapleader=','
set backspace=2
colorscheme dracula
" colorscheme torte
syntax on
set shell=/bin/bash
set laststatus=2
set noshowmode

" Fixes broken cursor on Linux
set guicursor=

" NerdTree config
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
let NERDTreeShowHidden=1

let g:NERDTreeMinimalUI = 1
let g:NERDTreeDirArrows = 1

""""""""""""""""""""""""""
""" General editor options
""""""""""""""""""""""""""

" Auto wrap options
set formatoptions=qnlj  " convenient wrapping options
set textwidth=80        " wrap on 80 chars

" Other editor options
set hidden                  " Hide files when leaving them.
set number                  " Show line numbers.
set numberwidth=1           " Minimum line number column width.
set cmdheight=2             " Number of screen lines to use for the commandline.
set linebreak               " Don't cut lines in the middle of a word .
set showmatch               " Shows matching parenthesis.
set matchtime=2             " Time during which the matching parenthesis is shown.
set background=dark         " Color adapted to dark background.
set listchars=tab:▸\ ,eol:¬ " Invisible characters representation when :set list.
set clipboard=unnamedplus   " Copy/Paste to/from clipboard
set cursorline              " Highlight line cursor is currently on
set completeopt+=noinsert   " Select the first item of popup menu automatically without inserting it

" Fancy highlight of the current line
hi CursorLine term=bold cterm=bold guibg=Grey40

" More natural screen splittin
set splitbelow
set splitright

" Search
set incsearch  " Incremental search.
set ignorecase " Case insensitive.
set smartcase  " Case insensitive if no uppercase letter in pattern, case sensitive otherwise.
set nowrapscan " Don't go back to first match after the last match is found.

" Tabs
set expandtab     " Tab transformed in spaces
set tabstop=2     " Sets tab character to correspond to x columns.
                  " x spaces are automatically converted to <tab>.
                  " If expandtab option is on each <tab> character is converted to x spaces.
set softtabstop=2 " column offset when PRESSING the tab key or the backspace key.
set shiftwidth=2  " column offset when using keys '>' and '<' in normal mode.

" Toggle display of tabs and EOF
nnoremap <leader>l :set list!<CR>

" Fuzzy finder shortcut
nnoremap <C-p> :FZF<CR>

" Disable arrow keys and page up / down
" noremap <Up> <nop>
" noremap <Down> <nop>
" noremap <Left> <nop>
" noremap <Right> <nop>
" inoremap <Up> <nop>
" inoremap <Down> <nop>
" inoremap <Left> <nop>
" inoremap <Right> <nop>
" vnoremap <Up> <nop>
" vnoremap <Down> <nop>
" vnoremap <Left> <nop>
" vnoremap <Right> <nop>
" noremap <PageUp> <nop>
" inoremap <PageUp> <nop>
" vnoremap <PageUp> <nop>
" noremap <PageDown> <nop>
" inoremap <PageDown> <nop>
" vnoremap <PageDown> <nop>

" Disable mouse / touchpad (only in vim)
set mouse=nicr
inoremap <ScrollWheelUp> <nop>
inoremap <S-ScrollWheelUp> <nop>
inoremap <C-ScrollWheelUp> <nop>
inoremap <ScrollWheelDown> <nop>
inoremap <S-ScrollWheelDown> <nop>
inoremap <C-ScrollWheelDown> <nop>
inoremap <ScrollWheelLeft> <nop>
inoremap <S-ScrollWheelLeft> <nop>
inoremap <C-ScrollWheelLeft> <nop>
inoremap <ScrollWheelRight> <nop>
inoremap <S-ScrollWheelRight> <nop>
inoremap <C-ScrollWheelRight> <nop>

" ------------------- COC config -----------------------

" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Some server have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

" Use <c-space> for trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Close preview window after completion is done
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

" Use <cr> to select first option and confirm completion
" `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
    \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" inoremap <expr> <cr> pumvisible() ? '<C-n>' :
"   \ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
