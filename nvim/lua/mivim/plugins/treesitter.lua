local languages = { 'c', 'cpp' }

vim.api.nvim_create_autocmd('FileType', {
    pattern = languages,
    callback = function() vim.treesitter.start() end,
})

return {
    'nvim-treesitter/nvim-treesitter',
    lazy = false, -- plugin does not support lazy-loading.
    build = ':TSUpdate',
    init = function()
        require('nvim-treesitter').install(languages)
    end,
}
