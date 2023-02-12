local function config()
    require('nvim-treesitter.configs').setup({
        auto_install = true,
        highlight = {
            enable = true,
        },
        indent = {
            enable = true,
        },
        rainbow = {
            enable = true,
            extended_mode = true,
            max_file_lines = 10000,
        },
    })
end

return {
    'nvim-treesitter/nvim-treesitter',
    config = config,
    dependencies = 'mrjones2014/nvim-ts-rainbow'
}
