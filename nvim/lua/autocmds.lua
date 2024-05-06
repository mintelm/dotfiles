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
        pattern = { 'c', 'cpp', 'sh', 'make' },
        command = function()
            utils.set_tab_width(2)
        end,
    },
    {
        event = { 'FileType' },
        pattern = { 'bib', 'json' },
        command = function()
            utils.set_tab_width(2)
        end,
    },
    {
        event = { 'FileType' },
        pattern = { 'rst' },
        command = function()
            utils.set_tab_width(3)
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
})
