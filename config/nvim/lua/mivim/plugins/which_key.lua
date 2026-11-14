return {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    opts = {
        preset = 'modern',
        win = {
            width = .5,
        },
        layout = {
            width = { min = 20, max = 30 },
            spacing = 3,
        },
    },
    keys = {
        {
            '<c-w><space>',
            function()
                require('which-key').show({ keys = '<c-w>', loop = true })
            end,
            desc = 'Window Hydra Mode',
        },
    },
}
