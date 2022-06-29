return function()
    require('bufferline').setup({
        options = {
            numbers = 'ordinal',
            right_mouse_command = '',
            middle_mouse_command = 'bdelete! %d',
            separator_style = 'thin',
            persist_buffer_sort = false,
            show_buffer_close_icons = false,
            show_close_icon = false,
        },
    })
end
