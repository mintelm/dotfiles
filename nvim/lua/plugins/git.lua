return {
    {
        'lewis6991/gitsigns.nvim',
        event = 'VeryLazy',
        opts = {
            current_line_blame_opts = {
                delay = 0,
            },
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
    },
}
