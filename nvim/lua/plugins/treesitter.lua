return {
    'nvim-treesitter/nvim-treesitter',
    event = 'VeryLazy',
    opts = {
        auto_install = true,
        ensure_installed = {
            'gitcommit',
            'diff',
            'git_rebase',
        },
        highlight = {
            enable = true,
            additional_vim_regex_highlighting = false,
        },
    },
}
