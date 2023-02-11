local utils = require('utils')
local style = require('style')

local function config()
    local cmp = require('cmp')

    local function tab(fallback)
        local ok, luasnip = utils.safe_require('luasnip', { silent = true })

        if cmp.visible() then
            cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
        elseif ok and luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump()
        else
            fallback()
        end
    end

    local function shift_tab(fallback)
        local ok, luasnip = utils.safe_require('luasnip', { silent = true })

        if cmp.visible() then
            cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
        elseif ok and luasnip.jumpable(-1) then
            luasnip.jump(-1)
        else
            fallback()
        end
    end

    cmp.setup({
        completion = {
            autocomplete = false,
        },
        enabled = function()
            return vim.api.nvim_buf_get_option(0, 'buftype') ~= 'prompt' or require('cmp_dap').is_dap_buffer()
        end,
        snippet = {
            expand = function(args)
                require('luasnip').lsp_expand(args.body)
            end,
        },
        sources = {
            { name = 'path', priority_weight = 110 },
            { name = 'nvim_lsp', max_item_count = 20, priority_weight = 100 },
            { name = 'nvim_lua', priority_weight = 90 },
            { name = 'luasnip', priority_weight = 80 },
            { name = 'buffer', max_item_count = 5, priority_weight = 70 },
            {
                name = 'rg',
                keyword_length = 5,
                max_item_count = 5,
                priority_weight = 60,
                option = {
                    additional_arguments = '--smart-case --hidden',
                },
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
        sorting = {
            priority_weight = 100,
            comparators = {
                cmp.config.compare.offset,
                cmp.config.compare.exact,
                cmp.config.compare.score,
                require('cmp-under-comparator').under,
                cmp.config.compare.kind,
                cmp.config.compare.sort_text,
                cmp.config.compare.length,
                cmp.config.compare.order,
            },
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
                    nvim_lua = '(lua)',
                    path = '(Path)',
                    luasnip = '(SN)',
                    buffer = '(B)',
                    cmdline = '(Cmd)',
                    rg = '(Rg)',
                    dap = '(DAP)',
                })[entry.source.name]
                vim_item.menu = '(' .. vim_item.kind .. ') ' .. menu
                vim_item.kind = string.format(' %s ', style.icons.lsp.kinds[vim_item.kind])

                return vim_item
            end,
        },
    })

    -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline('/', {
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
        sources = cmp.config.sources(
            {
                { name = 'path' },
            },
            -- fallback
            { { name = 'cmdline' } }
        ),
        view = {
            entries = { name = 'wildmenu', separator = '|' },
        },
    })
    cmp.setup.filetype({ 'dap-repl', 'dapui_watches', 'dapui_hover' }, {
        sources = {
            { name = 'dap' },
        },
        formatting = {
            fields = { 'kind', 'abbr', },
            format = function(_, vim_item)
                vim_item.kind = string.format(' %s ', style.icons.lsp.kinds[vim_item.kind])

                return vim_item
            end,
        },
    })
end

return {
    'hrsh7th/nvim-cmp',
    config = config,
    dependencies = {
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-nvim-lua',
        'saadparwaiz1/cmp_luasnip',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-cmdline',
        'lukas-reineke/cmp-rg',
        'rcarriga/cmp-dap',
        'lukas-reineke/cmp-under-comparator',
        {
            'L3MON4D3/LuaSnip',
            event = 'InsertEnter',
            config = function()
                require('luasnip/loaders/from_vscode').lazy_load()
            end,
            dependencies = 'rafamadriz/friendly-snippets',
        },
        {
            'folke/neodev.nvim',
            config = function()
                require('neodev').setup()
            end,
        },
    },
}
