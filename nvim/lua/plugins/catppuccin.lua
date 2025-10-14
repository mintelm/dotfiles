return {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    init = function()
        vim.cmd.colorscheme('catppuccin')
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
            neotree = true,
            neogit = true,
            notify = true,
            overseer = true,
            rainbow_delimiters = true,
            semantic_tokens = true,
            snacks = { enabled = true },
            telescope = true,
            treesitter = true,
            treesitter_context = true,
        },
    },
    specs = {
        {
            'akinsho/bufferline.nvim',
            optional = true,
            opts = function(_, opts)
                if (vim.g.colors_name or ''):find('catppuccin') then
                    opts.highlights = require('catppuccin.special.bufferline').get_theme()
                end
            end,
        },
    },
}
