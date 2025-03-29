local map = require('utils').map
local cmd = require('utils').cmd

return {
    'akinsho/bufferline.nvim',
    event = 'VeryLazy',
    dependencies = 'kyazdani42/nvim-web-devicons',
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

        map('n', ']b', cmd('BufferLineCycleNext'))
        map('n', '[b', cmd('BufferLineCyclePrev'))
        map('n', '<leader>bf', cmd('BufferLinePick'))
        map('n', '<leader>bd', cmd('BufferLinePickClose'))
        map('n', '<leader>1', cmd('BufferLineGoToBuffer 1'))
        map('n', '<leader>2', cmd('BufferLineGoToBuffer 2'))
        map('n', '<leader>3', cmd('BufferLineGoToBuffer 3'))
        map('n', '<leader>4', cmd('BufferLineGoToBuffer 4'))
        map('n', '<leader>5', cmd('BufferLineGoToBuffer 5'))
        map('n', '<leader>6', cmd('BufferLineGoToBuffer 6'))
        map('n', '<leader>7', cmd('BufferLineGoToBuffer 7'))
        map('n', '<leader>8', cmd('BufferLineGoToBuffer 8'))
        map('n', '<leader>9', cmd('BufferLineGoToBuffer 9'))
    end,
}
