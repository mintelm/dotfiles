return {
    {
        'jose-elias-alvarez/null-ls.nvim',
        dependencies = {
            {
                'jayp0521/mason-null-ls.nvim',
                config = function()
                    require('null-ls').setup()
                    require('mason-null-ls').setup({ automatic_setup = true })
                    require('mason-null-ls').setup_handlers({})
                end,
            },
        },
    },
}
