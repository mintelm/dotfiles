return {
    {
        'nvimtools/none-ls.nvim',
        dependencies = {
            { 'nvim-lua/plenary.nvim' },
            {
                'jayp0521/mason-null-ls.nvim',
                config = function()
                    require('mason-null-ls').setup({
                        ensure_installed = { 'prettierd' },
                        handlers = {},
                    })
                    require('null-ls').setup()
                end,
                dependencies = { 'williamboman/mason.nvim' },
            },
        },
    },
}
