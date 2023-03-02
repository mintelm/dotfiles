return {
    {
        'jose-elias-alvarez/null-ls.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
    },
    {
        'jayp0521/mason-null-ls.nvim',
        event = { 'BufReadPre', 'BufNewFile' },
        config = function()
            require('null-ls').setup()
            require('mason-null-ls').setup({
                ensure_installed = { 'prettierd' },
                automatic_setup = true
            })
            require('mason-null-ls').setup_handlers({})
        end,
        dependencies = { 'mason.nvim', 'null-ls.nvim' }
    },
}
