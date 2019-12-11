" Unix installs needed before using neovim
"
" curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
" https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"
" create symbolic link to neovim
" ln -s ~/.vimrc ~/.config/nvim/init.vim

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

" toggle autoindent for paste
set pastetoggle=<F3>
set clipboard=unnamedplus

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
"Plug 'neoclide/coc'
Plug 'scrooloose/syntastic'
Plug 'christoomey/vim-tmux-navigator'
Plug 'vim-scripts/cscope.vim'
Plug 'vhdirk/vim-cmake'
call plug#end()

"theme setup
syntax enable			" I have no idea what this actually does
set background=dark
colorscheme gruvbox

"ctags specification
"searches tags in cur_dir, a dir above and it's sub_dir
set tags=./tags,./../tags,./*/tags

"set vimairline
let g:airline#extensions#tabline#enabled = 1
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



set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*


set wildignore+=*.o,*.out,*.obj
set wildignore+=*.dll,*.exe
set wildignore+=*.pyc,*.pyo
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz,*.7z
set wildignore+=*.png,*.gif,*.jpg,*.jpeg,*.bmp,*.tiff
set wildignore+=*.swp
set wildignore+=.DS_Store

if has('spell')
  set spelllang=en_us
endif

let g:syntastic_check_on_open=1
let g:syntastic_enable_signs=1

"Tab for buffer, and s-tab to switch buffer
tnoremap <Tab> <C-\><C-n>:bn<CR>
tnoremap <S-Tab> <C-\><C-n>:bp<CR>

"remove trailing spaces
autocmd BufWritePre * :%s/\s\+$//e

" Show trailing whitepace and spaces before a tab:
:highlight ExtraWhitespace ctermbg=red guibg=red
:autocmd Syntax * syn match ExtraWhitespace /\s\+$\| \+\ze\t/

"check commit limit
au FileType gitcommit setlocal tw=72

set backspace=indent,eol,start
set clipboard+=unnamedplus

"nerdtree toggle
nmap <F6> :NERDTreeToggle<CR>
function! CtrlPCommand()
    let c = 0
    let wincount = winnr('$')
    " Don't open it here if current buffer is not writable (e.g. NERDTree)
    while !empty(getbufvar(+expand("<abuf>"), "&buftype")) && c < wincount
        exec 'wincmd w'
        let c = c + 1
    endwhile
    exec 'CtrlP'
endfunction

let g:ctrlp_cmd = 'call CtrlPCommand()'

"for jumping buffer
let c = 1
while c <= 99
  execute "nnoremap " . c . "gb :" . c . "b\<CR>"
  let c += 1
endwhile
