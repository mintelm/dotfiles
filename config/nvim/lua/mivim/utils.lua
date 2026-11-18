local M = {}

--- Inspect contents of any object
--- @vararg any
function M.dump(...)
    local objects = {}
    for i = 1, select('#', ...) do
        objects[i] = vim.inspect((select(i, ...)))
    end
    vim.notify(table.concat(objects, '\n'))
end

--- Set tabstop, shiftwdith and expandtab/smartindent accordingly
--- @param tab_width number
function M.set_tab_width(tab_width)
    if tab_width >= 8 then
        -- use real tabs
        vim.bo.expandtab = false
        vim.bo.smartindent = false
    else
        vim.bo.expandtab = true
        vim.bo.smartindent = true
    end
    vim.bo.tabstop = tab_width
    vim.bo.shiftwidth = tab_width
    vim.bo.softtabstop = tab_width
end

--- Set global silent vim keymap
--- @param mode string|table
--- @param lhs string
--- @param rhs string|function
--- @param opts? table
function M.map(mode, lhs, rhs, opts)
    vim.keymap.set(mode, lhs, rhs, vim.tbl_extend('force', { silent = true }, opts or {}))
end

--- Build command table
--- @param command string
--- @tparam[opt] suffix string
--- @return string
function M.cmd(command, suffix)
    suffix = suffix or ''
    return '<cmd>' .. command .. '<CR>' .. suffix
end

--- Returns a autocommand group
function M.augroup(name, clear)
    if clear == nil then clear = true end
    return vim.api.nvim_create_augroup('mivim_' .. name, { clear = clear })
end

--- Delete all hidden buffers
function M.delete_hidden_buffers()
    local function buffer_filter(buf)
        return not vim.api.nvim_buf_is_valid(buf) or not vim.bo[buf].buflisted
    end
    local buffers = vim.tbl_filter(buffer_filter, vim.api.nvim_list_bufs())

    for _, buffer in ipairs(buffers) do
        vim.cmd('bwipeout!' .. ' ' .. buffer)
    end
end

return M
