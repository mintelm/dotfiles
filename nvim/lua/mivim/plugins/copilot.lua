return {
    'olimorris/codecompanion.nvim',
    event = 'VeryLazy',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-treesitter/nvim-treesitter',
        'lalitmee/codecompanion-spinners.nvim',
    },
    opts = {
        interactions = {
            chat = {
                adapter = {
                    name = 'copilot_acp',
                    model = 'claude-opus-4.6',
                },
            },
        },
        extensions = {
            spinner = {
                opts = {
                    style = 'snacks',
                },
            },
        },
    },
    keys = {
        { '<leader>cc', function() require('codecompanion').toggle() end, desc = 'Toggle Code Companion Chat', },
    },
}
