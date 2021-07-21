return function ()
    require'nvim-treesitter.configs'.setup {
        highlight = {
            enable = true,
            disable = { 'c' },
        },
    }
end
