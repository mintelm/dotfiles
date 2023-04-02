local M = {}

---Inspect contents of any object
---@vararg any
function M.dump(...)
    local objects = vim.tbl_map(vim.inspect, { ... })
    ---@diagnostic disable-next-line: deprecated
    vim.notify(unpack(objects))
end

---Set tabstop, shiftwdith and expandtab/smartindent accordingly
---@param tab_width number
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

---Merge table t1, t2
---Source: https://stackoverflow.com/questions/1283388/lua-merge-tables
---@param t1 table
---@param t2 table
---@return table
function M.merge(t1, t2)
    for k, v in pairs(t2) do
        if (type(v) == 'table') and (type(t1[k] or false) == 'table') then
            M.merge(t1[k], t2[k])
        else
            t1[k] = v
        end
    end

    return t1
end

---@class Autocommand
---@field description string
---@field event  string[] list of autocommand events
---@field pattern string[] list of autocommand patterns
---@field command string | function
---@field nested  boolean
---@field once    boolean
---@field buffer  number

---Create an autocommand
---returns the group ID so that it can be cleared or manipulated.
---@param name string
---@param commands Autocommand[]
---@return number
function M.augroup(name, commands)
    local id = vim.api.nvim_create_augroup(name, { clear = true })

    for _, autocmd in ipairs(commands) do
        local is_callback = type(autocmd.command) == 'function'

        vim.api.nvim_create_autocmd(autocmd.event, {
            group = name,
            pattern = autocmd.pattern,
            desc = autocmd.description,
            callback = is_callback and autocmd.command or nil,
            command = not is_callback and autocmd.command or nil,
            once = autocmd.once,
            nested = autocmd.nested,
            buffer = autocmd.buffer,
        })
    end

    return id
end

---Set global vim keymap
---@param mode string|table
---@param lhs string
---@param rhs string|function
---@param opts table
function M.map(mode, lhs, rhs, opts)
    local options = { noremap = true }

    if opts then
        options = M.merge(options, opts)
    end

    vim.keymap.set(mode, lhs, rhs, options)
end

---Set global vim keymap
---@param str string
---@param l boolean
---@param r boolean
---@return string
function M.pad_str(str, l, r)
    if l then
        str = ' ' .. str
    end
    if r then
        str = str .. ' '
    end
    return str
end

---Build command table
---@param command string
---@tparam[opt] suffix string
---@return string
function M.cmd(command, suffix)
    suffix = suffix or ''
    return '<cmd>' .. command .. '<CR>' .. suffix
end

_G.dump = M.dump

return M
