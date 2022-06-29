return function ()
    require('nvim-treesitter.configs').setup({
        ensure_installed = {
            'c', 'lua', 'latex', 'bibtex', 'python', 'rust',
        },
        highlight = {
            enable = true,
        },
        indent = {
            enable = true
        }
    })
end
