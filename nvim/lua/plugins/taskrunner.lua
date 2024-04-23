return {
    'stevearc/overseer.nvim',
    event = 'VeryLazy',
    opts = {
        strategy = {
            'toggleterm',
            direction = 'tab',
            close_on_exit = false,
            open_on_start = true,
        },
    },
}
