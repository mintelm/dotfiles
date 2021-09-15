return function()
    require('bufferline').setup({
        options = {
            right_mouse_command = '',
            middle_mouse_command = 'bdelete! %d',
            show_close_icon = false,
            separator_style = 'thin',
        },
    })
end
