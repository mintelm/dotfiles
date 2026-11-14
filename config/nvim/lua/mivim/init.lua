_G.mivim = {}

-- expose modules to global mivim table
_G.mivim.utils = require('mivim.utils')
_G.mivim.style = require('mivim.style')
_G.mivim.lsp = require('mivim.lsp')

-- load core configurations
require('mivim.options')
require('mivim.remaps')
require('mivim.autocmds')
require('mivim.usercmds')

-- load statuscolumn
require('mivim.statuscolumn')

-- bootstrap lazy.nvim
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
    local out = vim.fn.system({ 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
            { out,                            'WarningMsg' },
            { '\nPress any key to exit...' },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- setup lazy.nvim with plugin spec
require('lazy').setup({
    spec = 'mivim.plugins',
    change_detection = { notify = false },
})
