" =============================================================================
" Vim Configuration
" =============================================================================

set nocompatible
filetype off

" -----------------------------------------------------------------------------
" Plugin Manager: vim-plug (auto-install)
" -----------------------------------------------------------------------------
" Auto-install vim-plug if not present
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

call plug#begin('~/.vim/plugged')

" Core plugins
Plug 'tpope/vim-fugitive'           " Git integration
Plug 'airblade/vim-gitgutter'       " Git diff in gutter
Plug 'vim-airline/vim-airline'      " Status bar
Plug 'vim-airline/vim-airline-themes'

" File navigation
Plug 'preservim/nerdtree'           " File tree
Plug 'ctrlpvim/ctrlp.vim'           " Fuzzy finder

" Editor enhancement
Plug 'nathanaelkane/vim-indent-guides'
Plug 'blueyed/vim-diminactive'      " Dim inactive windows

" Syntax & Linting
Plug 'dense-analysis/ale'           " Async linting (syntastic replacement)

" Color schemes
Plug 'nanotech/jellybeans.vim'
Plug 'dracula/vim', { 'as': 'dracula' }

call plug#end()

filetype plugin indent on

" -----------------------------------------------------------------------------
" General Settings
" -----------------------------------------------------------------------------
set nu                      " Line numbers
set title                   " Window title
set showmatch               " Matching brackets
set ruler                   " Cursor position
set cursorline              " Highlight current line
set laststatus=2            " Always show status bar
set mouse-=a                " Disable mouse

" -----------------------------------------------------------------------------
" Colors & Syntax
" -----------------------------------------------------------------------------
if has("syntax")
  syntax on
endif
set t_Co=256
set background=dark

" Use jellybeans if available, fallback to default
try
  colorscheme jellybeans
catch
  " colorscheme not found, use default
endtry

" -----------------------------------------------------------------------------
" Encoding
" -----------------------------------------------------------------------------
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8

" -----------------------------------------------------------------------------
" Indentation
" -----------------------------------------------------------------------------
set autoindent
set smartindent
set tabstop=4
set shiftwidth=4
set softtabstop=4
set smarttab
set expandtab

" -----------------------------------------------------------------------------
" Search
" -----------------------------------------------------------------------------
set hlsearch                " Highlight search
set ignorecase              " Case insensitive
set smartcase               " Smart case (case-sensitive if uppercase)
set incsearch               " Incremental search

" -----------------------------------------------------------------------------
" Clipboard & Paste
" -----------------------------------------------------------------------------
set paste
set clipboard=unnamed       " Use system clipboard

" -----------------------------------------------------------------------------
" Plugin Configurations
" -----------------------------------------------------------------------------

" NERDTree
map <Leader>nt <ESC>:NERDTree<CR>
map <C-n> :NERDTreeToggle<CR>
let NERDTreeShowHidden=1
let NERDTreeIgnore=['\.git$', '\.DS_Store$', '__pycache__', '\.pyc$']

" CtrlP
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|node_modules\|vendor$',
  \ 'file': '\v\.(exe|so|dll|pyc|class)$'
\ }
let g:ctrlp_show_hidden = 1

" vim-diminactive
let g:diminactive_enable_focus = 1

" vim-indent-guides
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1
let g:indentguides_spacechar = '┆'
let g:indentguides_tabchar = '|'

" ALE (Linting)
let g:ale_linters_explicit = 1
let g:ale_fix_on_save = 0
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '⚠'

" Airline
let g:airline_powerline_fonts = 0
let g:airline#extensions#tabline#enabled = 1

" -----------------------------------------------------------------------------
" Key Mappings
" -----------------------------------------------------------------------------
" Window navigation
nmap <C-H> <C-W>h
nmap <C-J> <C-W>j
nmap <C-K> <C-W>k
nmap <C-L> <C-W>l

" Quick save
nmap <Leader>w :w<CR>

" Clear search highlight
nmap <Leader><Space> :nohlsearch<CR>

" -----------------------------------------------------------------------------
" Auto Commands
" -----------------------------------------------------------------------------
" Return to last edit position
au BufReadPost *
\ if line("'\"") > 0 && line("'\"") <= line("$") |
\ exe "norm g`\"" |
\ endif

" Markdown settings
augroup markdown
    autocmd!
    autocmd BufRead,BufNew *.md setf markdown
    autocmd FileType markdown setlocal wrap linebreak
augroup END

" Remove trailing whitespace on save
autocmd BufWritePre * :%s/\s\+$//e
