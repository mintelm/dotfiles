return {
    {
        'folke/flash.nvim',
        event = 'VeryLazy',
        opts = {
            jump = { autojump = true }, -- auto jump if there is only one label
            modes = {
                search = { enabled = false },
                char = {
                    jump_labels = true,
                    multi_line = false,
                },
            },
        },
        keys = {
            { 's', mode = { 'n', 'o', 'x' }, function() require('flash').jump() end, desc = 'Flash' },
        },
    },
}
