local map = require('utils').map
local cmd = require('utils').cmd

return {
    'stevearc/overseer.nvim',
    event = 'VeryLazy',
    config = function()
        require('overseer').setup({
            strategy = {
                'toggleterm',
                direction = 'tab',
                close_on_exit = false,
                quit_on_exit = 'never',
                open_on_start = true,
                auto_scroll = true,
            },
            dap = false,
            template_dirs = { 'overseer.template', 'plugins.overseer.template' },
            templates = { 'builtin', 'cmake' },
        })

        map('n', '<leader>rt', cmd('OverseerRun'))
    end,
}
