return {
    {
        'lewis6991/gitsigns.nvim',
        event = 'VeryLazy',
        opts = {
            current_line_blame_opts = {
                delay = 0,
            },
        },
        keys = {
            {
                ']g',
                function()
                    require('gitsigns').nav_hunk('next', {}, function() vim.fn.feedkeys('zz', 'n') end)
                end,
                desc = 'Next Hunk',
            },
            {
                '[g',
                function()
                    require('gitsigns').nav_hunk('prev', {}, function() vim.fn.feedkeys('zz', 'n') end)
                end,
                desc = 'Previous Hunk',
            },
            { '<leader>gs', function() require('gitsigns').stage_hunk() end,                desc = 'Stage Hunk' },
            { '<leader>gS', function() require('gitsigns').stage_buffer() end,              desc = 'Stage Buffer' },
            { '<leader>gr', function() require('gitsigns').reset_hunk() end,                desc = 'Reset Hunk' },
            { '<leader>gR', function() require('gitsigns').reset_buffer() end,              desc = 'Reset Buffer' },
            { '<leader>gv', function() require('gitsigns').preview_hunk_inline() end,       desc = 'Preview Hunk' },
            { '<leader>gb', function() require('gitsigns').toggle_current_line_blame() end, desc = 'Toggle Line Blame' },
            { '<leader>gB', function() require('gitsigns').blame_line({ full = true }) end, desc = 'Float Line Blame' },
        },
    },
    {
        'NeogitOrg/neogit',
        event = 'VeryLazy',
        dependencies = 'nvim-lua/plenary.nvim',
        opts = {
            integrations = {
                diffview = true,
            },
        },
        keys = {
            { '<leader>g<Enter>', function() require('neogit').open() end, { exit = true, nowait = true }, desc = 'Neogit' },
        },
    },
    {
        'sindrets/diffview.nvim',
        event = 'VeryLazy',
        dependencies = 'nvim-lua/plenary.nvim',
        opts = {
            keymaps = {
                view = {
                    { 'n', '<C-w><C-f>', false },
                    { 'n', '<C-w>gf',    false },
                },
                file_panel = {
                    { 'n', '<C-w><C-f>', false },
                    { 'n', '<C-w>gf',    false },
                },
                file_history_panel = {
                    { 'n', '<C-w><C-f>', false },
                    { 'n', '<C-w>gf',    false },
                },
            },
        },
        keys = {
            { '<leader>gd', function() require('diffview').open({}) end,                   desc = 'Open Diff View' },
            { '<leader>gh', function() require('diffview').file_history(nil, {}) end,      desc = 'Open Diff History' },
            { '<leader>gf', function() require('diffview').file_history(nil, { '%' }) end, desc = 'Open File History' },
        },
    },
}
