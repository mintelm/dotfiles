return {
    'stevearc/overseer.nvim',
    config = function()
        require('overseer').setup({
            strategy = {
                'toggleterm',
                direction = 'tab',
                close_on_exit = false,
            },
        })
    end,
    dependencies = 'akinsho/toggleterm.nvim',
}
