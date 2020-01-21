"{{{ General Settings
colorscheme desert                  " set color scheme

syntax enable				                " enable syntax processing
filetype plugin on			            " allow vim to recognize filetypes
set number 				                  " activate line numbers	
set relativenumber                  " relative numbers from current line
set termguicolors 			            " activate 256 color support
set mouse=a

set cursorline                      " highlight current line
set showmatch                       " highlight matching [{()}]
set noshowmode			   	            " dont show --insert-- (as lightline does)
set scrolloff=5                     " scroll before end of lines
set sidescrolloff=15                " scroll before side end of lines

" highlight characters over 80 line length
highlight ColorColumn ctermbg=magenta
call matchadd('ColorColumn', '\%>80v.\+', 100)
"}}}


"{{{ Remaps and Keybinds
command W w
command Wq wq
command Q q

map <C-b> <Nop>

" turn off search highlight with <space>
nnoremap <silent><Space> :nohlsearch<Bar>:echo<CR> 
"}}}
