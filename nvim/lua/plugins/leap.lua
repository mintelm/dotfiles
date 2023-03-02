return {
    {
        'ggandor/leap.nvim',
        config = function()
            require('leap').add_default_mappings()
        end,
        dependencies = 'tpope/vim-repeat',
    },
    {
        'ggandor/flit.nvim',
        dependencies = 'ggandor/leap.nvim',
        -- this calls require('plugin').setup(opts)
        opts = {
            labeled_modes = 'nvo',
            multiline = false,
        },
    },
}
