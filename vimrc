" {{{ GET PLUGINS
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source ~/.vimrc
endif

call plug#begin('~/.vim/bundle')
    Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
    Plug 'morhetz/gruvbox'                      " color scheme
    Plug 'itchyny/lightline.vim'                " bottom info bar
    Plug 'airblade/vim-gitgutter'               " git info on left bar
    Plug 'tpope/vim-fugitive'                   " git branch info etc.
    Plug 'scrooloose/nerdtree'                  " file explorer
    Plug 'Xuyuanp/nerdtree-git-plugin'          " git extension for NERDTree
    Plug 'scrooloose/nerdcommenter'             " ez comments
    Plug 'junegunn/fzf'                         " fuzzy finder
call plug#end()
" }}}


" {{{ GENERAL
let tabsize=4
set expandtab
execute "set tabstop=".tabsize
execute "set shiftwidth=".tabsize
execute "set softtabstop=".tabsize

set background=dark
colorscheme gruvbox             " set color scheme

syntax enable                   " enable syntax processing
filetype plugin on              " allow vim to recognize filetypes
set number                      " activate line numbers
set relativenumber              " relative numbers from current line
set termguicolors               " activate 256 color support
set mouse=a

set cursorline                  " highlight current line
set showmatch                   " highlight matching [{()}]
set noshowmode                  " dont show --insert-- (as lightline does)
set scrolloff=5                 " scroll before end of lines
set sidescrolloff=15            " scroll before side end of lines

" highlight characters over 80 line length
highlight ColorColumn ctermbg=magenta
call matchadd('ColorColumn', '\%>80v.\+', 100)

autocmd BufNewFile,BufRead *.c set tabstop=8 | set shiftwidth=8 | set softtabstop=8 | set expandtab!
autocmd BufNewFile,BufRead *.h set tabstop=8 | set shiftwidth=8 | set softtabstop=8 | set expandtab!
autocmd BufNewFile,BufRead *.sh set tabstop=8 | set shiftwidth=8 | set softtabstop=8 | set expandtab!
" }}}


" {{{ MAPS AND KEYBINDS
let mapleader = ","

command W w
command Wq wq
command Q q

imap jj <Esc>
map <C-b> <Nop>
map <C-f> <Nop>
map <leader>f :FZF<CR>
map <leader>n :NERDTreeToggle<CR>
map <leader>k <Plug>NERDCommenterToggle
map <leader>gv :GitGutterPreviewHunk<CR>
map <leader>gj :GitGutterNextHunk<CR>
map <leader>gk :GitGutterPrevHunk<CR>
map <leader>gs :Gstatus<CR>
map <leader>qf :CocFix<CR>

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" turn off search highlight with <space>
nnoremap <silent><Space> :nohlsearch<Bar>:echo<CR> 
" }}}


" {{{ LIGHTLINE
set laststatus=2

function! GitStatus()
    if !get(g:, 'gitgutter_enabled', 0) || empty(FugitiveHead())
        return ''
    endif
    let [ l:added, l:modified, l:removed ] = GitGutterGetHunkSummary()
    return printf('~%d +%d -%d', l:modified, l:added, l:removed)
endfunction

let g:lightline = {
    \ 'colorscheme': 'gruvbox',
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ],
    \             [ 'cocstatus', 'readonly', 'filename', 'modified' ],
    \             [ 'gitbranch', 'githunks' ] ],
    \
    \   'right': [ [ 'lineinfo' ],
    \              [ 'percent' ],
    \              [ 'fileformat', 'fileencoding', 'filetype' ] ],
    \ },
    \ 'component_function': {
    \   'cocstatus': 'coc#status',
    \   'githunks': 'GitStatus',
    \   'gitbranch': 'FugitiveHead',
    \ },
\ }
" }}}


" {{{ COC
set hidden                      " if hidden is not set, TextEdit might fail.
set nobackup|set nowritebackup  " Some server have issues with backup files
set updatetime=300              " Smaller updatetime for CursorHold
set shortmess+=c                " don't give ins-completion-menu messages.
set signcolumn=yes              " always show signcolumns

" highlight comments in json correctly
autocmd FileType json syntax match Comment +\/\/.\+$+

" use <c-space>for trigger completion
inoremap <silent><expr> <c-space> coc#refresh()

" use <tab> and <s-tab> to navigate through completion
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
let g:coc_snippet_next = '<TAB>'
let g:coc_snippet_prev = '<S-TAB>'

" use <cr> to confirm completion
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use K to show documentation in preview window
function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction
nnoremap <silent> K :call <SID>show_documentation()<CR>
" }}}


" {{{ OTHER PLUGINS
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1
" Enable NERDCommenterToggle to check all selected lines is commented or not 
let g:NERDToggleCheckAllLines = 1
" Close NERDTree if the only window left open is a NERDTree
autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" }}}
