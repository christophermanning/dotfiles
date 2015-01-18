source ~/.vimrc.janus

" Set leader key to a backslash
let mapleader="\\"
let g:mapleader = "\\"

" Include Pathogen {
source ~/.vim/bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#infect()
call pathogen#helptags()

set background=dark

" sticky shift aliases
command WQ wq
command Wq wq
command Q q

" auto :Fmt for *.go files
autocmd FileType go autocmd BufWritePre <buffer> Fmt

" disable Ex mode shortcut
nnoremap Q <Nop>

filetype on
let g:tagbar_type_go = {
    \ 'ctagstype': 'go',
    \ 'kinds' : [
        \'p:package',
        \'f:function',
        \'v:variables',
        \'t:type',
        \'c:const'
    \]
\}

" disable swapfiles; they cause more trouble then they're worth
set noswapfile

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
