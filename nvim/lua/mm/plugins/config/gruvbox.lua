local H = require('mm.highlights')

function override_highlights()
    H.set_hls({
        { 'SignColumn', { link = 'Operator', force = true } },
        { 'Pmenu', { link = 'SignColumn', force = true } },
        { 'NormalFloat', { link = 'SignColumn', force = true } },
        { 'CursorLineNR', { link = 'Type', force = true } },
        { 'TsError', { link = 'SignColumn', force = true } },
        { 'GitSignsAdd', { link = 'Directory', force = true } },
        { 'GitSignsChange', { link = 'Include', force = true } },
        { 'GitSignsDelete', { link = 'SpecialChar', force = true } },
    })
end

return function()
    mm.augroup('UserHighlights', {
        {
            events = { 'ColorScheme' },
            targets = { 'gruvbox' },
            command = override_highlights,
        }
    })
    vim.g.gruvbox_contrast_dark = 'hard'
    vim.cmd('colorscheme gruvbox')
end
