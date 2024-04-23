local utils = require('utils')

-- disable netrw at the very start of your init.lua (strongly advised by nvim-tree)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.o.title = true
vim.o.titlestring = require('style').icons.ui.vim .. " %{fnamemodify(getcwd(), ':~')} %m"

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
vim.o.undofile = true

vim.api.nvim_create_user_command(
    'Tabs',
    function(opts)
        utils.set_tab_width(opts.args + 0)
    end,
    { nargs = 1 }
)

vim.api.nvim_create_user_command(
    'BWipe',
    function()
        utils.delete_hidden_buffers()
    end,
    { nargs = 0 }
)

vim.api.nvim_create_user_command(
    'LineLimit',
    function(opts)
        local line_limit = opts.args + 0
        local hl_fg = vim.api.nvim_get_hl_by_name('Normal', true).foreground
        local hl_bg = vim.api.nvim_get_hl_by_name('Visual', true).background
        vim.api.nvim_set_hl(0, 'LineLimit', { fg = hl_fg, bg = hl_bg })

        if (line_limit > 0) then line_limit = line_limit + 1 end
        vim.cmd('match LineLimit \'\\%' .. line_limit .. 'v.\\+\'')
    end,
    { nargs = 1 }
)
