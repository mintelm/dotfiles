return {
    'akinsho/bufferline.nvim',
    event = 'VeryLazy',
    dependencies = 'nvim-tree/nvim-web-devicons',
    opts = {
        options = {
            numbers = 'ordinal',
            close_command = 'bwipeout %d',
            right_mouse_command = '',
            middle_mouse_command = 'bwipeout %d',
            separator_style = 'thin',
            persist_buffer_sort = false,
            show_buffer_close_icons = false,
            modified_icon = mivim.style.icons.ui.modified,
        },
    },
    keys = function()
        local keys = {
            { ']b',         function() require('bufferline').cycle(1) end,          desc = 'Next Buffer' },
            { '[b',         function() require('bufferline').cycle(-1) end,         desc = 'Previous Buffer' },
            { '<leader>bf', function() require('bufferline').pick() end,            desc = 'Pick Buffer' },
            { '<leader>bd', function() require('bufferline').close_with_pick() end, desc = 'Delete Buffer' },
        }

        for i = 1, 9 do
            table.insert(keys, {
                '<leader>' .. i,
                function() require('bufferline').go_to(i) end,
                desc = 'Go To Buffer ' .. i,
            })
        end

        return keys
    end,
}
