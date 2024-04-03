return {
    'stevearc/overseer.nvim',
    event = 'VeryLazy',
    dependencies = 'akinsho/toggleterm.nvim',
    opts = {
        strategy = {
            'toggleterm',
            direction = 'tab',
            close_on_exit = false,
            open_on_start = true,
        },
    },
}
