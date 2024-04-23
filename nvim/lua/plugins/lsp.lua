local style = require('style')
local utils = require('utils')

local lsp_list = { 'lua_ls', 'clangd@17.0.3', 'pyright' }
local lint_list = { 'prettier' }
local dap_list = { 'cppdbg' }

local float_opts = {
    border = style.current.border,
    focusable = false,
    source = 'if_many',
    prefix = '',
    header = '',
}

local function diagnostics_config()
    vim.diagnostic.config({
        update_in_insert = false,
        virtual_text = false,
        severity_sort = true,
        float = float_opts,
    })

    -- setup diagnostic signs
    for type, icon in pairs(style.icons.lsp.signs) do
        type = type:sub(1, 1):upper() .. type:sub(2)
        local sign = 'DiagnosticSign' .. type
        local hl = 'Diagnostic' .. type

        vim.fn.sign_define(sign, { text = icon, texthl = hl, numhl = hl })
    end

    -- setup severity filter
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

local function lsp_config()
    local lspconfig = require('lspconfig')
    local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

    vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, float_opts)

    require('mason-lspconfig').setup({ ensure_installed = lsp_list })
    require('mason-lspconfig').setup_handlers({
        function(server_name)
            lspconfig[server_name].setup({
                capabilities = lsp_capabilities,
            })
        end,
        ['clangd'] = function()
            lspconfig['clangd'].setup({
                capabilities = utils.merge(lsp_capabilities, { offsetEncoding = 'utf-8' }),
                cmd = {
                    'clangd',
                    '--background-index',
                    '--clang-tidy',
                    '--header-insertion=iwyu',
                    '--completion-style=detailed',
                    -- '--function-arg-placeholders=0',
                    '-j=4',
                    '--fallback-style=llvm',
                },
                -- init_options = { compilationDatabasePath = './build-cc' },
            })
        end,
    })
end

local function cmp_config()
    local cmp = require('cmp')
    local luasnip = require('luasnip')

    local function tab(fallback)
        if cmp.visible() then
            cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
        elseif luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump()
        else
            fallback()
        end
    end

    local function shift_tab(fallback)
        if cmp.visible() then
            cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
        elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
        else
            fallback()
        end
    end

    cmp.setup({
        completion = { autocomplete = false },
        snippet = { expand = function(args) require('luasnip').lsp_expand(args.body) end },
        sources = {
            { name = 'path',     max_item_count = 5,  priority_weight = 110 },
            { name = 'nvim_lsp', max_item_count = 20, priority_weight = 100 },
            { name = 'luasnip',  max_item_count = 5,  priority_weight = 90 },
            {
                name = 'rg',
                keyword_length = 5,
                max_item_count = 5,
                priority_weight = 80,
                option = {
                    additional_arguments = '--smart-case --max-depth 8',
                },
            },
            { name = 'buffer', max_item_count = 5, priority_weight = 80 },
        },
        sorting = {
            priority_weight = 1.0,
            comparators = {
                cmp.config.compare.offset,
                cmp.config.compare.exact,
                cmp.config.compare.kind,
                cmp.config.compare.score,
                cmp.config.compare.scopes,        -- maybe rate higher?
                cmp.config.compare.recently_used, -- maybe rate higher?
                require 'cmp-under-comparator'.under,
                cmp.config.compare.sort_text,
                cmp.config.compare.length,
                cmp.config.compare.order,
            },
        },
        mapping = {
            ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
            ['<Tab>'] = cmp.mapping(tab, { 'i', 's' }),
            ['<S-Tab>'] = cmp.mapping(shift_tab, { 'i', 's' }),
            ['<CR>'] = cmp.mapping.confirm({ select = true }),
            ['<C-u>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
            ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
            ['<C-q>'] = cmp.mapping({ i = cmp.mapping.abort(), c = cmp.mapping.close() }),
        },
        window = {
            completion = {
                winhighlight = 'FloatBorder:Pmenu,Search:None',
                col_offset = -3,
                side_padding = 0,
            },
        },
        formatting = {
            fields = { 'kind', 'abbr', 'menu' },
            format = function(entry, vim_item)
                local menu = ({
                    nvim_lsp = '(LSP)',
                    path = '(Path)',
                    luasnip = '(SN)',
                    buffer = '(B)',
                    cmdline = '(Cmd)',
                    rg = '(Rg)',
                })[entry.source.name]
                vim_item.menu = '(' .. vim_item.kind .. ') ' .. menu
                vim_item.kind = string.format(' %s ', style.icons.lsp.kinds[vim_item.kind])

                return vim_item
            end,
        },
    })

    -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
            { name = 'buffer' },
        },
        view = {
            entries = { name = 'wildmenu', separator = '|' },
        },
    })
    -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
            { name = 'cmdline', keyword_pattern = [=[[^[:blank:]\!]*]=] },
            { name = 'path' },

        }),
        view = {
            entries = { name = 'wildmenu', separator = '|' },
        },
    })

    require('luasnip.loaders.from_vscode').lazy_load()
