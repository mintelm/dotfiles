return {
    {
        'folke/flash.nvim',
        event = 'VeryLazy',
        opts = {
            modes = {
                search = { enabled = false },
                char = {
                    autohide = true,
                    jump_labels = true,
                    multi_line = false,
                    keys = { 'f', 'F', 't', 'T' },
                },
            },
        },
        keys = {
            { 's', mode = { 'n', 'o', 'x' }, function() require('flash').jump() end, desc = 'Flash' },
        },
    },
}
