return function()
    require('mason-nvim-dap').setup({
        automatic_setup = true,
    })
    require('mason-nvim-dap').setup_handlers({})
end