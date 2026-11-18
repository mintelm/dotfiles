local servers = { 'lua_ls', 'clangd', 'pyright', 'bashls', 'cmake' }

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
    jump = {
        -- show the diagnostic that was jumped to
        on_jump = function(diagnostic, bufnr)
            if diagnostic then
                vim.diagnostic.open_float({ bufnr = bufnr, scope = 'cursor', focus = false })
            end
        end,
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

vim.lsp.enable(servers)
