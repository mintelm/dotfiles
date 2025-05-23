local style = require('style')

local lsp_list = require('settings.lsp')
local lint_list = { 'prettier' }
local dap_list = { 'cppdbg' }

return {
    'mason-org/mason-lspconfig.nvim',
    opts = {
        ensure_installed = lsp_list,
    },
    dependencies = {
        {
            'mason-org/mason.nvim',
            opts = {
                ui = {
                    icons = {
                        package_installed = style.icons.lsp.mason.installed,
                        package_pending = style.icons.lsp.mason.pending,
                        package_uninstalled = style.icons.lsp.mason.uninstalled,
                    }
                }

            }
        },
        'neovim/nvim-lspconfig',
        {
            'jay-babu/mason-nvim-dap.nvim',
            opts = {
                ensure_installed = dap_list,
                handlers = {} -- automatic setup
            },
        },
        {
            'jay-babu/mason-null-ls.nvim',
            opts = {
                ensure_installed = lint_list,
                handlers = {} -- automatic setup
            },
        },
    },
}
