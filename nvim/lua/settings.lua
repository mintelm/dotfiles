local utils = require('utils')

vim.o.title = true
vim.o.titlestring = require('style').icons.ui.vim .. " %{fnamemodify(getcwd(), ':~')} %m"

utils.set_tab_width(4)

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
vim.o.signcolumn = 'yes:2'
vim.o.laststatus = 3
vim.o.cursorline = true
vim.o.splitbelow = true
vim.o.equalalways = false
vim.o.list = true
vim.o.listchars = 'tab:→ ,trail:•,nbsp:␣,extends:»,precedes:«'
vim.o.updatetime = 50

vim.o.swapfile = false
vim.o.backup = false
vim.o.undordir = os.getenv('HOME') .. '/.vim/undodir'
vim.o.undofile = true

vim.api.nvim_create_user_command(
    'Tabs',
    function(opts)
        utils.set_tab_width(opts.args + 0)
    end,
    { nargs = 1 }
)
