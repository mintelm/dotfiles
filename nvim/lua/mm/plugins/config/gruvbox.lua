local H = require('mm.highlights')

function override_highlights()
    H.set_hls({
        { 'SignColumn', { link = 'GruvboxFg1', force = true } },
        { 'Pmenu', { link = 'GruvboxFg1', force = true } },
        { 'NormalFloat', { link = 'GruvboxFg1', force = true } },
        { 'CursorLineNR', { link = 'GruvboxYellow', force = true } },
        { 'TsError', { link = 'GruvboxFg1', force = true } },
        { 'GitSignsAdd', { link = 'GruvboxGreen', force = true } },
        { 'GitSignsChange', { link = 'GruvboxAqua', force = true } },
        { 'GitSignsDelete', { link = 'GruvboxRed', force = true } },
        { 'LspDiagnosticsSignError', { link = 'GruvboxRed', force = true } },
        { 'LspDiagnosticsSignHint', { link = 'GruvboxAqua', force = true } },
        { 'LspDiagnosticsSignInformation', { link = 'GruvboxBlue', force = true } },
        { 'LspDiagnosticsSignWarning', { link = 'GruvboxYellow', force = true } },
    })
end

return function()
    vim.g.gruvbox_contrast_dark = 'hard'
    vim.cmd('colorscheme gruvbox')
    override_highlights()
    -- apply highlights whenever colorscheme changes
    mm.augroup('UserHighlights', {
        {
            events = { 'ColorScheme' },
            targets = { '*' },
            command = override_highlights,
        }
    })
end
