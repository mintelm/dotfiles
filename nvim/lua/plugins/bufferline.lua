local cmd = require('utils').cmd

return {
    'akinsho/bufferline.nvim',
    event = 'VeryLazy',
    dependencies = 'kyazdani42/nvim-web-devicons',
    opts = {
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
    },
    keys = {
        { ']b',         cmd('BufferLineCycleNext') },
        { '[b',         cmd('BufferLineCyclePrev') },
        { '<leader>bf', cmd('BufferLinePick') },
        { '<leader>bd', cmd('BufferLinePickClose') },
        { '<leader>1',  cmd('BufferLineGoToBuffer 1') },
        { '<leader>2',  cmd('BufferLineGoToBuffer 2') },
        { '<leader>3',  cmd('BufferLineGoToBuffer 3') },
        { '<leader>4',  cmd('BufferLineGoToBuffer 4') },
        { '<leader>5',  cmd('BufferLineGoToBuffer 5') },
        { '<leader>6',  cmd('BufferLineGoToBuffer 6') },
        { '<leader>7',  cmd('BufferLineGoToBuffer 7') },
        { '<leader>8',  cmd('BufferLineGoToBuffer 8') },
        { '<leader>9',  cmd('BufferLineGoToBuffer 9') },
    },
}
