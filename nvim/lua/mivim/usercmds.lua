vim.api.nvim_create_user_command(
    'Tabs',
    function(opts)
        mivim.utils.set_tab_width(opts.args + 0)
    end,
    { nargs = 1 }
)

vim.api.nvim_create_user_command(
    'BWipe',
    function()
        mivim.utils.delete_hidden_buffers()
    end,
    { nargs = 0 }
)

vim.api.nvim_create_user_command(
    'LineLimit',
    function(opts)
        local line_limit = opts.args + 0
        local hl_fg = vim.api.nvim_get_hl_by_name('Normal', true).foreground
        local hl_bg = vim.api.nvim_get_hl_by_name('Visual', true).background
        vim.api.nvim_set_hl(0, 'LineLimit', { fg = hl_fg, bg = hl_bg })

        if (line_limit > 0) then line_limit = line_limit + 1 end
        vim.cmd('match LineLimit \'\\%' .. line_limit .. 'v.\\+\'')
    end,
    { nargs = 1 }
)
