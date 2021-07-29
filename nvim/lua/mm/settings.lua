local cmd = vim.cmd

local tab_width = 4
local c_tab_width = 8

cmd('syntax enable')
cmd('filetype plugin indent on')
mm.augroup('UserSettings', {
        {
            events = { 'TextYankPost' },
            targets = { '*' },
            command = function()
                vim.highlight.on_yank({ on_visual = false, timeout = 250 })
            end,
        },
        {
            events = { 'FileType' },
            targets = { 'c', 'cpp', 'objc', 'objcpp', 'sh', 'make' },
            command = function()
                mm.set_tab_width(c_tab_width)
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

mm.set_tab_width(tab_width)
mm.opt('b', 'expandtab', true)
mm.opt('b', 'smartindent', true)

mm.opt('o', 'title', true)
mm.opt('o', 'termguicolors', true)
mm.opt('o', 'shiftround', true)
mm.opt('o', 'hidden', true)
mm.opt('o', 'ignorecase', true)
mm.opt('o', 'smartcase', true)
mm.opt('o', 'scrolloff', 4 )
mm.opt('o', 'mouse', 'a')
mm.opt('o', 'clipboard','unnamed,unnamedplus')
mm.opt('o', 'showmode', false)

mm.opt('w', 'number', true)
mm.opt('w', 'relativenumber', true)
mm.opt('w', 'signcolumn', 'yes:2')
mm.opt('w', 'listchars', 'eol: ,tab:│ ,extends:»,precedes:«,trail:•')
