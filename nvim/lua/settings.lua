local cmd = vim.cmd
local style = require('style')

cmd('syntax enable')
cmd('filetype plugin indent on')

vim.o.title = true
vim.o.titlestring = style.icons.vim .. " %{fnamemodify(getcwd(), ':~')} %m"

vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.smartindent = true

vim.o.termguicolors = true
vim.o.shiftround = true
vim.o.hidden = true

vim.o.ignorecase = true
vim.o.smartcase = true

if vim.env.WSL_DISTRO_NAME then
    vim.o.clipboard = ''
else
    vim.o.clipboard = 'unnamed,unnamedplus'
end
vim.o.scrolloff = 4
vim.o.mouse = 'a'
vim.o.showmode = false

vim.o.number = true
vim.o.relativenumber = true
vim.o.signcolumn = 'yes:2'
vim.o.laststatus = 3
vim.o.cursorline = true
vim.o.splitbelow = true
vim.o.equalalways = false
vim.o.list = true
vim.o.listchars = 'tab:→ ,trail:•,nbsp:␣,extends:»,precedes:«'
vim.o.updatetime=100
