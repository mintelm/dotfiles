mm.lsp = { }

mm.lsp.servers = {
    'pyright',
    'clangd',
    'sumneko_lua',
    'texlab',
    'rust_analyzer',
}

local function setup_icons()
    local kinds = vim.lsp.protocol.CompletionItemKind

    for type, icon in pairs(mm.style.icons) do
        type = type:sub(1,1):upper()..type:sub(2)
        local sign = 'DiagnosticSign' .. type
        local hl = 'Diagnostic' .. type

        vim.fn.sign_define(sign, { text = icon, texthl = hl, numhl = hl })
    end

    for i, kind in ipairs(kinds) do
        kinds[i] = mm.style.lsp.kinds[kind] or kind
    end
end

local function setup_diagnostics()
    --[[ also used for cursorhold event
    vim.o.updatetime = 250
    vim.cmd('autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float()')
    --]]

    vim.diagnostic.config({
        virtual_text = false,
        float = {
            focusable = false,
            border = 'single',
        },
    })
end

local function overwrite_handlers()
    local popup_opts = {
        focusable = false,
        border = 'single',
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
    setup_icons()
    setup_diagnostics()
    overwrite_handlers()

    require('mm.keymappings').lsp_mappings(bufnr)
end

function mm.lsp.get_server_config(server)
    local cmp_nvim_lsp_loaded, cmp_nvim_lsp = mm.safe_require('cmp_nvim_lsp')
    -- global config
    local config = {
        on_attach = on_attach,
        flags = {
            debounce_text_changes = 500,
        },
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
        cmp_nvim_lsp.update_capabilities(config.capabilities)
    end

    if server == 'sumneko_lua' then
        config = mm.merge(sumneko_config(), config)
    end

    return config
end

return function()
    for _, server in ipairs(mm.lsp.servers) do
        require('lspconfig')[server].setup(mm.lsp.get_server_config(server))
    end
end