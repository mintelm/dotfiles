local style = require('style')

local function lsp_config()
    local float_opts = {
        border = style.current.border,
        focusable = false,
        source = 'always',
        prefix = '',
        header = '',
    }

    vim.diagnostic.config({
        update_in_insert = false,
        virtual_text = false,
        severity_sort = true,
        float = float_opts,
    })
    vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, float_opts)
    vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, float_opts)

    for type, icon in pairs(style.icons.lsp.signs) do
        type = type:sub(1, 1):upper() .. type:sub(2)
        local sign = 'DiagnosticSign' .. type
        local hl = 'Diagnostic' .. type

        vim.fn.sign_define(sign, { text = icon, texthl = hl, numhl = hl })
    end

    local ns = vim.api.nvim_create_namespace('diagonstic_severity_filter')
    local orig_signs_handler = vim.diagnostic.handlers.signs

    vim.diagnostic.handlers.signs = {
        show = function(_, bufnr, _, opts)
            local diagnostics = vim.diagnostic.get(bufnr)

            local max_severity_per_line = {}
            for _, d in pairs(diagnostics) do
                local m = max_severity_per_line[d.lnum]
                if not m or d.severity < m.severity then
                    max_severity_per_line[d.lnum] = d
                end
            end

            local filtered_diagnostics = vim.tbl_values(max_severity_per_line)
            orig_signs_handler.show(ns, bufnr, filtered_diagnostics, opts)
        end,
        hide = function(_, bufnr)
            orig_signs_handler.hide(ns, bufnr)
        end,
    }
end

local function mason_lsp_config()
    require('mason-lspconfig').setup()
    require('mason-lspconfig').setup_handlers({
        function(server_name)
            require('lspconfig')[server_name].setup({})
        end,
        ['lua_ls'] = function()
            require('lspconfig')['lua_ls'].setup({
                settings = {
                    Lua = {
                        runtime = {
                            version = 'LuaJIT',
                        },
                        diagnostics = {
                            globals = { 'vim' },
                        },
                        workspace = {
                            library = vim.api.nvim_get_runtime_file('', true),
                        },
                        telemetry = {
                            enable = false,
                        },
                    },
                },
            })
        end,
        ['clangd'] = function()
            require('lspconfig')['clangd'].setup({
                capabilities = { offsetEncoding = 'utf-8' },
            })
        end,
    })
end

return {
    'neovim/nvim-lspconfig',
    config = lsp_config,
    dependencies = {
        {
            'williamboman/mason-lspconfig.nvim',
            config = mason_lsp_config,
        },
        {
            'ray-x/lsp_signature.nvim',
            opts = {
                bind = true,
                handler_opts = {
                    border = style.current.border,
                },
                hint_enable = false,
            },
        },
    },
}
