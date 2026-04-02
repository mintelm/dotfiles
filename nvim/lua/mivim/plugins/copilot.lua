return {
    'olimorris/codecompanion.nvim',
    event = 'VeryLazy',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-treesitter/nvim-treesitter',
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
    },
    keys = {
        { '<leader>cc', function() require('codecompanion').toggle() end, desc = 'Toggle Code Companion Chat', },
    },
}
