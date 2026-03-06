return {
    {
        'olimorris/codecompanion.nvim',
        event = 'VeryLazy',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-treesitter/nvim-treesitter',
        },
        opts = {
            adapters = {
                http = {
                    copilot = function()
                        return require('codecompanion.adapters').extend('copilot', {
                            schema = {
                                model = {
                                    default = 'claude-opus-4.6',
                                },
                            },
                        })
                    end,
                }
            },
        },
        keys = {
            { '<leader>cc', function() require('codecompanion').toggle() end, desc = 'Toggle Code Companion Chat', },
        },
    },
}
