return function()
    local mason_icons = mm.style.icons.lsp.mason

    require('mason').setup({
        ui = {
            icons = {
                package_installed = mason_icons.installed,
                package_pending = mason_icons.pending,
                package_uninstalled = mason_icons.uninstalled,
            },
        },
    })
end
