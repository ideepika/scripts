" Unix installs needed before using neovim
"
" curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
" https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"
" create symbolic link to neovim
" ln -s ~/.vimrc ~/.config/nvim/init.vim
" usage:
" <f8> toggle colorschemes
" <f3> paste toggle
" <f6> nerdtree toggle

let mapleader = ","

" set UTF-8 encoding
set enc=utf-8
set fenc=utf-8
set termencoding=utf-8
"for console color capability
set t_Co=256

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
Plug 'neoclide/coc.nvim', {'branch': 'release'}
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

"vim autocomplete
autocmd FileType vim let b:vcm_tab_complete = 'vim'
  "mappings
  imap jk <esc>
noremap <Leader>y "*y
noremap <Leader>p "*p
noremap <Leader>Y "+y
noremap <Leader>P "+p`

"neococ
" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" create mappings for function text object, requires document symbols feature of languageserver.
xmap if <plug>(coc-funcobj-i)
xmap af <plug>(coc-funcobj-a)
omap if <plug>(coc-funcobj-i)
omap af <plug>(coc-funcobj-a)

" use <tab> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <tab> <plug>(coc-range-select)
xmap <silent> <tab> <plug>(coc-range-select)

"" use `:format` to format current buffer
"command! -nargs=0 format :call cocaction('format')

" use `:fold` to fold current buffer
"command! -nargs=? fold :call     cocaction('fold', <f-args>)

" use `:or` for organize import of current buffer
"command! -nargs=0 or   :call     cocaction('runcommand', 'editor.action.organizeimport')

" add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" change the color scheme from a list of color scheme names.
" version 2010-09-12 from http://vim.wikia.com/wiki/vimtip341
" press key:
"   f8                next scheme
"   shift-f8          previous scheme
"   alt-f8            random scheme
" set the list of color schemes used by the above (default is 'all'):
"   :setcolors all              (all $vimruntime/colors/*.vim)
"   :setcolors my               (names built into script)
"   :setcolors blue slate ron   (these schemes)
"   :setcolors                  (display current scheme names)
" set the current color scheme based on time of day:
"   :setcolors now
if v:version < 700 || exists('loaded_setcolors') || &cp
  finish
endif

let loaded_setcolors = 1
let s:mycolors = ['peachpuff', 'delek', 'badwolf']  " colorscheme names that we use to set color

" set list of color scheme names that we will use, except
" argument 'now' actually changes the current color scheme.
function! s:setcolors(args)
  if len(a:args) == 0
    echo 'current color scheme names:'
    let i = 0
    while i < len(s:mycolors)
      echo '  '.join(map(s:mycolors[i : i+4], 'printf("%-14s", v:val)'))
      let i += 5
    endwhile
  elseif a:args == 'all'
    let paths = split(globpath(&runtimepath, 'colors/*.vim'), "\n")
    let s:mycolors = uniq(sort(map(paths, 'fnamemodify(v:val, ":t:r")')))
    echo 'list of colors set from all installed color schemes'
  elseif a:args == 'my'
    let c1 = 'default elflord peachpuff desert256 breeze morning'
    let c2 = 'darkblue gothic aqua earth black_angus relaxedgreen'
    let c3 = 'darkblack freya motus impact less chocolateliquor'
    let s:mycolors = split(c1.' '.c2.' '.c3)
    echo 'list of colors set from built-in names'
  elseif a:args == 'now'
    call s:hourcolor()
  else
    let s:mycolors = split(a:args)
    echo 'list of colors set from argument (space-separated names)'
  endif
endfunction

command! -nargs=* setcolors call s:setcolors('<args>')

" set next/previous/random (how = 1/-1/0) color from our list of colors.
" the 'random' index is actually set from the current time in seconds.
" global (no 's:') so can easily call from command line.
function! nextcolor(how)
  call s:nextcolor(a:how, 1)
endfunction

" helper function for nextcolor(), allows echoing of the color name to be
" disabled.
function! s:nextcolor(how, echo_color)
  if len(s:mycolors) == 0
    call s:setcolors('all')
  endif
  if exists('g:colors_name')
    let current = index(s:mycolors, g:colors_name)
  else
    let current = -1
  endif
  let missing = []
  let how = a:how
  for i in range(len(s:mycolors))
    if how == 0
      let current = localtime() % len(s:mycolors)
      let how = 1  " in case random color does not exist
    else
      let current += how
      if !(0 <= current && current < len(s:mycolors))
        let current = (how>0 ? 0 : len(s:mycolors)-1)
      endif
    endif
    try
      execute 'colorscheme '.s:mycolors[current]
      break
    catch /e185:/
      call add(missing, s:mycolors[current])
    endtry
  endfor
  redraw
  if len(missing) > 0
    echo 'error: colorscheme not found:' join(missing)
  endif
  if (a:echo_color)
    echo g:colors_name
  endif
endfunction

nnoremap <f8> :call nextcolor(1)<cr>
nnoremap <s-f8> :call nextcolor(-1)<cr>
nnoremap <a-f8> :call nextcolor(0)<cr>
endfunction

"mappings
imap jk <esc>
