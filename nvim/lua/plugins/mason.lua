local style = require('style')

return {
    'williamboman/mason.nvim',
    opts = {
        ui = {
            icons = {
                package_installed = style.icons.lsp.mason.installed,
                package_pending = style.icons.lsp.mason.pending,
                package_uninstalled = style.icons.lsp.mason.uninstalled,
            },
        },
    },
}