end

local function dap_config()
    local dap = require('dap')
    local dapui = require('dapui')

    if vim.fn.filereadable('.vscode/launch.json') then
        -- map launch.json type to filetypes (e.g. cppdbg = { 'c', 'cpp' })
        require('dap.ext.vscode').load_launchjs(nil, { cppdbg = { 'c', 'cpp' } })
    end

    dap.repl.commands = vim.tbl_extend('force', dap.repl.commands, {
        custom_commands = {
            ['.restart'] = dap.restart,
        },
    })

    vim.fn.sign_define('DapBreakpoint', { text = style.icons.ui.breakpoint })
    vim.fn.sign_define('DapStopped', { text = style.icons.ui.chevron_right })

    dap.listeners.after.stackTrace['auto-center'] = function()
        vim.cmd.normal('zzzv')
    end
    dap.listeners.after.event_initialized['dapui'] = function()
        dapui.open({ reset = true })
    end
    dap.listeners.after.event_terminated['dapui'] = function()
        dapui.close()
        dap.repl.close()
    end
    dap.listeners.after.event_exited['dapui'] = function()
        dapui.close()
        dap.repl.close()
    end
end

return {
    -- server manager
    {
        'williamboman/mason.nvim',
        event = { 'BufReadPre', 'BufNewFile' },
        opts = {
            ui = {
                icons = {
                    package_installed = style.icons.lsp.mason.installed,
                    package_pending = style.icons.lsp.mason.pending,
                    package_uninstalled = style.icons.lsp.mason.uninstalled,
                },
            },
        }
    },
    -- LSP
    {
        'neovim/nvim-lspconfig',
        event = { 'BufReadPre', 'BufNewFile' },
        dependencies = {
            -- LSP Support
            { 'williamboman/mason-lspconfig.nvim' },

            -- Autocompletion
            {
                'hrsh7th/nvim-cmp',
                dependencies = {
                    -- main source
                    'hrsh7th/cmp-nvim-lsp',

                    -- snippets
                    'L3MON4D3/LuaSnip',
                    'rafamadriz/friendly-snippets',
                    'saadparwaiz1/cmp_luasnip',

                    -- optional sources
                    'hrsh7th/cmp-path',
                    'hrsh7th/cmp-buffer',
                    'hrsh7th/cmp-cmdline',
                    'lukas-reineke/cmp-rg',

                    -- comparators
                    'lukas-reineke/cmp-under-comparator',
                },
                config = function()
                    cmp_config()
                end,
            },
        },
        config = function()
            diagnostics_config()
            lsp_config()
        end,
    },
    -- linter
    {
        'nvimtools/none-ls.nvim',
        event = { 'BufReadPre', 'BufNewFile' },
        dependencies = {
            { 'nvim-lua/plenary.nvim' },
            {
                'jayp0521/mason-null-ls.nvim',
                opts = {
                    ensure_installed = lint_list,
                    handlers = {},
                },
            },
        },
        config = true
    },
    -- debugger
    {
        'rcarriga/nvim-dap-ui',
        event = { 'BufReadPre', 'BufNewFile' },
        dependencies = {
            { 'nvim-neotest/nvim-nio' },
            {
                'mfussenegger/nvim-dap',
                dependencies = {
                    'jayp0521/mason-nvim-dap.nvim',
                    opts = {
                        ensure_installed = dap_list,
                        handlers = {},
                    },
                },
                config = dap_config,
            },
        },
        opts = {
            controls = {
                enabled = false,
            },
            windows = {
                indent = 2,
            },
            floating = {
                border = style.current.border,
            },
            layouts = {
                {
                    elements = {
                        { id = 'scopes',      size = 0.25, },
                        { id = 'breakpoints', size = 0.25, },
                        { id = 'stacks',      size = 0.25, },
                        { id = 'watches',     size = 0.25, },
                    },
                    position = 'left',
                    size = 40,
                },
                {
                    elements = {
                        { id = 'console', size = 1, },
                    },
                    position = 'bottom',
                    size = 10,
                },
            },
        },
    },
}
