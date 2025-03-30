local cmd = require('utils').cmd

return {
    'stevearc/overseer.nvim',
    event = 'VeryLazy',
    opts = {
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
    },
    keys = {
        { '<leader>rt', cmd('OverseerRun') },
    },
}
