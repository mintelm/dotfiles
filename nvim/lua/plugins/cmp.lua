return function()
    local cmp = require('cmp')
    local utils = require('utils')
    local style = require('style')

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
        formatting = {
            deprecated = true,
            format = function(entry, vim_item)
                vim_item.kind =
                    string.format('%s %s', style.icons.lsp.kinds[vim_item.kind], vim_item.kind)
                vim_item.menu = ({
                    nvim_lsp = '[LSP]',
                    nvim_lua = '[Lua]',
                    path = '[Path]',
                    luasnip = '[SN]',
                    buffer = '[B]',
                    cmdline = '[Cmd]',
                    cmdline_history = '[Hist]',
                    rg = '[Rg]',
                })[entry.source.name]

                return vim_item
            end,
        },
    })
    -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline('/', {
        mapping = cmp.mapping.preset.cmdline({}),
        sources = {
            { name = 'buffer' },
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
    })
end