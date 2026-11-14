return {
    'mason-org/mason.nvim',
    opts = {
        ui = {
            icons = {
                package_installed = mivim.style.icons.lsp.mason.installed,
                package_pending = mivim.style.icons.lsp.mason.pending,
                package_uninstalled = mivim.style.icons.lsp.mason.uninstalled,
            }
        }
    }
}
