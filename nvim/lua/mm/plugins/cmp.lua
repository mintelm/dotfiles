return function()
    local cmp = require('cmp')

    local function get_luasnip()
        local ok, luasnip = mm.safe_require('luasnip', { silent = true })

        if not ok then
            return nil
        end
            return luasnip
    end

    --[[ TODO: maybe not wanted??
    local function has_words_before()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
    end
    --]]

    local function tab(fallback)
        local luasnip = get_luasnip()

        if cmp.visible() then
            cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
        elseif luasnip and luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump()
        --[[
        elseif has_words_before() then
            cmp.complete()
        --]]
        else
            fallback()
        end
    end

    local function shift_tab(fallback)
        local luasnip = get_luasnip()

        if cmp.visible() then
            cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
        elseif luasnip and luasnip.jumpable(-1) then
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
            end
        },
        sources = cmp.config.sources({
            { name = 'nvim_lsp' },
            { name = 'luasnip' },
        }),
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
            documentation = cmp.config.window.bordered(),
        },
        formatting = {
            deprecated = true,
            format = function(entry, vim_item)
                vim_item.kind = mm.style.lsp.kinds[vim_item.kind]
                --[[
                local name = entry.source.name
                -- FIXME: automate this using a regex to normalise names
                local menu = ({
                    nvim_lsp = '[LSP]',
                    nvim_lua = '[Lua]',
                    emoji = '[Emoji]',
                    path = '[Path]',
                    calc = '[Calc]',
                    neorg = '[Neorg]',
                    orgmode = '[Org]',
                    cmp_tabnine = '[TN]',
                    luasnip = '[Luasnip]',
                    buffer = '[Buffer]',
                    fuzzy_buffer = '[Fuzzy Buffer]',
                    fuzzy_path = '[Fuzzy Path]',
                    spell = '[Spell]',
                    cmdline = '[Command]',
                    cmp_git = '[Git]',
                })[name]

                vim_item.menu = menu
                ==]]
                return vim_item
            end,
        },
    })
end
