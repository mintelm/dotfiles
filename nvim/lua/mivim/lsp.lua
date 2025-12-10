local M = {}

M.list = { 'lua_ls', 'clangd', 'rust_analyzer', 'pyright', 'bashls', 'cmake' }

vim.lsp.config('*', {
    capabilities = {
        textDocument = {
            semanticTokens = {
                multilineTokenSupport = true,
            },
        },
    },
    root_markers = { '.git' },
})

vim.diagnostic.config({
    severity_sort = true,
    float = {
        header = '',
        source = 'if_many',
    },
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = mivim.style.icons.lsp.signs.error,
            [vim.diagnostic.severity.WARN] = mivim.style.icons.lsp.signs.warn,
            [vim.diagnostic.severity.INFO] = mivim.style.icons.lsp.signs.info,
            [vim.diagnostic.severity.HINT] = mivim.style.icons.lsp.signs.hint,
        },
    },
})

-- mason.nvim already does this
-- for _, lsp in ipairs(M.list) do
--     vim.lsp.enable({ lsp })
-- end

return M
