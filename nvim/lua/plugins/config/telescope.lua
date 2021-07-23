return function()
    local actions = require('telescope.actions')
    require('telescope').setup({
        defaults = {
            prompt_prefix = ' ',
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
