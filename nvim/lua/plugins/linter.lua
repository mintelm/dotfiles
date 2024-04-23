return {
    'nvimtools/none-ls.nvim',
    dependencies = {
        { 'nvim-lua/plenary.nvim' },
        {
            'jayp0521/mason-null-ls.nvim',
            dependencies = 'williamboman/mason.nvim',
            opts = {
                ensure_installed = { 'prettierd' },
                handlers = {},
            },
        },
    },
    config = true
}
