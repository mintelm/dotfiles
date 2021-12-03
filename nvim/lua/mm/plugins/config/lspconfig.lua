mm.lsp = { }

mm.lsp.servers = {
    'pyright',
    'clangd',
    'sumneko_lua',
    'texlab',
}

local function setup_icons()
    local kinds = vim.lsp.protocol.CompletionItemKind

    for type, icon in pairs(mm.style.icons) do
        local hl = 'DiagnosticSign' .. type:sub(1,1):upper()..type:sub(2)
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
    end

    for i, kind in ipairs(kinds) do
        kinds[i] = mm.style.lsp.kinds[kind] or kind
    end
end

local function setup_augroups()
    local hl = require('mm.highlights')
    local bg = hl.get_hl('Normal', 'bg', mm.style.palette.dark_grey)
    local lsp_colors = mm.style.lsp.colors

    mm.augroup('LspHighlights', {
        {
            events = { 'VimEnter' },
            targets = { '*' },
            command = function() hl.set_hls({
                { 'DiagnosticSignError', { guibg = bg, guifg = lsp_colors.error } },
                { 'DiagnosticSignWarn', { guibg = bg, guifg = lsp_colors.warn } },
                { 'DiagnosticSignInfo', { guibg = bg, guifg = lsp_colors.info } },
                { 'DiagnosticSignHint', { guibg = bg, guifg = lsp_colors.hint } },
                { 'LspReferenceText', { gui = 'underline' } },
                { 'LspReferenceRead', { gui = 'underline' } },
            })
            end,
        }
    })
end

local function setup_severity_filter()
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

local function on_attach(_, bufnr)
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

    setup_icons()
    setup_augroups()
    setup_severity_filter()

    require('mm.keymappings').lsp_mappings(bufnr)
end

function mm.lsp.get_server_config(server)
    local cmp_nvim_lsp_loaded, cmp_nvim_lsp = mm.safe_require('cmp_nvim_lsp')
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
