return {
    'rcarriga/nvim-notify',
    event = 'VeryLazy',
    init = function()
        vim.notify = require('notify')
    end,
    opts = {
        max_width = 100,
        minimum_width = 25,
    },
}
