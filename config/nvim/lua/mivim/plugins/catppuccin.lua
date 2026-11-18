return {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    init = function()
        vim.cmd.colorscheme('catppuccin-mocha')
    end,
    opts = {
        flavour = 'mocha',
        -- integrations are detected automatically (auto_integrations is enabled by default)
        lsp_styles = {
            underlines = {
                errors = { 'undercurl' },
                warnings = { 'undercurl' },
                hints = { 'underline' },
                information = { 'underline' },
            },
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
