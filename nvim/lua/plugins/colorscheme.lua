return {
    {
        'catppuccin/nvim',
        name = 'catppuccin',
        priority = 1000,
        dependencies = 'HiPhish/rainbow-delimiters.nvim',
        init = function()
            vim.cmd.colorscheme('catppuccin')
        end,
        opts = {
            flavour = 'mocha',
            integrations = {
                cmp = true,
                dap = true,
                dap_ui = true,
                flash = true,
                gitsigns = true,
                indent_blankline = {
                    enabled = true,
                },
                mason = true,
                native_lsp = {
                    enabled = true,
                    underlines = {
                        errors = { 'undercurl' },
                        warnings = { 'undercurl' },
                        hints = { 'underline' },
                        information = { 'underline' },
                    },
                },
                neotree = true,
                neogit = true,
                notify = true,
                overseer = true,
                rainbow_delimiters = true,
                semantic_tokens = true,
                telescope = true,
                treesitter = true,
                treesitter_context = true,
            },
        },
    },
}
