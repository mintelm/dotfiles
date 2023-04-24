return {
    {
        'jose-elias-alvarez/null-ls.nvim',
        dependencies = {
            { 'nvim-lua/plenary.nvim' },
            {
                'jayp0521/mason-null-ls.nvim',
                config = function()
                    require('null-ls').setup()
                    require('mason-null-ls').setup({
                        ensure_installed = { 'prettierd' },
                        handlers = {},
                    })
                end,
                dependencies = { 'williamboman/mason.nvim' },
            },
        },
    },
}
