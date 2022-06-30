return function()
    local actions = require('telescope.actions')
    local function reorder_border()
        local border = { }
        local order = { 2, 4, 6, 8, 1, 3, 5, 7 }
        for _, i in pairs(order) do
            table.insert(border, mm.style.current.border[i])
        end

        return border
    end

    require('mm.highlights').plugin('telescope', {
        TelescopeNormal = { link = 'NormalFloat' },
        TelescopeBorder = { link = 'FloatBorder' },
    })

    require('telescope').setup({
        defaults = {
            prompt_prefix = ' ',
            border = { },
            borderchars = reorder_border(),
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
