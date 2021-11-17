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
                set_tab_width(c_tab_width)
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

set_tab_width(tab_width)
mm.set_opt('b', 'expandtab', true)
mm.set_opt('b', 'smartindent', true)

mm.set_opt('o', 'title', true)
mm.set_opt('o', 'termguicolors', true)
mm.set_opt('o', 'shiftround', true)
mm.set_opt('o', 'hidden', true)
mm.set_opt('o', 'ignorecase', true)
mm.set_opt('o', 'smartcase', true)
mm.set_opt('o', 'scrolloff', 4 )
mm.set_opt('o', 'mouse', 'a')
mm.set_opt('o', 'clipboard','unnamed,unnamedplus')
mm.set_opt('o', 'showmode', false)

mm.set_opt('w', 'number', true)
mm.set_opt('w', 'relativenumber', true)
mm.set_opt('w', 'signcolumn', 'yes:2')
mm.set_opt('w', 'listchars', 'eol: ,tab:│ ,extends:»,precedes:«,trail:•')
