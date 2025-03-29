local map = require('utils').map
local cmd = require('utils').cmd

return {
    'nvim-tree/nvim-tree.lua',
    event = 'VeryLazy',
    dependencies = 'kyazdani42/nvim-web-devicons',
    config = function()
        require('nvim-tree').setup({
            actions = {
                open_file = {
                    resize_window = false,
                },
            },
        })

        map('n', '<leader>e', cmd('NvimTreeToggle'))
    end,
}
