vim.api.nvim_create_autocmd('ColorScheme', {
    callback = function()
        local bg = vim.api.nvim_get_hl(0, { name = 'Normal' }).bg
        vim.api.nvim_set_hl(0, 'Hidden', { fg = bg, bg = bg })
    end,
})

return {
    'folke/snacks.nvim',
    event = 'VeryLazy',
    opts = {
        bigfile = {},
        indent = {
            indent = {
                char = '▎',
                hl = {
                    'Hidden',
                    'LineNr',
                    'LineNr',
                    'LineNr',
                    'LineNr',
                    'LineNr',
                    'LineNr',
                    'LineNr',
                    'LineNr',
                    'LineNr',
                    'LineNr',
                    'LineNr',
                    'LineNr',
                    'LineNr',
                    'LineNr',
                    'LineNr',
                },
            },
            animate = { enabled = false },
            scope = { enabled = false },
        },
        input = {},
        notifier = {},
        picker = {
            win = {
                preview = {
                    wo = {
                        number = false,
                    },
                },
            },
        },
    },
    keys = {
        -- finders
        { '<leader>fs', function() Snacks.picker.smart() end,               desc = 'Smart File Picker' },
        { '<leader>ff', function() Snacks.picker.files() end,               desc = 'File Picker' },
        { '<leader>fr', function() Snacks.picker.grep() end,                desc = 'Grep Picker' },
        { '<leader>fg', function() Snacks.picker.git_files() end,           desc = 'Git Files Picker' },
        -- lsp
        { 'gd',         function() Snacks.picker.lsp_definitions() end,     desc = 'Go To Definitions' },
        { 'gr',         function() Snacks.picker.lsp_references() end,      nowait = true,                 desc = 'Go To References' },
        { 'gi',         function() Snacks.picker.lsp_implementations() end, desc = 'Go To Implementations' },
    },
}
