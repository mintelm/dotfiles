return {
    'lukas-reineke/indent-blankline.nvim',
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
