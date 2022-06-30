return function()
    local bc = mm.style.current.border

    require('dressing').setup({
        input = {
            border = mm.style.current.border,
        },
        select = {
            telescope = require('telescope.themes').get_cursor({
                -- telescope expects different order
                borderchars = { bc[2], bc[4], bc[6], bc[8], bc[1], bc[3], bc[5], bc[7] },
            }),
        },
    })
end
