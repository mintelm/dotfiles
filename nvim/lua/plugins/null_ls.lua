return function()
    require('null-ls').setup({ })
    require('mason-null-ls').setup({
        automatic_setup = true,
    })
    require('mason-null-ls').setup_handlers({})
end
