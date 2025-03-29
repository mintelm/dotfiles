local augroup = require('utils').augroup

augroup('UserSettings', {
    -- highlight yank for 250ms
    {
        event = { 'TextYankPost' },
        command = function()
            vim.highlight.on_yank({ on_visual = false, timeout = 250 })
        end,
    },
    -- toggle hiding invisible chars on insert
    {
        event = { 'WinLeave', 'BufLeave', 'InsertEnter' },
        command = function()
            vim.o.list = false
        end,
    },
    {
        event = { 'WinEnter', 'BufEnter', 'InsertLeave' },
        command = function()
            vim.o.list = true
        end,
    },
})
