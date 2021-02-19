if !has('nvim')
  " Auto install vim-plug
  if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  endif
endif

if has('nvim')
  " Auto install vim-plug
  if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
    silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  endif
endif

if has('nvim')
  let g:python3_host_prog = '/usr/bin/python3'
endif

syntax on

" vim plugins
call plug#begin()
Plug 'tomasiser/vim-code-dark'
Plug 'speshak/vim-cfn'
Plug 'mechatroner/rainbow_csv'
Plug 'AndrewRadev/switch.vim'
Plug 'airblade/vim-gitgutter'
Plug 'jiangmiao/auto-pairs'
Plug 'scrooloose/nerdtree'
Plug 'machakann/vim-highlightedyank'
Plug 'mhinz/vim-startify'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-syntastic/syntastic'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'Yggdroot/indentLine'
Plug 'sheerun/vim-polyglot'
Plug 'ntpeters/vim-better-whitespace'
Plug 'pearofducks/ansible-vim'
Plug 'godlygeek/tabular'
Plug 'noahfrederick/vim-skeleton'
Plug 'editorconfig/editorconfig-vim'
Plug 'zhou13/vim-easyescape'
Plug 'inkarkat/vim-SyntaxRange'
Plug 'cespare/vim-toml'
Plug 'luochen1990/rainbow'
Plug 'editorconfig/editorconfig-vim'
Plug 'rhysd/git-messenger.vim'
Plug 'neoclide/coc.nvim'
Plug 'kassio/neoterm'
call plug#end()

" Disable mouse in vim
set mouse=

" show matching brackets
set showmatch

" Enable folding by default
set foldmethod=indent
set foldopen=search

if line ('$') > 300
	set foldlevel=1
endif

" Set smartcase
set ignorecase
set smartcase

" Disable beeps
set visualbell

" Show line numbers
set number

" Hybrid relative line numbers
" https://jeffkreeftmeijer.com/vim-number/
" :set number relativenumber

" Set colorscheme to default of SpaceVim
colorscheme codedark
set background=dark
let g:airline_theme='codedark'

" json don't conceal syntax
let g:vim_json_syntax_conceal = 0

" Time to highlight yanked stuff
let g:highlightedyank_highlight_duration = 5000

" column width indicator
set colorcolumn=80

set cursorline

" Multiple indexing
xnoremap < <gv
xnoremap > >gv

" NerdTree auto-open
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
map <C-n> :NERDTreeToggle<CR>

" json don't conceal syntax
let g:vim_json_syntax_conceal = 0

set nocompatible
set autoindent

if has('syntax')
  syntax enable
endif

" Without this vim-polyglot will use yaml rather than Ansible in most cases
" let g:polyglot_disabled = ['yaml', 'ansible']

set smartindent

set expandtab
set sw=2
set ts=2

if exists('&signcolumn')  " Vim 7.4.2201
  set signcolumn=yes
else
  let g:gitgutter_sign_column_always = 1
endif

" Git interactive rebase Strings
" https://github.com/AndrewRadev/switch.vim/wiki/Git-interactive-rebase-Strings
autocmd FileType gitrebase let b:switch_custom_definitions =
    \ [
    \   [ 'pick', 'fixup', 'reword', 'squash', 'edit', 'exec' ]
    \ ]

" Syntastic settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_cloudformation_checkers = ['cfn_lint']

"Disable markdown conceal
let g:vim_markdown_conceal = 0
let g:vim_markdown_conceal_code_blocks = 0

filetype plugin indent on

set undofile
silent !mkdir ~/.vim/undodir > /dev/null 2>&1
set undodir=~/.vim/undodir

au BufRead,BufNewFile *.yml set filetype=yaml.ansible
autocmd FileType yaml,cloudformation call SyntaxRange#Include('#beginpython', '#endpython', 'python', 'NonText')

" Enable rainbow parens
let g:rainbow_active = 1

let g:syntastic_javascript_checkers = ['eslint']

source $HOME/.config/nvim/plug-config/coc.vim
