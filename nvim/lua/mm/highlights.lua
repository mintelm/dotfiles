-- Resources
-- 1. https://github.com/akinsho/dotfiles/blob/main/.config/nvim/lua/as/highlights.lua
local fmt = string.format

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

local function alter(attr, percent)
  return math.floor(attr * (100 + percent) / 100)
end

---@source https://stackoverflow.com/q/5560248
---@see: https://stackoverflow.com/a/37797380
---Darken a specified hex color
---@param color string
---@param percent number
---@return string
function M.darken_color(color, percent)
    local r, g, b = hex_to_rgb(color)
    if not r or not g or not b then
        return 'NONE'
    end
    r, g, b = alter(r, percent), alter(g, percent), alter(b, percent)
    r, g, b = math.min(r, 255), math.min(g, 255), math.min(b, 255)
    return string.format('#%02x%02x%02x', r, g, b)
end

--- Check if the current window has a winhighlight
--- which includes the specific target highlight
--- @param win_id integer
--- @vararg string
function M.has_win_highlight(win_id, ...)
    local win_hl = vim.wo[win_id].winhighlight
    for _, target in ipairs { ... } do
        if win_hl:match(target) ~= nil then
        return true, win_hl
        end
    end
    return false, win_hl
end

---A mechanism to allow inheritance of the winhighlight of a specific
---group in a window
---@param win_id number
---@param target string
---@param name string
---@param default string
function M.adopt_winhighlight(win_id, target, name, default)
    name = name .. win_id
    local _, win_hl = M.has_win_highlight(win_id, target)
    local hl_exists = vim.fn.hlexists(name) > 0
    if not hl_exists then
        local parts = vim.split(win_hl, ',')
        local found = mm.find(parts, function(part)
            return part:match(target)
        end)
        if found then
            local hl_group = vim.split(found, ':')[2]
            local bg = M.get_hl(hl_group, 'bg')
            local fg = M.get_hl(default, 'fg')
            local gui = M.get_hl(default, 'gui')
            M.set_hl(name, { guibg = bg, guifg = fg, gui = gui })
        end
    end
    return name
end


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
            local ok, msg = pcall(vim.highlight.create, name, opts)
            if not ok then
                vim.notify(fmt('Failed to set %s because: %s', name, msg))
            end
        end
    end
end


---convert a table of gui values into a string
---@param hl table<string, string>
---@return string
local function flatten_gui(hl)
    local gui_attr = { 'underline', 'bold', 'undercurl', 'italic' }
    local gui = {}
    for name, value in pairs(hl) do
        if value and vim.tbl_contains(gui_attr, name) then
        table.insert(gui, name)
        end
    end
    return table.concat(gui, ',')
end

---Get the value a highlight group
---this function is a small wrapper around `nvim_get_hl_by_name`
---which handles errors, fallbacks as well as returning a gui value
---in the right format
---@param grp string
---@param attr string
---@param fallback string
---@return string
function M.get_hl(grp, attr, fallback)
    assert(grp, 'Cannot get a highlight without specifying a group')
    local attrs = { fg = 'foreground', bg = 'background' }
    attr = attrs[attr] or attr
    local hl = vim.api.nvim_get_hl_by_name(grp, true)
    if attr == 'gui' then
        return flatten_gui(hl)
    end
    local color = hl[attr] or fallback
    -- convert the decimal rgba value from the hl by name to a 6 character hex + padding if needed
    if not color then
        vim.notify(fmt('%s %s does not exist', grp, attr))
        return 'NONE'
    end
    -- convert the decimal rgba value from the hl by name to a 6 character hex + padding if needed
    return '#' .. bit.tohex(color, 6)
end

function M.clear_hl(name)
    if not name then
        return
    end
    vim.cmd(fmt('highlight clear %s', name))
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
