return {
    'rcarriga/nvim-notify',
    event = 'VeryLazy',
    config = function()
        require('notify').setup({
            max_width = 100,
            minimum_width = 25,
        })
        vim.notify = require('notify')
    end,
}
