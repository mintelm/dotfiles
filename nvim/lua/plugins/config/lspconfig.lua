lsp = { }

lsp.signs = { Error = ' ', Warning = ' ', Hint = ' ', Information = ' ' }
lsp.icons = {
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

function lsp.setup_icons()
    local kinds = vim.lsp.protocol.CompletionItemKind

    for type, icon in pairs(lsp.signs) do
        local hl = 'LspDiagnosticsSign' .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
    end

    for i, kind in ipairs(kinds) do
        kinds[i] = lsp.icons[kind] or kind
    end
end

return function()
    require('lspconfig').pyright.setup{ }
    require('lspconfig').clangd.setup{ }

    local sumneko_root_path = '/usr/share/lua-language-server'
    local sumneko_binary = '/usr/bin/lua-language-server'
    local runtime_path = vim.split(package.path, ';')
    table.insert(runtime_path, 'lua/?.lua')
    table.insert(runtime_path, 'lua/?/init.lua')

    require('lspconfig').sumneko_lua.setup {
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

    lsp.setup_icons()
end
