return {
    'nvim-tree/nvim-tree.lua',
    event = 'VeryLazy',
    dependencies = 'kyazdani42/nvim-web-devicons',
    init = function()
        -- disable netrw at the very start of your init.lua (strongly advised)
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1
    end,
    config = true,
}
