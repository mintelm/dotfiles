return {
    'saghen/blink.cmp',
    event = 'InsertEnter',
    version = '*', -- download prebuilt fuzzy binaries
    opts = {
        completion = {
            menu = {
                auto_show = false,
                draw = {
                    columns = {
                        { 'label',     'label_description', gap = 1 },
                        { 'kind_icon', 'kind',              gap = 1 }
                    },
                }
            },
            list = { selection = { preselect = false, auto_insert = false } },
            ghost_text = {
                enabled = false,
            },
        },
        keymap = {
            preset = 'none',
            ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
            ['<C-e>'] = { 'hide', 'fallback' },
            ['<CR>'] = { 'select_and_accept', 'fallback' },

            ['<Tab>'] = { 'select_next', 'snippet_forward', 'fallback' },
            ['<S-Tab>'] = { 'select_prev', 'snippet_backward', 'fallback' },

            ['<C-d>'] = { 'scroll_documentation_down', 'fallback' },
            ['<C-u>'] = { 'scroll_documentation_up', 'fallback' },

            ['<C-k>'] = { 'show_signature', 'hide_signature', 'fallback' },
        },
        signature = {
            enabled = true,
            trigger = {
                enabled = false,
                show_on_trigger_character = false,
                show_on_insert_on_trigger_character = false,
            },
            window = {
                show_documentation = false,
            },
        },
    },
}
