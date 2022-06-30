return function()
    local actions = require('telescope.actions')
    local bc = mm.style.current.border

    require('mm.highlights').plugin('telescope', {
        TelescopeNormal = { link = 'NormalFloat' },
        TelescopeBorder = { link = 'FloatBorder' },
    })

    require('telescope').setup({
        defaults = {
            prompt_prefix = ' ',
            border = { },
            -- telescope expects different order
            borderchars = { bc[2], bc[4], bc[6], bc[8], bc[1], bc[3], bc[5], bc[7] },
            set_env = { ["COLORTERM"] = "truecolor" },
            mappings = {
                i = {
                    ['<c-c>'] = function()
                        vim.cmd 'stopinsert!'
                    end,
                    ['<esc>'] = actions.close,
                    ['<c-s>'] = actions.select_horizontal,
                    ['<c-j>'] = actions.cycle_history_next,
                    ['<c-k>'] = actions.cycle_history_prev,
                },
            },
            file_ignore_patterns = { '%.jpg', '%.jpeg', '%.png', '%.otf', '%.ttf', '%.o' },
            layout_strategy = 'flex',
        },
    })
end
