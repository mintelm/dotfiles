return function()
    require('lsp_signature').setup({
        bind = true,
        handler_opts = {
            border = require('style').current.border,
        },
        hint_enable = false,
    })
end
