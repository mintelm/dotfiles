return function()
    require('gitsigns').setup({
        keymaps = { },
        update_debounce = 50,
        current_line_blame_opts = {
            delay = 0,
        },
        preview_config = {
            border = mm.style.current.border,
        },
    })
end
