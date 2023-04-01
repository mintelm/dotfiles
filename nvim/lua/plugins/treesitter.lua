return {
    'nvim-treesitter/nvim-treesitter',
    config = function()
        require('nvim-treesitter.configs').setup({
            auto_install = true,
            ignore_install = {
                'gitcommit',
            },
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false
            },
        })
    end,
}
