local cmd = require('utils').cmd

return {
    'mbbill/undotree',
    event = 'VeryLazy',
    keys = {
        { '<leader>u', cmd('UndotreeToggle') },
    },
}
