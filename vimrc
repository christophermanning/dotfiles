call plug#begin()
Plug 'tpope/vim-sensible'
Plug 'rking/ag.vim'
Plug 'kien/ctrlp.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'ervandew/supertab'
Plug 'scrooloose/syntastic'
Plug 'kchmck/vim-coffee-script'
Plug 'altercation/vim-colors-solarized'
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-repeat'
Plug 'vim-ruby/vim-ruby'
Plug 'matze/vim-move'
Plug 'bronson/vim-trailing-whitespace'
Plug 'fatih/vim-go'
Plug 'sjl/gundo.vim'
call plug#end()

source ~/.vimrc.janus

" Set leader key to a backslash
let mapleader="\\"
let g:mapleader = "\\"

set background=dark

" sticky shift aliases
command W w
command WQ wq
command Wq wq
command Q q
command Qa qa

" disable Ex mode shortcut
nnoremap Q <Nop>

" disable swapfiles; they cause more trouble then they're worth
set noswapfile

" maintain indentaion when adding a new line
set smartindent
set autoindent
filetype indent on

" Tell CtrlP to ignore certain files and directories
let g:ctrlp_custom_ignore = {
    \ 'dir':  'node_modules$\|\.git$\|\_site$',
    \ 'file': '\.DS_Store$\|\.jpg$\|\.png$\|\.jpeg$\|\jpeg.gif$\|\.svg$'
    \ }

" ESC should clear highlighted search terms
nnoremap <CR> :noh<CR><CR>

" NERDTree
map <leader>n :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" vim-move
let g:move_key_modifier = 'C'

" NERDCommenter
filetype plugin on

" vim-move prevent indentation of blocks from getting lost
let g:move_auto_indent = 0

" faster ctrlp
let g:ctrlp_user_command = 'ag %s -i --nocolor --nogroup --hidden --ignore .git -g ""'"

" vim-go
let g:go_fmt_command="goimports"
