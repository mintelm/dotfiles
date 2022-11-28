local fmt = string.format
local levels = vim.log.levels
local fn = vim.fn

local M = {}

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

---A thin wrapper around vim.notify to add packer details to the message
---@param msg string
local function packer_notify(msg, level)
    vim.notify(msg, level, { title = 'Packer' })
end

-- Make sure packer is installed on the current machine and load
-- the dev or upstream version depending on if we are at work or not
-- NOTE: install packer as an opt plugin since it's loaded conditionally on my local machine
-- it needs to be installed as optional so the install dir is consistent across machines
function M.bootstrap_packer()
    local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

    if fn.empty(fn.glob(install_path)) > 0 then
        packer_notify('Downloading packer.nvim...')
        packer_notify(fn.system({
            'git',
            'clone',
            '--depth',
            '1',
            'https://github.com/wbthomason/packer.nvim',
            install_path,
        }))
        vim.cmd('packadd! packer.nvim')

        return true
    else
        M.safe_require('impatient')

        return false
    end
end

---Require a plugin config
---@param name string
---@return any
function M.conf(name)
    return require(fmt('plugins.%s', name))
end

---Inspect contents of any object
---@vararg any
function M.dump(...)
    local objects = vim.tbl_map(vim.inspect, { ... })
    print(unpack(objects))
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

---Require a module using [pcall] and report any errors
---@param module string
---@param opts table?
---@return boolean, any
function M.safe_require(module, opts)
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
function M.plugin_installed(plugin_name)
    if not installed then
        local dir = vim.fn.expand(vim.fn.stdpath('data') .. '/site/pack/packer/start/*', true, true)
        local opt = vim.fn.expand(vim.fn.stdpath('data') .. '/site/pack/packer/opt/*', true, true)

        vim.list_extend(dir, opt)
        installed = vim.tbl_map(function(path)
            return vim.fn.fnamemodify(path, ':t')
        end, dir)
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
---@param mode string
---@param lhs string
---@param rhs string
---@param opts table
function M.map(mode, lhs, rhs, opts)
    local options = { noremap = true }

    if opts then
        options = vim.tbl_extend('force', options, opts)
    end

    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

return M
