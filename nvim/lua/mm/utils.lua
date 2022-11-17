local fmt = string.format
local levels = vim.log.levels
local fn = vim.fn

local M = { }

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
        packer_notify(
            fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
        )
        vim.cmd('packadd! packer.nvim')

        return true
    else
        mm.safe_require('impatient')

        return false
    end
end

---Require a plugin config
---@param name string
---@return any
function M.conf(name)
    return require(fmt('mm.plugins.%s', name))
end

return M
