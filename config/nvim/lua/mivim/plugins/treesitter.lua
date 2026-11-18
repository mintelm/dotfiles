local languages = { 'c', 'cpp', 'gitcommit' }

vim.api.nvim_create_autocmd('FileType', {
    pattern = languages,
    callback = function()
        -- the parser may not be installed yet (e.g. on the first start on a new machine)
        pcall(vim.treesitter.start)
    end,
})

return {
    'nvim-treesitter/nvim-treesitter',
    lazy = false, -- plugin does not support lazy-loading.
    build = ':TSUpdate',
    init = function()
        require('nvim-treesitter').install(languages)
    end,
}
