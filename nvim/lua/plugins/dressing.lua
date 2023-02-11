local function config()
    local bc = require('style').current.border

    require('dressing').setup({
        input = {
            border = bc,
        },
        select = {
            telescope = require('telescope.themes').get_dropdown({
                -- telescope expects different order
                borderchars = { bc[2], bc[4], bc[6], bc[8], bc[1], bc[3], bc[5], bc[7] },
            }),
        },
    })
end

return {
    'stevearc/dressing.nvim',
    config = config,
    dependencies = {
        'nvim-telescope/telescope.nvim',
    },
}
