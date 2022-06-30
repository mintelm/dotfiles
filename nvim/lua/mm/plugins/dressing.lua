return function()
    --require('mm.highlights').plugin('dressing', { FloatTitle = { inherit = 'Visual', bold = true } })
    require('dressing').setup({
        input = {
            border = mm.style.current.border,
        },
        select = {
            telescope = require('telescope.themes').get_cursor({
                --borderchars = mm.style.current.border,
            }),
        },
    })
end
