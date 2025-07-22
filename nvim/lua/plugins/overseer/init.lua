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
        { '<leader>rt', function() require('overseer').run_template() end, desc = 'Task List' },
    },
}
