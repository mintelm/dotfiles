local fmt = string.format
local levels = vim.log.levels
local lsp_colors = mm.style.lsp.colors

local M = { }

---Convert a hex color to rgb
---@param color string
---@return number
---@return number
---@return number
local function hex_to_rgb(color)
    local hex = color:gsub('#', '')

    return tonumber(hex:sub(1, 2), 16), tonumber(hex:sub(3, 4), 16), tonumber(hex:sub(5), 16)
end

---Darken a specified hex color
---@source https://stackoverflow.com/q/5560248
---@see: https://stackoverflow.com/a/37797380
---@param color string
---@param percent number
---@return string
function M.alter_color(color, percent)
    local r, g, b = hex_to_rgb(color)
    local alter = function(attr, _percent)
        return math.floor(attr * (100 + _percent) / 100)
    end

    if not r or not g or not b then
        return 'NONE'
    end

    r, g, b = alter(r, percent), alter(g, percent), alter(b, percent)
    r, g, b = math.min(r, 255), math.min(g, 255), math.min(b, 255)

    return string.format('#%02x%02x%02x', r, g, b)
end

---Check if the current window has a winhighlight
---which includes the specific target highlight
---@param win_id integer
---@vararg string
function M.winhighlight_exists(win_id, ...)
    local win_hl = vim.wo[win_id].winhighlight

    for _, target in ipairs { ... } do
        if win_hl:match(target) ~= nil then
            return true, win_hl
        end
    end

    return false, win_hl
end

---@param group_name string A highlight group name
local function get_hl(group_name)
    local ok, hl = pcall(vim.api.nvim_get_hl_by_name, group_name, true)

    if ok then
        hl.foreground = hl.foreground and '#' .. bit.tohex(hl.foreground, 6)
        hl.background = hl.background and '#' .. bit.tohex(hl.background, 6)
        hl[true] = nil -- BUG: API returns a true key which errors during the merge
        return hl
    end

    return {}
end

---A mechanism to allow inheritance of the winhighlight of a specific
---group in a window
---@param win_id number
---@param target string
---@param name string
---@param fallback string
function M.adopt_winhighlight(win_id, target, name, fallback)
    local win_hl_name = name .. win_id
    local _, win_hl = M.winhighlight_exists(win_id, target)
    local hl_exists = vim.fn.hlexists(win_hl_name) > 0

    if hl_exists then
        return win_hl_name
    end

    local parts = vim.split(win_hl, ',')
    local found = mm.find(parts, function(part)
        return part:match(target)
    end)

    if not found then
        return fallback
    end

    local hl_group = vim.split(found, ':')[2]
    local bg = M.get_hl(hl_group, 'bg')
    M.set_hl(win_hl_name, { background = bg, inherit = fallback })

    return win_hl_name
end

---This helper takes a table of highlights and converts any highlights
---specified as `highlight_prop = { from = 'group'}` into the underlying colour
---by querying the highlight property of the from group so it can be used when specifying highlights
---as a shorthand to derive the right color.
---For example:
---```lua
---  M.set_hl({ MatchParen = {foreground = {from = 'ErrorMsg'}}})
---```
---This will take the foreground colour from ErrorMsg and set it to the foreground of MatchParen.
---@param opts table<string, string|boolean|table<string,string>>
local function convert_hl_to_val(opts)
    for name, value in pairs(opts) do
        if type(value) == 'table' and value.from then
            opts[name] = M.get_hl(value.from, vim.F.if_nil(value.attr, name))
        end
    end
end

---@param name string
---@param opts table
function M.set_hl(name, opts)
    assert(name and opts, "Both 'name' and 'opts' must be specified")

    local hl = get_hl(opts.inherit or name)

    convert_hl_to_val(opts)
    opts.inherit = nil

    local ok, msg = pcall(vim.api.nvim_set_hl, 0, name, vim.tbl_deep_extend('force', hl, opts))
    if not ok then
        vim.notify(fmt('Failed to set %s because: %s', name, msg))
    end
end

---Get the value a highlight group whilst handling errors, fallbacks as well as returning a gui value
---in the right format
---@param group string
---@param attribute string
---@param fallback string?
---@return string
function M.get_hl(group, attribute, fallback)
    if not group then
        vim.notify('Cannot get a highlight without specifying a group', levels.ERROR)
        return 'NONE'
    end

    local hl = get_hl(group)
    attribute = ({ fg = 'foreground', bg = 'background' })[attribute] or attribute
    local color = hl[attribute] or fallback

    if not color then
        vim.schedule(function()
            vim.notify(fmt('%s %s does not exist', group, attribute), levels.INFO)
        end)

        return 'NONE'
    end

    -- convert the decimal RGBA value from the hl by name to a 6 character hex + padding if needed
    return color
end

function M.clear_hl(name)
    assert(name, 'name is required to clear a highlight')
    vim.api.nvim_set_hl(0, name, {})
end

