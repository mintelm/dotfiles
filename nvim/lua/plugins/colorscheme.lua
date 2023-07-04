return {
    {
        'catppuccin/nvim',
        name = 'catppuccin',
        lazy = false,
        priority = 1000,
        init = function()
            vim.cmd.colorscheme('catppuccin-mocha')
        end,
        opts = {
            integrations = {
                cmp = true,
                gitsigns = true,
                telescope = true,
                treesitter = true,
                treesitter_context = true,
                notify = true,
                leap = true,
                mason = true,
                neotree = true,
                neogit = true,
                overseer = true,
                dap = {
                    enabled = true,
                    enable_ui = true,
                },
                native_lsp = {
                    enabled = true,
                    underlines = {
                        errors = { 'undercurl' },
                        warnings = { 'undercurl' },
                        hints = { 'underline' },
                        information = { 'underline' },
                    },
                },
                indent_blankline = {
                    enabled = true,
                },
            },
        },
    },
}
