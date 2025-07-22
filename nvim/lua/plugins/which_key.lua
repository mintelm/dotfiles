return {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    opts = {
        preset = 'modern',
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
