"{{{ Plugins
if has('nvim')
  if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
    silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source ~/.config/nvim/init.vim 
  endif
else
  if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  endif
endif

if has('nvim')
  call plug#begin('~/.local/share/nvim/plugged')
    Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
else
  call plug#begin('~/.vim/plugged')
endif
  Plug 'morhetz/gruvbox' 	                    " color scheme
  Plug 'itchyny/lightline.vim'		            " bottom info bar
  Plug 'leafgarland/typescript-vim'	          " typescript
  Plug 'lervag/vimtex'			                  " LaTeX support
  Plug 'airblade/vim-gitgutter'               " git info on left bar
  Plug 'tpope/vim-fugitive'                   " git branch info etc.
  Plug 'junegunn/rainbow_parentheses.vim'     " colored brackets
  Plug 'scrooloose/nerdtree'                  " file explorer
  Plug 'scrooloose/nerdcommenter'             " ez comments
  Plug 'junegunn/fzf'                         " fuzzy finder
call plug#end()
"}}}


"{{{ General Settings
colorscheme gruvbox 			          " set color scheme

syntax enable				                " enable syntax processing
filetype plugin on			            " allow vim to recognize filetypes
set number 				                  " activate line numbers	
set relativenumber                  " relative numbers from current line
set termguicolors 			            " activate 256 color support
set mouse=a

set tabstop=2				                " number of visual spaces per TAB
set softtabstop=2		                " number of spaces in tab when editing
set shiftwidth=2                    " auto indent
set expandtab			                  " tabs are spaces

set cursorline                      " highlight current line
set showmatch                       " highlight matching [{()}]
set noshowmode			   	            " dont show --insert-- (as lightline does)
set scrolloff=5                     " scroll before end of lines
set sidescrolloff=15                " scroll before side end of lines

" highlight characters over 80 line length
highlight ColorColumn ctermbg=magenta
call matchadd('ColorColumn', '\%>80v.\+', 100)

autocmd BufNewFile,BufRead *.c set tabstop=8 | set softtabstop=8 | set shiftwidth=8 | set expandtab!
autocmd BufNewFile,BufRead *.h set tabstop=8 | set softtabstop=8 | set shiftwidth=8 | set expandtab!
autocmd BufNewFile,BufRead *.sh set tabstop=8 | set softtabstop=8 | set shiftwidth=8 | set expandtab!
"}}}


"{{{ Remaps and Keybinds
command W w
command Wq wq
command Q q

map <C-b> <Nop>
map <C-f> :FZF<CR>
map <C-n> :NERDTreeToggle<CR>
map <C-k> <Plug>NERDCommenterToggle

" turn off search highlight with <space>
nnoremap <silent><Space> :nohlsearch<Bar>:echo<CR> 
"}}}


"{{{ Lightline Configuration
let g:lightline = {
      \ 'colorscheme': 'gruvbox',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'cocstatus', 'readonly', 'filename', 'modified' ],
      \             [ 'gitbranch' ] ],
      \
      \   'right': [ [ 'lineinfo' ],
      \              [ 'percent' ],
      \              [ 'fileformat', 'fileencoding', 'filetype' ],
      \              [ 'githunks' ] ]
      \ },
      \ 'component_function': {
      \   'cocstatus': 'coc#status',
      \   'githunks': 'GitStatus',
      \   'gitbranch': 'FugitiveHead',
      \ },
\ }

function! GitStatus()
  if !get(g:, 'gitgutter_enabled', 0) || empty(FugitiveHead())
    return ''
  endif
  let [ l:added, l:modified, l:removed ] = GitGutterGetHunkSummary()
  return printf('~%d +%d -%d', l:modified, l:added, l:removed)
endfunction

" to make sure lightline shows up
set laststatus=2
"}}}


"{{{ Coc Configuration
if has('nvim')
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

  " if hidden is not set, TextEdit might fail.
  set hidden
  " Some server have issues with backup files, see #649
  set nobackup
  set nowritebackup
  " better display for messagers
  " set cmdheight=2
  " Smaller updatetime for CursorHold & CursorHoldI
  set updatetime=300
  " don't give |ins-completion-menu| messages.
  set shortmess+=c
  " always show signcolumns
  set signcolumn=yes

endif
"}}}


"{{{ Other Plugins
" settings for vimtex
let g:tex_flavor='latex'
let g:tex_conceal='abdmg'
set conceallevel=2

" colored brackets
au VimEnter * RainbowParentheses

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1
" Enable NERDCommenterToggle to check all selected lines is commented or not 
let g:NERDToggleCheckAllLines = 1
"}}}
