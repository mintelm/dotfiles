return function()
    mm.augroup('UserHighlights', {
        {
            event = { 'ColorScheme' },
            pattern = { 'gruvbox' },
            --description = { 'Redefine colorscheme highlights' },
            command = function()
                require('mm.highlights').set_hls({
                    { 'SignColumn', { link = 'Operator', force = true } },
                    { 'Pmenu', { link = 'SignColumn', force = true } },
                    { 'NormalFloat', { link = 'SignColumn', force = true } },
                    { 'CursorLineNR', { link = 'Type', force = true } },
                    { 'TsError', { link = 'SignColumn', force = true } },
                    { 'GitSignsAdd', { link = 'Directory', force = true } },
                    { 'GitSignsChange', { link = 'Include', force = true } },
                    { 'GitSignsDelete', { link = 'SpecialChar', force = true } },
                })
            end,
        }
    })
    vim.g.gruvbox_contrast_dark = 'hard'
    vim.cmd('colorscheme gruvbox')
end
