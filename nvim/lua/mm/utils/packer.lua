local M = {}

local fmt = string.format
local fn = vim.fn

---A thin wrapper around vim.notify to add packer details to the message
---@param msg string
function M.packer_notify(msg, level)
    vim.notify(msg, level, { title = 'Packer' })
end

-- Make sure packer is installed on the current machine and load
-- the dev or upstream version depending on if we are at work or not
-- NOTE: install packer as an opt plugin since it's loaded conditionally on my local machine
-- it needs to be installed as optional so the install dir is consistent across machines
function M.bootstrap_packer()
    local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        M.packer_notify('Downloading packer.nvim...')
        M.packer_notify(
            fn.system({ 'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path })
        )
    else
        mm.safe_require('impatient')
    end
    vim.cmd('packadd! packer.nvim')
end

---Require a plugin config
---@param name string
---@return any
function M.conf(name)
    return require(fmt('mm.plugins.%s', name))
end

return M
