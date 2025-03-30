return {
    'stevearc/dressing.nvim',
    event = 'VeryLazy',
    dependencies = 'nvim-telescope/telescope.nvim',
    config = function()
        require('dressing').setup({
        })
    end,
}
