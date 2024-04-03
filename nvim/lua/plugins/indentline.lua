return {
    'lukas-reineke/indent-blankline.nvim',
    event = 'VeryLazy',
    main = 'ibl',
    opts = {
        indent = {
            char = { '', '▎', '▎', '▎', '▎', '▎', '▎', '▎', '▎' },
        },
        exclude = {
            filetypes = {
                'lspinfo',
                'packer',
                'checkhealth',
                'help',
                'man',
                'gitcommit',
                'TelescopePrompt',
                'TelescopeResults',
                'NvimTree',
                'git',
                'undotree',
                '', -- for all buffers without a file type
            },
        },
        scope = {
            enabled = false
        },
    },
}
