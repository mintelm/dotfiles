local function gitsigns_config()
    require('gitsigns').setup({
        keymaps = {},
        update_debounce = 50,
        current_line_blame_opts = {
            delay = 0,
        },
        preview_config = {
            border = require('style').current.border,
        },
    })
end

return {
    {
        'lewis6991/gitsigns.nvim',
        config = gitsigns_config,
    },
    {
        'TimUntersberger/neogit',
        dependencies = 'nvim-lua/plenary.nvim',
    },
    {
        'sindrets/diffview.nvim',
        dependencies = 'nvim-lua/plenary.nvim',
    }
}
