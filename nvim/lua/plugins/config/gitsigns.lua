return function()
    require('gitsigns').setup {
        signs = {
            add = { hl = 'GitSignsAdd'   , text = '+' },
            change = { hl = 'GitSignsChange', text = '~' },
            delete = { hl = 'GitSignsDelete', text = '_' },
            topdelete = { hl = 'GitSignsDelete', text = '‾' },
            changedelete = { hl = 'GitSignsChange', text = '~' },
        },
        keymaps = { },
    }
end
