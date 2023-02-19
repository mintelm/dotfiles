local style = require('style')

return {
    'williamboman/mason.nvim',
    lazy = false,
    priority = 900,
    opts = {
        ui = {
            icons = {
                package_installed = style.icons.lsp.mason.installed,
                package_pending = style.icons.lsp.mason.pending,
                package_uninstalled = style.icons.lsp.mason.uninstalled,
            },
        },
    },
    dependencies = {
        'williamboman/mason-lspconfig.nvim',
        'jayp0521/mason-null-ls.nvim',
        'jayp0521/mason-nvim-dap.nvim',
    },
}
