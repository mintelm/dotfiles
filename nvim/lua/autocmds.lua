local utils = require('utils')

utils.augroup('UserSettings', {
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
        pattern = { 'c', 'sh', 'make' },
        command = function()
            utils.set_tab_width(8)
        end,
    },
    {
        event = { 'FileType' },
        pattern = { 'bib' },
        command = function()
            utils.set_tab_width(2)
        end,
    },
    -- toggle hiding invisible chars on insert
    {
        event = { 'WinLeave', 'BufLeave', 'InsertEnter' },
        pattern = { '*' },
        command = function()
            vim.o.list = false
        end,
    },
    {
        event = { 'WinEnter', 'BufEnter', 'InsertLeave' },
        pattern = { '*' },
        command = function()
            vim.o.list = true
        end,
    },
    {
        event = { 'WinEnter' },
        pattern = { '*' },
        command = function()
            if vim.wo.number then
                vim.wo.cursorline = true
                vim.wo.relativenumber = true
            end
        end,
    },
    {
        event = { 'WinLeave' },
        pattern = { '*' },
        command = function()
            if vim.wo.number then
                vim.wo.cursorline = false
                vim.wo.relativenumber = false
            end
        end,
    },
    {
        event = { 'BufWritePost' },
        pattern = { '*' },
        command = function()
            vim.cmd('Gitsigns refresh')
        end,
    },
})