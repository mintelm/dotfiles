return function()
    local H = require('mm.highlights')

    H.plugin('gitsigns', {
        GitSignsAdd = { background = 'NONE' },
        GitSignsChange = { background = 'NONE' },
        GitSignsDelete = { background = 'NONE' },
    })
    require('gitsigns').setup({
        signs = {
            add = { hl = 'GitSignsAdd'   , text = '▌' },
            change = { hl = 'GitSignsChange', text = '▌' },
            delete = { hl = 'GitSignsDelete', text = '▌' },
            topdelete = { hl = 'GitSignsDelete', text = '▌' },
            changedelete = { hl = 'GitSignsChange', text = '▌' },
        },
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
