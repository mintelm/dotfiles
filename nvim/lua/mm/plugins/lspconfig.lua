return function()
    local cmp_nvim_lsp_loaded, cmp_nvim_lsp = mm.safe_require('cmp_nvim_lsp')
    local lsp_mappings = require('mm.keymappings').lsp_mappings
    local mason_icons = mm.style.icons.lsp.mason

    local function overwrite_icons()
        for type, icon in pairs(mm.style.icons.lsp.signs) do
            type = type:sub(1,1):upper()..type:sub(2)
            local sign = 'DiagnosticSign' .. type
            local hl = 'Diagnostic' .. type

            vim.fn.sign_define(sign, { text = icon, texthl = hl, numhl = hl })
        end
    end

    local function overwrite_diagnostic_config()
        vim.diagnostic.config({
            virtual_text = false,
            float = {
                focusable = false,
                border = mm.style.current.border,
            },
        })
    end

    local function overwrite_handlers()
        local popup_opts = {
            focusable = false,
            border = mm.style.current.border,
        }
        vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, popup_opts)
        vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, popup_opts)

        -- single sign severity filter handler
        local ns = vim.api.nvim_create_namespace('mm_sign_filter')
        local orig_signs_handler = vim.diagnostic.handlers.signs
        -- override the built-in signs handler
        vim.diagnostic.handlers.signs = {
            show = function(_, bufnr, _, opts)
                -- get all diagnostics from the whole buffer rather than just the
                -- diagnostics passed to the handler
                local diagnostics = vim.diagnostic.get(bufnr)

                -- find the 'worst' diagnostic per line
                local max_severity_per_line = { }
                for _, d in pairs(diagnostics) do
                    local m = max_severity_per_line[d.lnum]
                    if not m or d.severity < m.severity then
                        max_severity_per_line[d.lnum] = d
                    end
                end

                -- pass the filtered diagnostics to the original handler
                local filtered_diagnostics = vim.tbl_values(max_severity_per_line)
                orig_signs_handler.show(ns, bufnr, filtered_diagnostics, opts)
            end,
            hide = function(_, bufnr)
                orig_signs_handler.hide(ns, bufnr)
            end,
        }
    end

    local function on_attach(_, bufnr)
        overwrite_icons()
        overwrite_diagnostic_config()
        overwrite_handlers()
        lsp_mappings(bufnr)
    end

    local server_config = {
        on_attach = on_attach,
    }

    if cmp_nvim_lsp_loaded then
        server_config.capabilities = cmp_nvim_lsp.default_capabilities(server_config.capabilities)
    end

    require('mason').setup({
        ui = {
            icons = {
                package_installed = mason_icons.installed,
                package_pending = mason_icons.pending,
                package_uninstalled = mason_icons.uninstalled,
            },
        },
    })
    require('mason-lspconfig').setup()
    require('mason-lspconfig').setup_handlers({
        -- The first entry (without a key) will be the default handler
        -- and will be called for each installed server that doesn't have
        -- a dedicated handler.
        function (server_name) -- default handler (optional)
            require('lspconfig')[server_name].setup(server_config)
        end,
        -- Next, you can provide a dedicated handler for specific servers.
        ['sumneko_lua'] = function()
            local sumneko_config = {
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
            }
            require('lspconfig')['sumneko_lua'].setup(mm.merge(sumneko_config, server_config))
        end,
    })
end
