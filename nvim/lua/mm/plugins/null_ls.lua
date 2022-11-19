return function()
    require('mason-null-ls').setup({
        automatic_setup = true,
    })
    require('mason-null-ls').setup_handlers({})
    require('null-ls').setup()
end
