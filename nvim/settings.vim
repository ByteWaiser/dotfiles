syntax on
set noerrorbells
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set autoindent
set nu
set rnu
set nowrap
set smartcase
set noswapfile
set nobackup
set undofile
set incsearch
set ttimeout
set ttimeoutlen=1
set colorcolumn=80
set background=dark


set termguicolors
let ayucolor="dark"
colorscheme ayu
hi Normal ctermbg=NONE guibg=NONE

let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_SR = "\<Esc>]50;CursorShape=2\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"
let mapleader = " "

nnoremap <leader>e :CocCommand explorer<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>
nnoremap <C-P> :!python % <CR>

