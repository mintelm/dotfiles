return {
    'akinsho/bufferline.nvim',
    event = 'VeryLazy',
    dependencies = {
        'kyazdani42/nvim-web-devicons',
        'catppuccin',
    },
    config = function()
        require('bufferline').setup({
            -- catppuccin integration needs to be set via config entry
            highlights = require('catppuccin.groups.integrations.bufferline').get(),
            options = {
                numbers = 'ordinal',
                close_command = 'bwipeout %d',
                right_mouse_command = '',
                middle_mouse_command = 'bwipeout %d',
                separator_style = 'thin',
                persist_buffer_sort = false,
                show_buffer_close_icons = false,
                modified_icon = require('style').icons.ui.modified,
            },
        })
    end,
}
