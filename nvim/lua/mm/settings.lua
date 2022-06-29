local cmd = vim.cmd

cmd('syntax enable')
cmd('filetype plugin indent on')

mm.augroup('UserSettings', {
        -- highlight yank for 250ms
        {
            event = { 'TextYankPost' },
            pattern = { '*' },
            command = function()
                vim.highlight.on_yank({ on_visual = false, timeout = 250 })
            end,
        },
        -- set tab width dynamically on c-like files
        {
            event = { 'FileType' },
            pattern  = { 'c', 'cpp', 'objc', 'objcpp', 'sh', 'make' },
            command = function()
                mm.set_tab_width(8)
            end,
        },
        -- toggle hiding invisible chars on insert
        {
            event = { 'InsertEnter' },
            pattern  = { '*' },
            command = function()
                vim.o.list = false
            end,
        },
        {
            event = { 'InsertLeave' },
            pattern  = { '*' },
            command = function()
                vim.o.list = true
            end,
        },
})

vim.o.title = true
vim.o.titlestring = '❐ %{fnamemodify(getcwd(), ":~")} %m'

vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.smartindent = true

vim.o.termguicolors = true
vim.o.shiftround = true
vim.o.hidden = true

vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.scrolloff = 4
vim.o.mouse = 'a'
vim.o.clipboard = 'unnamed,unnamedplus'
vim.o.showmode = false

vim.o.number = true
vim.o.relativenumber = true
vim.o.signcolumn = 'yes:2'
vim.o.cursorline = true
vim.o.list = true
vim.o.listchars = 'tab:→ ,trail:•,nbsp:␣,extends:»,precedes:«'
