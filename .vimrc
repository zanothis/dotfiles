execute pathogen#infect()
syntax on
syntax enable
filetype on
filetype plugin indent on

set number

set laststatus=2
set encoding=utf-8
set relativenumber
set t_Co=256

set rtp+=/home/nathan/.vim/bundle/powerline/powerline/bindings/vim

set foldmethod=syntax
set foldlevel=99
set tabstop=4
set shiftwidth=4
set background=dark
set expandtab
set smarttab
colorscheme solarized

autocmd FileType python set nowrap
autocmd FileType javascript noremap <buffer> <c-k><c-d> :call JsBeautify()<cr>

let cwd = getcwd()
while !filereadable("index.js") && getcwd() != '/'
  :chdir ..
endwhile
if getcwd() == '/'
  exe ":chdir " . cwd
endif
autocmd FileType javascript vnoremap <C-f> "hy:vim /<C-r>=GetVisual()<CR>/gj ./**/*.js<CR>:copen<CR>

map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

map <leader>n :NERDTreeToggle<CR>
map <leader>t <Plug>TaskList

" When shifting, retain selection over multiple shifts...
vmap <expr> > KeepVisualSelection(">")
vmap <expr> < KeepVisualSelection("<")

function! KeepVisualSelection(cmd)
    set nosmartindent
    if mode() ==# "V"
        return a:cmd . ":set smartindent\<CR>gv"
    else
        return a:cmd . ":set smartindent\<CR>"
    endif
endfunction

map <leader>x :TlistToggle<CR>

" Escape special characters in a string for exact matching.
" This is useful to copying strings from the file to the search tool
" Based on this -
" http://peterodding.com/code/vim/profile/autoload/xolox/escape.vim
function! EscapeString (string)
  let string=a:string
  " Escape regex characters
  let string = escape(string, '^$.*\/~[]')
  " Escape the line endings
  let string = substitute(string, '\n', '\\n', 'g')
  return string
endfunction

" Get the current visual block for search and replaces
" This function passed the visual block through a string escape function
" Based on this - http://stackoverflow.com/questions/676600/vim-replace-selected-text/677918#677918
function! GetVisual() range
  " Save the current register and clipboard
  let reg_save = getreg('"')
  let regtype_save = getregtype('"')
  let cb_save = &clipboard
  set clipboard&

  " Put the current visual selection in the " register
  normal! ""gvy
  let selection = getreg('"')

  " Put the saved registers and clipboards back
  call setreg('"', reg_save, regtype_save)
  let &clipboard = cb_save

  " Escape any special characters in the selection
  let escaped_selection = EscapeString(selection)

  return escaped_selection
endfunction

" Start the find and replace command across the entire file
" vmap <leader>z <Esc>:%s/<c-r>=GetVisual()<cr>/
