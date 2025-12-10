-- disable netrw at the very start of your init.lua (strongly advised by nvim-tree)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.o.title = true
vim.o.titlestring = mivim.style.icons.ui.vim .. " %{fnamemodify(getcwd(), ':~:t')}"

vim.o.expandtab = true
vim.o.smartindent = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.softtabstop = 4

vim.o.termguicolors = true
vim.o.shiftround = true
vim.o.hidden = true

vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.smartcase = true
vim.o.scrolloff = 8
vim.o.pumheight = 10
vim.o.mouse = 'a'
vim.o.showmode = false

vim.o.number = true
vim.o.relativenumber = true
vim.o.signcolumn = 'yes:1'
vim.o.laststatus = 3
vim.o.cursorline = true
vim.o.splitbelow = true
vim.o.equalalways = false
vim.o.list = true
vim.o.listchars = 'tab:→ ,trail:•,nbsp:␣,extends:»,precedes:«'
vim.o.updatetime = 50

vim.o.swapfile = false
vim.o.backup = false
vim.o.undofile = true

-- some stuff looks weird with this new option
-- vim.o.winborder = 'rounded'
