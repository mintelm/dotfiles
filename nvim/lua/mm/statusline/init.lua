-- Resources
-- 1. https://github.com/akinsho/dotfiles/blob/main/.config/nvim/lua/as/statusline/init.lua
-- 2. https://github.com/ahmedelgabri/dotfiles/blob/acf6dc587f6b76024fad32391655fa910fc1ae3e/config/.vim/lua/_/statusline.lua
-- 3. https://github.com/elenapan/dotfiles/blob/master/config/nvim/statusline.vim

local H = require('mm.highlights')
local utils = require('mm.statusline.utils')

local function colors()
    H.all({
        { 'StModeNormal', { link = 'DiffChange' } },
        { 'StModeInsert', { link = 'DiffDelete' } },
        { 'StModeVisual', { link = 'DiffDelete' } },
        { 'StModeReplace', { link = 'DiffDelete' } },
        { 'StModeCommand', { link = 'DiffDelete' } },
    })
end

local function append(tbl, next, priority)
    priority = priority or 0
    local component, length = unpack(next)
    if component and component ~= '' and next and tbl then
        table.insert(tbl, { component = component, priority = priority, length = length })
    end
end

--- @param statusline table
--- @param available_space number
local function display(statusline, available_space)
    local str = ''
    local items = utils.prioritize(statusline, available_space)
    for _, item in ipairs(items) do
        if type(item.component) == 'string' then
            str = str .. item.component
        end
    end

    return str end

---Aggregate pieces of the statusline
---@param tbl table
---@return function
local function make_status(tbl)
    return function(...)
        for i = 1, select('#', ...) do
            local item = select(i, ...)
            append(tbl, unpack(item))
        end
    end
end

function _G.statusline()
    local curwin = vim.g.statusline_winid or 0
    local available_space = vim.api.nvim_win_get_width(curwin)
    local item = utils.item
    local statusline = {}
    local add = make_status(statusline)

    add(
        { item(utils.mode()), 0 }
    )

    return display(statusline, available_space)
end

local function setup_autocommands()
    mm.augroup('CustomStatusLine', {
        {
            events = { 'VimEnter', 'ColorScheme' },
            targets = { '*' },
            command = colors,
        },
    })
end

-- attach autocommands
setup_autocommands()

-- :h qf.vim, disable qf statusline
vim.g.qf_disable_statusline = 1

-- set the statusline
vim.o.statusline = '%!v:lua.statusline()'
