-- Resources
-- 1. https://github.com/akinsho/dotfiles/blob/main/.config/nvim/lua/as/highlights.lua
local fmt = string.format

local M = { }

--- NOTE: vim.highlight's link and create are private, so
--- eventually move to using `nvim_set_hl`
---@param name string
---@param opts table
function M.set_hl(name, opts)
    assert(name and opts, "Both 'name' and 'opts' must be specified")
    if not vim.tbl_isempty(opts) then
        if opts.link then
            vim.highlight.link(name, opts.link, opts.force)
        else
            vim.highlight.create(name, opts)
        end
    end
end

---Apply a list of highlights
---@param hls table[]
function M.all(hls)
    for _, hl in ipairs(hls) do
        M.set_hl(unpack(hl))
    end
end

vim.g.gruvbox_contrast_dark = 'hard'
vim.cmd('colorscheme gruvbox')

local function general_overrides()
    M.all({
        { 'TsError', { link = 'NormalFloat', force = true } },
        { 'SignColumn', { link = 'NormalFloat', force = true } },
        { 'Pmenu', { link = 'NormalFloat', force = true } },
    })
end

local function gruvbox_overrides()
    if vim.g.colors_name == 'gruvbox' then
        M.all({
            { 'NormalFloat', { link = 'GruvboxFg1', force = true } },
            { 'CursorLineNR', { link = 'GruvboxYellow', force = true } },
            { 'GitSignsAdd', { link = 'GruvboxGreen', force = true } },
            { 'GitSignsChange', { link = 'GruvboxAqua', force = true } },
            { 'GitSignsDelete', { link = 'GruvboxRed', force = true } },
            { 'LspDiagnosticsSignError', { link = 'GruvboxRed', force = true } },
            { 'LspDiagnosticsSignHint', { link = 'GruvboxAqua', force = true } },
            { 'LspDiagnosticsSignInformation', { link = 'GruvboxBlue', force = true } },
            { 'LspDiagnosticsSignWarning', { link = 'GruvboxYellow', force = true } },
        })
    end
end

local function user_highlights()
    gruvbox_overrides()
    general_overrides()
end

---NOTE: apply user highlights when nvim first starts
--- then whenever the colorscheme changes
user_highlights()

mm.augroup('UserHighlights', {
    {
        events = { 'ColorScheme' },
        targets = { '*' },
        command = user_highlights,
    }
})

return M
