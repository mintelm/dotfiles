local fmt = string.format

_G.mm = { }

---Inspect contents of any object
---@vararg any
function mm.dump(...)
    local objects = vim.tbl_map(vim.inspect, { ... })
    print(unpack(objects))
end

---Set tabstop, shiftwdith and expandtab/smartindent accordingly
---@param tab_width number
function mm.set_tab_width(tab_width)
    if (tab_width >= 8) then
        -- use real tabs
        vim.bo.expandtab = false
        vim.bo.smartindent = false
    else
        vim.bo.expandtab = true
        vim.bo.smartindent = true
    end
    vim.bo.tabstop = tab_width
    vim.bo.shiftwidth = tab_width
end

---Merge table t1, t2
---Source: https://stackoverflow.com/questions/1283388/lua-merge-tables
---@param t1 table
---@param t2 table
---@return table
function mm.merge(t1, t2)
    for k, v in pairs(t2) do
        if (type(v) == 'table') and (type(t1[k] or false) == 'table') then
            mm.merge(t1[k], t2[k])
        else
            t1[k] = v
        end
    end

    return t1
end

---Require a module using [pcall] and report any errors
---@param module string
---@param opts table?
---@return boolean, any
function mm.safe_require(module, opts)
    opts = opts or { silent = false }
    local ok, result = pcall(require, module)

    if not ok and not opts.silent then
        vim.notify(result, vim.log.levels.error, { title = fmt('Error requiring: %s', module) })
    end

    return ok, result
end

local installed
---Check if a plugin is on the system not whether or not it is loaded
---@param plugin_name string
---@return boolean
function mm.plugin_installed(plugin_name)
    if not installed then
        local dirs = vim.fn.expand(vim.fn.stdpath('data') .. '/site/pack/packer/start/*', true, true)
        local opt = vim.fn.expand(vim.fn.stdpath('data') .. '/site/pack/packer/opt/*', true, true)

        vim.list_extend(dirs, opt)
        installed = vim.tbl_map(function(path)
            return vim.fn.fnamemodify(path, ':t')
        end, dirs)
    end

    return vim.tbl_contains(installed, plugin_name)
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
function mm.augroup(name, commands)
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
---@param mode string
---@param lhs string
---@param rhs string
---@param opts table
function mm.map(mode, lhs, rhs, opts)
    local options = { noremap = true }

    if opts then
        options = vim.tbl_extend('force', options, opts)
    end

    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

---Set buffer vim keymap
---@param bufnr number
---@param mode string
---@param lhs string
---@param rhs string
---@param opts table
function mm.bmap(bufnr, mode, lhs, rhs, opts)
    local options = { noremap = true }

    if opts then
        options = vim.tbl_extend('force', options, opts)
    end

    vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, options)
end
