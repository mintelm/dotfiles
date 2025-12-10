return {
    'nvim-tree/nvim-tree.lua',
    event = 'VeryLazy',
    dependencies = 'kyazdani42/nvim-web-devicons',
    opts = {
        actions = {
            open_file = {
                resize_window = false,
            },
        },
    },
    keys = {
        { '<leader>e', function() require('nvim-tree.api').tree.toggle() end, desc = 'Open File Tree' },
    },
}
