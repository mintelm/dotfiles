local function config()
    require('bufferline').setup({
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
end

return {
    'akinsho/bufferline.nvim',
    config = config,
    dependencies = {
        { 'kyazdani42/nvim-web-devicons' },
        { 'catppuccin' },
    },
}
