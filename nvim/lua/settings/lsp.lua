local style = require('style')

local lsp_list = { 'lua_ls', 'clangd', 'rust_analyzer', 'pyright', 'bashls', 'cmake' }

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
            [vim.diagnostic.severity.ERROR] = style.icons.lsp.signs.error,
            [vim.diagnostic.severity.WARN] = style.icons.lsp.signs.warn,
            [vim.diagnostic.severity.INFO] = style.icons.lsp.signs.info,
            [vim.diagnostic.severity.HINT] = style.icons.lsp.signs.hint,
        },
    },
})

for _, lsp in ipairs(lsp_list) do
    vim.lsp.enable({ lsp })
end

return lsp_list
