local cmd = vim.cmd

cmd('syntax enable')
cmd('filetype plugin indent on')

mm.augroup('UserSettings', {
        -- highlight yank for 250ms
        {
            events = { 'TextYankPost' },
            targets = { '*' },
            command = function()
                vim.highlight.on_yank({ on_visual = false, timeout = 250 })
            end,
        },
        -- set tab width dynamically on c-like files
        {
            events = { 'FileType' },
            targets = { 'c', 'cpp', 'objc', 'objcpp', 'sh', 'make' },
            command = function()
                vim.bo.tabstop = 8
                vim.bo.shiftwidth = 8
                vim.b.expandtab = false
                vim.b.smartindent = false
            end,
        },
        -- toggle hiding invisible chars on insert
        {
            events = { 'InsertEnter' },
            targets = { '*' },
            command = function()
                vim.wo.list = false
            end,
        },
        {
            events = { 'InsertLeave' },
            targets = { '*' },
            command = function()
                vim.wo.list = true
            end,
        },
})

vim.o.title = true
vim.o.titlestring = '❐ %{fnamemodify(getcwd(), ":~")} %m'
vim.o.termguicolors = true
vim.o.shiftround = true
vim.o.hidden = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.scrolloff = 4
vim.o.mouse = 'a'
vim.o.clipboard = 'unnamed,unnamedplus'
vim.o.showmode = false

vim.bo.tabstop = 4
vim.bo.shiftwidth = 4
vim.bo.expandtab = true
vim.bo.smartindent = true

vim.wo.number = true
vim.wo.relativenumber = true
vim.wo.signcolumn = 'yes:2'
vim.wo.list = true
vim.wo.listchars = 'tab:→ ,trail:•,nbsp:␣,extends:»,precedes:«'
