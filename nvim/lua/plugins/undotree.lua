local map = require('utils').map
local cmd = require('utils').cmd

return {
    'mbbill/undotree',
    event = 'VeryLazy',
    config = function()
        map('n', '<leader>u', cmd('UndotreeToggle'))
    end,
}
