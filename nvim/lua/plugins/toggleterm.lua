return {
    'akinsho/toggleterm.nvim',
    event = 'VeryLazy',
    opts = {
        start_in_insert = false,
    },
    keys = {
        {
            '<leader>t',
            function()
                require('toggleterm').toggle(nil, nil, nil, 'float', nil)
            end,
            desc = 'Toggle Terminal',
        },
        { '<esc>', '<C-\\><C-n>', mode = 't' },
    },
}
