return function()
    local cmp_nvim_lsp_loaded, cmp_nvim_lsp = mm.safe_require('cmp_nvim_lsp')
    local float_opts = {
        border = mm.style.current.border,
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

    -- setup lsp signs
    for type, icon in pairs(mm.style.icons.lsp.signs) do
        type = type:sub(1,1):upper()..type:sub(2)
        local sign = 'DiagnosticSign' .. type
        local hl = 'Diagnostic' .. type

        vim.fn.sign_define(sign, { text = icon, texthl = hl, numhl = hl })
    end

    -- override handlers
    local ns = vim.api.nvim_create_namespace('diagnostic-severity')
    local orig_signs_handler = vim.diagnostic.handlers.signs
    vim.diagnostic.handlers.signs = {
        show = function(_, bufnr, _, opts)
            -- Get all diagnostics from the whole buffer rather than just the
            -- diagnostics passed to the handler
            local diagnostics = vim.diagnostic.get(bufnr)

            -- Find the 'worst' diagnostic per line
            local max_severity_per_line = {}
            for _, d in pairs(diagnostics) do
                local m = max_severity_per_line[d.lnum]
                if not m or d.severity < m.severity then
                    max_severity_per_line[d.lnum] = d
                end
            end

            -- Pass the filtered diagnostics (with our custom namespace) to
            -- the original handler
            local filtered_diagnostics = vim.tbl_values(max_severity_per_line)
            orig_signs_handler.show(ns, bufnr, filtered_diagnostics, opts)
        end,
        hide = function(_, bufnr)
            orig_signs_handler.hide(ns, bufnr)
        end,
    }
    vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, float_opts)
    vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, float_opts)

    local server_config = { }

    if cmp_nvim_lsp_loaded then
        server_config.capabilities = cmp_nvim_lsp.default_capabilities()
    else
        server_config.capabilities = vim.lsp.protocol.make_client_capabilities()
    end

    require('mason-lspconfig').setup()
    require('mason-lspconfig').setup_handlers({
        -- default handler
        function (server_name)
            require('lspconfig')[server_name].setup(server_config)
        end,
        -- specific handlers
        ['sumneko_lua'] = function()
            server_config.settings = {
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
            }
            require('lspconfig')['sumneko_lua'].setup(server_config)
        end,
        ['clangd'] = function()
            server_config.capabilities.offsetEncoding = 'utf-8'
            require('lspconfig')['clangd'].setup(server_config)
        end,
    })
end
