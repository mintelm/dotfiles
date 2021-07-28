local fn = vim.fn
local strwidth = fn.strwidth

local M = { }

local function sum_lengths(tbl)
    local length = 0
    for _, c in ipairs(tbl) do
        if c.length then
        length = c.length + length
        end
    end

    return length
end

local function is_lowest(item, lowest)
    -- if there hasn't been a lowest selected so far
    -- then the item is the lowest
    if not lowest or not lowest.length then
        return true
    end
    -- if the item doesn't have a priority or a length
    -- it is likely a special character so should never
    -- be the lowest
    if not item.priority or not item.length then
        return false
    end
    -- if the item has the same priority as the lowest then if the item
    -- has a greater length it should become the lowest
    if item.priority == lowest.priority then
        return item.length > lowest.length
    end

    return item.priority > lowest.priority
end

--- Take the lowest priority items out of the statusline if we don't have
--- space for them.
--- TODO currently this doesn't account for if an item that has a lower priority
--- could be fit in instead
--- @param statusline table
--- @param space number
--- @param length number
function M.prioritize(statusline, space, length)
    length = length or sum_lengths(statusline)
    if length <= space then
        return statusline
    end
    local lowest
    local index_to_remove
    for idx, c in ipairs(statusline) do
        if is_lowest(c, lowest) then
        lowest = c
        index_to_remove = idx
        end
    end
    table.remove(statusline, index_to_remove)
    return M.prioritize(statusline, space, length - lowest.length)
end

local function mode_highlight(mode)
    local visual_regex = vim.regex [[\(v\|V\|\)]]
    local command_regex = vim.regex [[\(c\|cv\|ce\)]]
    local replace_regex = vim.regex [[\(Rc\|R\|Rv\|Rx\)]]
    if mode == 'i' then
        return 'StModeInsert'
    elseif visual_regex:match_str(mode) then
        return 'StModeVisual'
    elseif replace_regex:match_str(mode) then
        return 'StModeReplace'
    elseif command_regex:match_str(mode) then
        return 'StModeCommand'
    else
        return 'StModeNormal'
    end
end

function M.mode()
    local current_mode = vim.fn.mode()
    local hl = mode_highlight(current_mode)

    local mode_map = {
        ['n'] = 'NORMAL',
        ['no'] = 'N·OPERATOR PENDING ',
        ['v'] = 'VISUAL',
        ['V'] = 'V·LINE',
        [''] = 'V·BLOCK',
        ['s'] = 'SELECT',
        ['S'] = 'S·LINE',
        ['^S'] = 'S·BLOCK',
        ['i'] = 'INSERT',
        ['R'] = 'REPLACE',
        ['Rv'] = 'V·REPLACE',
        ['Rx'] = 'C·REPLACE',
        ['Rc'] = 'C·REPLACE',
        ['c'] = 'COMMAND',
        ['cv'] = 'VIM EX',
        ['ce'] = 'EX',
        ['r'] = 'PROMPT',
        ['rm'] = 'MORE',
        ['r?'] = 'CONFIRM',
        ['!'] = 'SHELL',
        ['t'] = 'TERMINAL',
    }

    return (mode_map[current_mode] or 'UNKNOWN'), hl
end

--- @param hl string
function M.wrap(hl)
    assert(hl, 'A highlight name must be specified')
    return '%#' .. hl .. '#'
end

--- @param component string
--- @param hl string
--- @param opts table
function M.item(component, hl, opts)
    -- do not allow empty values to be shown note 0 is considered empty
    -- since if there is nothing of something I don't need to see it
    if not component or component == '' or component == 0 then
        return M.spacer()
    end
    opts = opts or {}
    local before = opts.before or ''
    local after = opts.after or ' '
    local prefix = opts.prefix or ''
    local prefix_size = strwidth(prefix)

    local prefix_color = opts.prefix_color or hl
    prefix = prefix ~= '' and M.wrap(prefix_color) .. prefix .. ' ' or ''

    --- handle numeric inputs etc.
    if type(component) ~= 'string' then
        component = tostring(component)
    end

    if opts.max_size and component and #component >= opts.max_size then
        component = component:sub(1, opts.max_size - 1) .. '…'
    end

    local parts = { before, prefix, M.wrap(hl), component, '%*', after }
    return { table.concat(parts), #component + #before + #after + prefix_size }
end

return M
