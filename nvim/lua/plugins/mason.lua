local style = require('style')

local lsp_list = require('settings.lsp')
local lint_list = { 'prettier' }
local dap_list = { 'cppdbg' }

return {
    'williamboman/mason.nvim',
    -- mason must append $PATH ASAP so that the LSP can be loaded when directly opening file with `vim foo.lua`
    event = { 'BufReadPre', 'BufNewFile', 'VeryLazy' },
    dependencies = {
        { 'williamboman/mason-lspconfig.nvim' },
        { 'jay-babu/mason-nvim-dap.nvim' },
        { 'jay-babu/mason-null-ls.nvim' },
    },
    config = function()
        require('mason').setup({
            ui = {
                icons = {
                    package_installed = style.icons.lsp.mason.installed,
                    package_pending = style.icons.lsp.mason.pending,
                    package_uninstalled = style.icons.lsp.mason.uninstalled,
                },
            },
        })
        -- technically not needed since 0.11 but I use it for automatic installation
        require('mason-lspconfig').setup({ ensure_installed = lsp_list })
        require('mason-nvim-dap').setup({
            ensure_installed = dap_list,
            handlers = {} -- automatic setup
        })
        require('mason-null-ls').setup({
            ensure_installed = lint_list,
            handlers = {} -- automatic setup
        })
    end,
}
