" auto install plug
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

" Plugins
if has('nvim')
  call plug#begin('~/.local/share/nvim/plugged')
    " code completion (has its own plugins (e.g. sources))
    Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
else
  call plug#begin('~/.vim/plugged')
endif
  Plug 'morhetz/gruvbox' 	          " color scheme
  Plug 'itchyny/lightline.vim'		  " bottom info bar
  Plug 'leafgarland/typescript-vim'	" typescript
  Plug 'lervag/vimtex'			        " LaTeX support
call plug#end()

" vim settings
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
autocmd BufNewFile,BufRead *.c set tabstop=8 | set softtabstop=8 | set shiftwidth=8 | set expandtab!

set cursorline                      " highlight current line
set showmatch                       " highlight matching [{()}]
set noshowmode			   	            " dont show --insert-- (as lightline does)
set scrolloff=5                     " scroll before end of lines
set sidescrolloff=15                " scroll before side end of lines

colorscheme gruvbox 			          " set color scheme
set bg=dark

" keybinds
imap jk <Esc>
imap kj <Esc>

" remaps
command W w
command Wq wq
command Q q

" highlight characters over 80 line length
highlight ColorColumn ctermbg=magenta
call matchadd('ColorColumn', '\%>80v.\+', 100)

" turn off search highlight with <space>
nnoremap <silent><Space> :nohlsearch<Bar>:echo<CR> 

" make lightline show CoCStatus
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'cocstatus', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'cocstatus': 'coc#status'
      \ },
      \ }
" to make sure lightline shows up
set laststatus=2

" settings for vimtex
let g:tex_flavor='latex'
let g:tex_conceal='abdmg'
set conceallevel=2

if has('nvim')
  " ############################################################################
  " # CoC Settings 
  " ############################################################################
  " highlight comments in json correctly
  autocmd FileType json syntax match Comment +\/\/.\+$+
  " use <c-space>for trigger completion
  inoremap <silent><expr> <c-space> coc#refresh()
  " use <tab> and <s-tab> to navigate through completion
  inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
  inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
  " close preview window when completion is done
  autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif
  " if hidden is not set, TextEdit might fail.
  set hidden

  " Some server have issues with backup files, see #649
  set nobackup
  set nowritebackup

  " Smaller updatetime for CursorHold & CursorHoldI
  set updatetime=300

  " don't give |ins-completion-menu| messages.
  set shortmess+=c

  " always show signcolumns
  set signcolumn=yes

endif
