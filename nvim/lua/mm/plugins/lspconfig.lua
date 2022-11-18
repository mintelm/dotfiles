return function()
    local servers = {
        'pyright',
        'clangd',
        'sumneko_lua',
        'texlab',
        'rust_analyzer',
    }

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

        require('mm.keymappings').lsp_mappings(bufnr)
    end

    local function get_server_config(server)
        local cmp_nvim_lsp_loaded, cmp_nvim_lsp = mm.safe_require('cmp_nvim_lsp')
        -- global config
        local config = {
            on_attach = on_attach,
            capabilities = vim.lsp.protocol.make_client_capabilities(),
        }
        -- special config for sumneko lua
        local sumneko_config = function()
            local sumneko_root_path = '/usr/share/lua-language-server'
            local sumneko_binary = '/usr/bin/lua-language-server'
            local runtime_path = vim.split(package.path, ';')

            table.insert(runtime_path, 'lua/?.lua')
            table.insert(runtime_path, 'lua/?/init.lua')

            return {
                cmd = { sumneko_binary, '-E', sumneko_root_path .. '/main.lua' };
                settings = {
                    Lua = {
                        runtime = {
                            version = 'LuaJIT',
                            path = runtime_path,
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
        end

        if cmp_nvim_lsp_loaded then
            cmp_nvim_lsp.default_capabilities(config.capabilities)
        end

        if server == 'sumneko_lua' then
            config = mm.merge(sumneko_config(), config)
        end

        return config
    end

    for _, server in ipairs(servers) do
        require('lspconfig')[server].setup(get_server_config(server))
    end
end
