" Nathan Benjamin

" Launch Config {{{
    execute pathogen#infect()
    execute pathogen#runtime_append_all_bundles()
" }}}

" Colors {{{
    colorscheme solarized
    set background=dark
    set t_Co=256
" }}}

" Misc {{{
    set encoding=utf-8
    set modeline
    set modelines=1
    syntax on
    syntax enable
    filetype on
    filetype plugin indent on
" }}}

" Spaces & Tabs {{{
    set tabstop=4
    set shiftwidth=4
    set expandtab
    set smarttab
" }}}

" UI Layout {{{
    set number
    set relativenumber
    set cursorline
    "set lazyredraw
    set listchars=tab:⋗•,trail:•,nbsp:•
    set list
    set textwidth=80
    set colorcolumn=+1
" }}}

" Searching {{{
    set showmatch
    set incsearch
    set hlsearch
" }}}

" Folding {{{
    set foldenable
    set foldmethod=syntax
    set foldlevel=99
" }}}

" Custom Functions {{{
    " Tab completion
    " Will insert tab at beginning of line,
    " uses completion otherwise
    set wildmode=list:longest,list:full
    function! InsertTabWrapper()
        let col = col('.') - 1
        if !col || getline('.')[col - 1] !~ '\k'
            return "\<tab>"
        else
            return "\<c-p>"
        endif
    endfunction

    function! KeepVisualSelection(cmd)
        set nosmartindent
        if mode() ==# "V"
            return a:cmd . ":set smartindent\<CR>gv"
        else
            return a:cmd . ":set smartindent\<CR>"
        endif
    endfunction

    function! <SID>StripTrailingWhitespaces()
        " Preparation: save last search, and cursor position.
        let _s=@/
        let l = line(".")
        let c = col(".")
        " Do the business:
        %s/\s\+$//e
        " Clean up: restore previous search history, and cursor position
        let @/=_s
        call cursor(l, c)
    endfunction
" }}}

" Leader Shortcuts {{{
    let mapleader=","
    nnoremap <leader>s :SaveSession
    nnoremap <leader>a :Ag
    map <leader>n :NERDTreeToggle<CR>
    map <leader>t <Plug>TaskList
    map <leader>x :TlistToggle<CR>
" }}}

" Shortcuts {{{
    inoremap <Tab> <c-r>=InsertTabWrapper()<cr>
    inoremap <S-Tab> <c-n> "
    inoremap jk <esc>

    " Buffer movement
    map <c-j> <c-w>j
    map <c-k> <c-w>k
    map <c-l> <c-w>l
    map <c-h> <c-w>h

    nnoremap B ^
    nnoremap E $

    nnoremap ^ <nop>
    nnoremap $ <nop>

    nnoremap gV '[v']'

    " When shifting, retain selection over multiple shifts...
    vmap <expr> > KeepVisualSelection(">")
    vmap <expr> < KeepVisualSelection("<")
" }}}

" Powerline {{{
    set laststatus=2
    set rtp+=/home/nathan/.vim/bundle/powerline/powerline/bindings/vim
" }}}

" CtrlP {{{
    set rtp^=/home/nathan/.vim/bundle/ctrlp.vim
    let g:ctrlp_match_window = 'bottom,order:ttb'
    let g:ctrlp_switch_buffer = 0
    let g:ctrlp_working_path_mode = 0
    let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g'
" }}}

" Syntastic {{{
    let g:syntastic_check_on_open=1
" }}}

" Vim-Session {{{

" }}}

" AutoGroups {{{
    augroup configgroup
        autocmd!
        autocmd BufWritePre *.js,*.jsx
\            :call <SID>StripTrailingWhitespaces()
    augroup END
" }}}

autocmd FileType python set nowrap
autocmd FileType javascript noremap <buffer> <c-k><c-d> :call JsBeautify()<cr>

let g:jsx_ext_required = 0

" vim: foldmethod=marker:foldlevel=0
