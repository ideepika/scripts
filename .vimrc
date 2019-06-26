let mapleader = ","

" set UTF-8 encoding
set enc=utf-8
set fenc=utf-8
set termencoding=utf-8

" disable vi compatibility 
set nocompatible

filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=8
"" when indenting with '>', use 4 spaces width
set shiftwidth=2
"" On pressing tab, insert 4 spaces
""set expandtab
set smarttab     " expand tabs to spaces
""soft wrapping
set wrap lbr nolist

set textwidth=80 
set number
set ignorecase
"" Include only uppercase words with uppercase search term 
set smartcase 
set showmatch " highlight matching braces
set nohlsearch

"for autoformatting 
noremap <F4> :Autoformat<CR>
let g:autoformat_autoindent = 0
let g:autoformat_retab = 0
let g:autoformat_remove_trailing_spaces = 0

" toggle autoindent for paste
set pastetoggle=<F3>
set clipboard=unnamedplus

 " use ,y/,p for 
"noremap <Leader>y "+y
"noremap <Leader>p "+p
"noremap <Leader>Y "*y
"noremap <Leader>P "*p

"open netrw folders on left instead of right
let g:netrw_altv=1

"set directory style to tree
let g:netrw_liststyle = 3

"remove banner view from directory listing
let g:netrw_banner = 0

"set the width of netrw to 25%
let g:netrw_winsize = 25

"Vim-Plug plugins
call plug#begin('~/.vim/plugged')
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'editorconfig/editorconfig-vim'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'mattn/emmet-vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-surround'
Plug 'w0rp/ale'
Plug 'flazz/vim-colorschemes'
Plug 'rhysd/vim-clang-format'
"Plug 'jceb/vim-orgmode'
Plug 'majutsushi/tagbar'
"cpp man pages
Plug 'gauteh/vim-cppman'
"fuzzy search files
Plug 'kien/ctrlp.vim'
Plug 'wesleyche/SrcExpl'
"Learn sometime else
Plug 'vim-scripts/Conque-GDB'
Plug 'Chiel92/vim-autoformat'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Chiel92/vim-autoformat'
Plug 'scrooloose/nerdtree'
call plug#end()

"theme setup
syntax enable			" I have no idea what this actually does
set background=dark
colorscheme DimGreen

"ctags specification
"searches tags in cur_dir, a dir above and it's sub_dir
set tags=./tags,./../tags,./*/tags

"set vimairline
let g:airline#extensions#tabline#enabled = 1
let g:deoplete#enable_at_startup = 1

"setting ctrlP, use ctrl-P to fuzzy search any file
let g:ctrlp_map = '<c-p>'

"remember to create undo folder, won't persist without it
if has('persistent_undo')      "check if your vim version supports it
  set undofile                 "turn on the feature
  set undodir=$HOME/.vim/undo  "directory where the undo files will be stored
  endif

"cscope shortcuts
nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>	
nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>	
nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>	
nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>	
nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>	
nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>	
nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>
"disable ex mode
:map Q <Nop>

if has("cscope")
    """"""""""""" Standard cscope/vim boilerplate
    " use both cscope and ctag for 'ctrl-]', ':ta', and 'vim -t'
    set cscopetag
    " check cscope for definition of a symbol before checking ctags: set to 1
    " if you want the reverse search order.
    set csto=0
    " add any cscope database in current directory
    if filereadable("cscope.out")
        cscope add cscope.out
    " else add the database pointed to by environment variable 
    elseif $CSCOPE_DB != ""
        cs add $CSCOPE_DB
    endif
    " show msg when any other cscope db added
    set cscopeverbose
endif


"autoreload vim 
augroup myvimrchooks
    au!
    autocmd bufwritepost .vimrc source ~/.vimrc
  augroup END

let g:clang_format#style_options = {
            \ "AccessModifierOffset" : -4,
            \ "AllowShortIfStatementsOnASingleLine" : "true",
            \ "AlwaysBreakTemplateDeclarations" : "true",
            \ "Standard" : "C++11"}

" map to <Leader>cf in C++ code
autocmd FileType c,cpp,objc nnoremap <buffer><Leader>cf :<C-u>ClangFormat<CR>
autocmd FileType c,cpp,objc vnoremap <buffer><Leader>cf :ClangFormat<CR>
" if you install vim-operator-user
autocmd FileType c,cpp,objc,cc,h map <buffer><Leader>x <Plug>(operator-clang-format)
" Toggle auto formatting:
nmap <Leader>C :ClangFormatAutoToggle<CR>

"Toggle tagbar
nmap <F8> :TagbarToggle<CR>

map <F2> :NERDTreeToggle<CR>
