return {
    'akinsho/toggleterm.nvim',
    event = 'VeryLazy',
    opts = {
        start_in_insert = false,
        float_opts = {
            border = require('style').current.border,
        }
    },
}
