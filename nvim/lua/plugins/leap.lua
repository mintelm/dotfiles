return {
    {
        'ggandor/leap.nvim',
        config = function()
            require('leap').setup({ equivalence_classes = { ' \t\r\n', '([{', ')]}', '`"\'' } })
            require('leap').add_default_mappings()
        end,
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
