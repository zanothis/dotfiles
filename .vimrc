execute pathogen#infect()
syntax on
filetype on
filetype plugin indent on

set laststatus=2
set encoding=utf-8

set rtp+=/home/nathan/.vim/bundle/powerline/powerline/bindings/vim

set foldmethod=syntax
set foldlevel=99
set tabstop=4
set shiftwidth=4

autocmd FileType python set nowrap

map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-h>h

map <leader>n :NERDTreeToggle<CR>
