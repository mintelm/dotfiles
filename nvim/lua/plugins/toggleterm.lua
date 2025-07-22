local cmd = require('utils').cmd

return {
    'akinsho/toggleterm.nvim',
    event = 'VeryLazy',
    opts = {
        start_in_insert = false,
    },
    keys = {
        { '<leader>t', cmd('ToggleTerm direction=float') },
        { '<esc>',     '<C-\\><C-n>',                    mode = 't' },
    },
}
