return {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
        library = {
            { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
        },
    },
    specs = {
        {
            'saghen/blink.cmp',
            optional = true,
            opts = function(_, opts)
                opts.sources = opts.sources or {}
                opts.sources.providers = opts.sources.providers or {}
                opts.sources.providers.lazydev = {
                    name = 'LazyDev',
                    module = 'lazydev.integrations.blink',
                    score_offset = 100,
                }

                table.insert(opts.sources.default, 1, 'lazydev')
            end
        },
    },
}
