return {
    'folke/snacks.nvim',
    event = 'VeryLazy',
    opts = {
        bigfile = {},
        indent = {
            indent = {
                char = '▎',
                hl = {
                    'EndOfBuffer',
                    'IblIndent',
                    'IblIndent',
                    'IblIndent',
                    'IblIndent',
                    'IblIndent',
                    'IblIndent',
                    'IblIndent',
                    'IblIndent',
                    'IblIndent',
                    'IblIndent',
                    'IblIndent',
                    'IblIndent',
                    'IblIndent',
                    'IblIndent',
                    'IblIndent',
                },
            },
            animate = { enabled = false },
            scope = { enabled = false },
        },
        input = {},
        notifier = {},
        picker = {},
    },
    keys = {
        -- finders
        { '<leader>fs', function() Snacks.picker.smart() end },
        { '<leader>ff', function() Snacks.picker.files() end },
        { '<leader>fr', function() Snacks.picker.grep() end },
        { '<leader>fg', function() Snacks.picker.git_files() end },
        -- lsp
        { 'gd',         function() Snacks.picker.lsp_definitions() end },
        { 'gr',         function() Snacks.picker.lsp_references() end,     nowait = true },
        { 'gi',         function() Snacks.picker.lsp_implementations() end },
    },
}
