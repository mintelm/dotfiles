M = { }

M.servers = {
    'pyright',
    'clangd',
    'sumneko_lua',
}

M.signs = { Error = ' ', Warning = ' ', Hint = ' ', Information = ' ' }

M.icons = {
  Class = ' Class',
  Color = ' Color',
  Constant = ' Constant',
  Constructor = ' Constructor',
  Enum = '了 Enum',
  EnumMember = ' Enum',
  Event = '鬒 Event',
  Field = '識 Field',
  File = ' File',
  Folder = ' Folder',
  Function = 'ƒ Function',
  Interface = 'ﰮ Interface',
  Keyword = ' Keyword',
  Method = ' Method',
  Module = ' Module',
  Property = ' Property',
  Reference = '渚 Reference',
  Snippet = ' Snippet',
  Struct = ' Struct',
  Text = ' Text',
  Type = ' Type Parameter',
  Unit = ' Unit',
  Value = ' Value',
  Variable = ' Variable',
}

function M.sumneko_setup()
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

function M.setup_icons()
    local kinds = vim.lsp.protocol.CompletionItemKind

    for type, icon in pairs(M.signs) do
        local hl = 'LspDiagnosticsSign' .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
    end

    for i, kind in ipairs(kinds) do
        kinds[i] = M.icons[kind] or kind
    end
end

function M.setup_servers()
    for _, name in ipairs(M.servers) do
        if name == 'sumneko_lua' then
            require('lspconfig')[name].setup(M.sumneko_setup())
        else
            require('lspconfig')[name].setup({ })
        end
    end
end

function M.setup_severity_filter()
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
    M.setup_severity_filter()
    M.setup_servers()
    M.setup_icons()
end