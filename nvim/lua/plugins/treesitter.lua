return {
    'nvim-treesitter/nvim-treesitter',
    config = function()
        require('nvim-treesitter.configs').setup({
            auto_install = true,
            ensure_installed = {
                'gitcommit',
                'diff',
                'git_rebase',
            },
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false
            },
        })
    end,
}
