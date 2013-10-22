execute pathogen#infect()
syntax on
syntax enable
filetype on
filetype plugin indent on

set laststatus=2
set encoding=utf-8

set rtp+="C:\Program Files (x86)\Vim\vim74\bundle\powerline\powerline\bindings\vim"

set foldmethod=syntax
set foldlevel=99
set tabstop=4
set shiftwidth=4
set background=dark
colorscheme solarized

autocmd FileType python set nowrap

map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

map <leader>n :NERDTreeToggle<CR>
map <leader>t <Plug>TaskList
