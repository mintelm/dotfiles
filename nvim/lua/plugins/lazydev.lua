return {
    'folke/lazydev.nvim',
    event = 'VeryLazy',
    ft = 'lua',
    dependencies = { 'Bilal2453/luvit-meta', lazy = true },
    opts = {
        library = {
            { path = 'luvit-meta/library', words = { 'vim%.uv' } },
        },
    },
    specs = {
        {
            'saghen/blink.cmp',
            optional = true,
            opts = function(_, opts)
                opts.sources = {
                    default = { 'lazydev', 'lsp', 'path', 'snippets', 'buffer' },
                    providers = {
                        lazydev = {
                            name = 'LazyDev',
                            module = 'lazydev.integrations.blink',
                            score_offset = 100,
                        },
                    },
                }
            end
        },
    },
}
