local utils = require('utils')
local style = require('style')

local function lsp_config()
    local cmp_nvim_lsp_loaded, cmp_nvim_lsp = utils.safe_require('cmp_nvim_lsp')
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

    -- setup lsp signs
    for type, icon in pairs(style.icons.lsp.signs) do
        type = type:sub(1, 1):upper() .. type:sub(2)
        local sign = 'DiagnosticSign' .. type
        local hl = 'Diagnostic' .. type

        vim.fn.sign_define(sign, { text = icon, texthl = hl, numhl = hl })
    end

    -- override handlers
    -- FIXME: somehow this old snippets works fine for multiple clients, while
    --        the newer snippet from `:h vim.diagnostic` does not....
    vim.diagnostic.config({ signs = false })
    local ns = vim.api.nvim_create_namespace('diagnostics-severity')
    local orig_show = vim.diagnostic.show
    local function set_signs(bufnr)
        -- Get all diagnostics from the current buffer
        local diagnostics = vim.diagnostic.get(bufnr)
        -- Find the 'worst' diagnostic per line
        local max_severity_per_line = {}
        for _, d in pairs(diagnostics) do
            local m = max_severity_per_line[d.lnum]
            if not m or d.severity < m.severity then
                max_severity_per_line[d.lnum] = d
            end
        end
        -- Show the filtered diagnostics using the custom namespace. Use the
        -- reference to the original function to avoid a loop.
        local filtered_diagnostics = vim.tbl_values(max_severity_per_line)
        orig_show(ns, bufnr, filtered_diagnostics, { signs = true })
    end

    function vim.diagnostic.show(namespace, bufnr, ...)
        orig_show(namespace, bufnr, ...)
        set_signs(bufnr)
    end

    vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, float_opts)
    vim.lsp.handlers['textDocument/signatureHelp'] =
        vim.lsp.with(vim.lsp.handlers.signature_help, float_opts)

    local server_config = {}

    if cmp_nvim_lsp_loaded then
        server_config.capabilities = cmp_nvim_lsp.default_capabilities()
    else
        server_config.capabilities = vim.lsp.protocol.make_client_capabilities()
    end

    require('mason-lspconfig').setup()
    require('mason-lspconfig').setup_handlers({
        -- default handler
        function(server_name)
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

local function lsp_signature_config()
    require('lsp_signature').setup({
        bind = true,
        handler_opts = {
            border = style.current.border,
        },
        hint_enable = false,
    })
end

local function mason_config()
    local mason_icons = style.icons.lsp.mason
    require('mason').setup({
        ui = {
            icons = {
                package_installed = mason_icons.installed,
                package_pending = mason_icons.pending,
                package_uninstalled = mason_icons.uninstalled,
            },
        },
    })
end

return {
    {
        'neovim/nvim-lspconfig',
        config = lsp_config,
        dependencies = {
            {
                'ray-x/lsp_signature.nvim',
                config = lsp_signature_config,
            },
            {
                'williamboman/mason.nvim',
                config = mason_config,
            },
            {
                'williamboman/mason-lspconfig.nvim',
            },
            {
                'jose-elias-alvarez/null-ls.nvim',
                config = function()
                    require('null-ls').setup({})
                    require('mason-null-ls').setup({
                        automatic_setup = true,
                    })
                    require('mason-null-ls').setup_handlers({})
                end,
                dependencies = { 'jayp0521/mason-null-ls.nvim' },
            },
            {
                'mfussenegger/nvim-dap',
                config = function()
                    require('mason-nvim-dap').setup({
                        automatic_setup = true,
                    })
                    require('mason-nvim-dap').setup_handlers({})
                end,
                dependencies = { 'jayp0521/mason-nvim-dap.nvim' },
            },
        },
    },
}
