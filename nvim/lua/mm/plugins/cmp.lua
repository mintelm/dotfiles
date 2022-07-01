return function()
    local cmp = require('cmp')
    local h = require('mm.highlights')

    local lsp_hls = mm.style.lsp.kind_highlights

    -- Make the source information less prominent
    local kind_hls = {
        CmpItemAbbr = { foreground = 'fg', background = 'NONE', italic = false, bold = false },
        CmpItemMenu = { foreground = { from = 'FloatBorder' }, italic = true, bold = false },
        CmpItemAbbrMatch = { foreground = { from = 'String' } },
        CmpItemAbbrDeprecated = { strikethrough = true, inherit = 'Comment' },
        CmpItemAbbrMatchFuzzy = { italic = true, foreground = { from = 'String' } },
    }

    for key, _ in pairs(lsp_hls) do
        kind_hls['CmpItemKind' .. key] = { foreground = { from = lsp_hls[key] } }
    end

    h.plugin('Cmp', kind_hls)

    local function tab(fallback)
        local ok, luasnip = mm.safe_require('luasnip', { silent = true })

        if cmp.visible() then
            cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
        elseif ok and luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump()
        else
            fallback()
        end
    end

    local function shift_tab(fallback)
        local ok, luasnip = mm.safe_require('luasnip', { silent = true })

        if cmp.visible() then
            cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
        elseif ok and luasnip.jumpable(-1) then
            luasnip.jump(-1)
        else
            fallback()
        end
    end

    local cmp_window = {
        border = mm.style.current.border,
        winhighlight = table.concat({
            'Normal:NormalFloat',
            'FloatBorder:FloatBorder',
            'CursorLine:Visual',
            'Search:None',
        }, ','),
    }

    cmp.setup({
        completion = {
            autocomplete = false,
        },
        snippet = {
            expand = function(args)
                require('luasnip').lsp_expand(args.body)
            end
        },
        sources = cmp.config.sources({
            { name = 'nvim_lsp' },
            { name = 'luasnip' },
            { name = 'path' },
        },
            -- fallback
            { { name = 'buffer' }, }
        ),
        mapping = {
            ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
            ['<Tab>'] = cmp.mapping(tab, { 'i', 's'}),
            ['<S-Tab>'] = cmp.mapping(shift_tab, { 'i', 's'}),
            ['<CR>'] = cmp.mapping.confirm({ select = true }),
            ['<C-u>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
            ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
            ['<C-q>'] = cmp.mapping({ i = cmp.mapping.abort(), c = cmp.mapping.close(), }),
        },
        window = {
            completion = cmp.config.window.bordered(cmp_window),
            documentation = cmp.config.window.bordered(cmp_window),
        },
        formatting = {
            deprecated = true,
            format = function(entry, vim_item)
                vim_item.kind = string.format('%s %s', mm.style.lsp.kinds[vim_item.kind], vim_item.kind)
                vim_item.menu = ({
                    nvim_lsp = '[LSP]',
                    nvim_lua = '[Lua]',
                    emoji = '[E]',
                    path = '[Path]',
                    neorg = '[N]',
                    luasnip = '[SN]',
                    dictionary = '[D]',
                    buffer = '[B]',
                    spell = '[SP]',
                    cmdline = '[Cmd]',
                    cmdline_history = '[Hist]',
                    rg = '[Rg]',
                    git = '[Git]',
                })[entry.source.name]

                return vim_item
            end,
        },
    })
    -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline('/', {
        mapping = cmp.mapping.preset.cmdline({ }),
        sources = {
            { name = 'buffer' }
        }
    })
    -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
            { name = 'path' }
        },
            -- fallback
            { { name = 'cmdline' } }
        )
    })
end
