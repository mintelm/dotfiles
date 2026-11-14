return {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    init = function()
        vim.cmd.colorscheme('catppuccin-mocha')
    end,
    opts = {
        flavour = 'mocha',
        integrations = {
            blink_cmp = true,
            dap = true,
            dap_ui = true,
            flash = true,
            gitsigns = true,
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
            nvimtree = true,
            neogit = true,
            notify = true,
            semantic_tokens = true,
            snacks = { enabled = true },
            treesitter = true,
        },
    },
    specs = {
        {
            'akinsho/bufferline.nvim',
            optional = true,
            opts = function(_, opts)
                opts.highlights = require('catppuccin.special.bufferline').get_theme()
            end,
        },
    },
}
