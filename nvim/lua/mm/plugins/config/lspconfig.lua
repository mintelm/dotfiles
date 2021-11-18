mm.lsp = { }

local servers = {
    'pyright',
    'clangd',
    'sumneko_lua',
    'texlab',
}

local function sumneko_setup(on_attach)
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
                    globals = {'vim'},
                },
                workspace = {
                    library = vim.api.nvim_get_runtime_file('', true),
                },
                telemetry = {
                    enable = false,
                },
            },
        },
        on_attach = on_attach,
    }
end

function mm.lsp.setup_icons()
    local kinds = vim.lsp.protocol.CompletionItemKind

    for type, icon in pairs(mm.style.icons) do
        local hl = 'LspDiagnosticsSign' .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
    end

    for i, kind in ipairs(kinds) do
        kinds[i] = mm.style.lsp.kinds[kind] or kind
    end
end

function mm.lsp.setup_servers(on_attach)
    for _, name in ipairs(servers) do
        if name == 'sumneko_lua' then
            require('lspconfig')[name].setup(sumneko_setup(on_attach))
        else
            require('lspconfig')[name].setup({ on_attach = on_attach })
        end
    end
end

function mm.lsp.on_attach(client, bufnr)
    vim.o.updatetime = 250
    vim.cmd('autocmd CursorHold,CursorHoldI * lua vim.lsp.diagnostic.show_line_diagnostics({focusable=false, border="single"})')
    vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
        vim.lsp.diagnostic.on_publish_diagnostics, {
            virtual_text = false,
        }
    )
    vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
        vim.lsp.handlers.hover, {
            border = 'single',
        }
    )

    vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
        vim.lsp.handlers.signature_help, {
            border = 'single',
        }
    )

    require('mm.keymappings').lsp_mappings(bufnr)
end

function mm.lsp.setup_severity_filter()
    local orig_set_signs = vim.lsp.diagnostic.set_signs
    local set_signs_limited = function(diagnostics, bufnr, client_id, sign_ns, opts)

    -- early escape
    if not diagnostics then
        return
    end

    -- Work out max severity diagnostic per line
    local max_severity_per_line = { }
    for _,d in pairs(diagnostics) do
        if max_severity_per_line[d.range.start.line] then
        local current_d = max_severity_per_line[d.range.start.line]
        if d.severity < current_d.severity then
            max_severity_per_line[d.range.start.line] = d
        end
        else
        max_severity_per_line[d.range.start.line] = d
        end
    end

    -- map to list
    local filtered_diagnostics = { }
    for _,v in pairs(max_severity_per_line) do
        table.insert(filtered_diagnostics, v)
    end

    -- call original function
    orig_set_signs(filtered_diagnostics, bufnr, client_id, sign_ns, opts)
    end
    vim.lsp.diagnostic.set_signs = set_signs_limited
end

return function()
    mm.lsp.setup_servers(mm.lsp.on_attach)
    mm.lsp.setup_severity_filter()
    mm.lsp.setup_icons()
end