---Apply a list of highlights
---@param hls table<string, table<string, boolean|string>>
function M.all(hls)
    for name, hl in pairs(hls) do
        M.set_hl(name, hl)
    end
end

---Apply highlights for a plugin and refresh on colorscheme change
---@param name string plugin name
---@vararg table<string, table> map of highlights
function M.plugin(name, hls)
    name = name:gsub('^%l', string.upper) -- capitalise the name for autocommand convention sake
    M.all(hls)
    mm.augroup(fmt('%sHighlightOverrides', name), {
        {
            event = 'ColorScheme',
            command = function()
                M.all(hls)
            end,
        },
    })
end

local function colorscheme_overrides()
    local bg_base = M.get_hl('Normal', 'bg')
    local inactive_bg_color = M.alter_color(bg_base, -10)
    local hint_line = M.alter_color(lsp_colors.hint, -70)
    local error_line = M.alter_color(lsp_colors.error, -80)
    local warn_line = M.alter_color(lsp_colors.warn, -80)

    M.all({
        -----------------------------------------------------------------------------//
        -- General overrides
        -----------------------------------------------------------------------------//
        VertSplit = { background = inactive_bg_color, foreground = inactive_bg_color },
        WinSeparator = { background = inactive_bg_color, foreground = inactive_bg_color },
        SignColumn = { background = 'NONE' },
        CursorLine = { background = 'NONE' },
        CursorLineNR = { background = 'NONE', bold = true },
        Pmenu = { background = 'NONE' },
        --TSError = { undercurl = true, sp = 'DarkRed', foreground = 'NONE' },
        SpellBad = { undercurl = true, background = 'NONE', foreground = 'NONE', sp = 'green' },
        MatchParen = {
            background = 'NONE',
            foreground = 'NONE',
            bold = true,
            underlineline = true,
            sp = 'NONE',
        },
        -----------------------------------------------------------------------------//
        -- Floats
        -----------------------------------------------------------------------------//
        NormalFloat = { link = 'Pmenu' },
        FloatBorder = { background = 'NONE', foreground = { from = 'NonText' } },
        -----------------------------------------------------------------------------//
        -- LSP
        -----------------------------------------------------------------------------//
        LspCodeLens = { link = 'NonText' },
        LspReferenceText = { underline = true, background = 'NONE' },
        LspReferenceRead = { underline = true, background = 'NONE' },
        -- This represents when a reference is assigned which is more interesting than regular
        -- occurrences so should be highlighted more distinctly
        LspReferenceWrite = { underline = true, bold = true, italic = true, background = 'NONE' },
        DiagnosticHint = { foreground = lsp_colors.hint },
        DiagnosticError = { foreground = lsp_colors.error },
        DiagnosticWarning = { foreground = lsp_colors.warn },
        DiagnosticInfo = { foreground = lsp_colors.info },
        DiagnosticUnderlineError = {
            underline = false,
            undercurl = true,
            sp = lsp_colors.error,
            foreground = 'none',
        },
        DiagnosticUnderlineHint = {
            underline = false,
            undercurl = true,
            sp = lsp_colors.hint,
            foreground = 'none',
        },
        DiagnosticUnderlineWarn = {
            underline = false,
            undercurl = true,
            sp = lsp_colors.warn,
            foreground = 'none',
        },
        DiagnosticUnderlineInfo = {
            underline = false,
            undercurl = true,
            sp = lsp_colors.info,
            foreground = 'none',
        },
        DiagnosticSignHintLine = { background = hint_line },
        DiagnosticSignErrorLine = { background = error_line },
        DiagnosticSignWarnLine = { background = warn_line },
        DiagnosticSignHintNr = {
            inherit = 'DiagnosticSignHintLine',
            foreground = { from = 'Normal' },
            bold = true,
        },
        DiagnosticSignErrorNr = {
            inherit = 'DiagnosticSignErrorLine',
            foreground = { from = 'Normal' },
            bold = true,
        },
        DiagnosticSignWarnNr = {
            inherit = 'DiagnosticSignWarnLine',
            foreground = { from = 'Normal' },
            bold = true,
        },
        DiagnosticSignWarn = { link = 'DiagnosticWarn' },
        DiagnosticSignInfo = { link = 'DiagnosticInfo' },
        DiagnosticSignHint = { link = 'DiagnosticHint' },
        DiagnosticSignError = { link = 'DiagnosticError' },
        DiagnosticFloatingWarn = { link = 'DiagnosticWarn' },
        DiagnosticFloatingInfo = { link = 'DiagnosticInfo' },
        DiagnosticFloatingHint = { link = 'DiagnosticHint' },
        DiagnosticFloatingError = { link = 'DiagnosticError' },
    })
end

mm.augroup('UserHighlights', {
    {
        event = 'ColorScheme',
        command = function()
            colorscheme_overrides()
        end,
    },
})

if mm.plugin_installed('gruvbox.nvim') then
    require('gruvbox').setup({
        contrast = 'hard',
    })
    vim.cmd('colorscheme gruvbox')
end

return M
