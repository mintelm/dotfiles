local function config()
    require('nvim-treesitter.configs').setup({
        auto_install = true,
        highlight = {
            enable = true,
        },
        indent = {
            enable = true,
        },
    })
end

return {
    'nvim-treesitter/nvim-treesitter',
    config = config,
}
