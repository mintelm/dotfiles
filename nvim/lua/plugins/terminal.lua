return {
    'akinsho/toggleterm.nvim',
    config = function()
        require('toggleterm').setup({
            start_in_insert = false,
            float_opts = {
                border = require('style').current.border,
            }
        })
    end,
}
