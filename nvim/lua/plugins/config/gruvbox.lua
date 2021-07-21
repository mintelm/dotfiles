return function()
    vim.g.gruvbox_contrast_dark = 'hard'
    vim.cmd([[colorscheme gruvbox]])
    vim.cmd('highlight! clear TSError')
    vim.cmd('highlight! clear SignColumn')
    vim.cmd('highlight! link CursorLineNR GruvboxYellow')
    vim.cmd('highlight! link GitSignsAdd GruvboxGreen')
    vim.cmd('highlight! link GitSignsChange GruvboxAqua')
    vim.cmd('highlight! link GitSignsDelete GruvboxRed')
    vim.cmd('highlight! link LspDiagnosticsSignError GruvboxRed')
    vim.cmd('highlight! link LspDiagnosticsSignHint GruvboxAqua')
    vim.cmd('highlight! link LspDiagnosticsSignInformation GruvboxBlue')
    vim.cmd('highlight! link LspDiagnosticsSignWarning GruvboxYellow')
end
