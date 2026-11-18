local M = {}

M = {
    icons = {
        ui = {
            vim = '', -- 
            modified = '',
            readonly = '',
            breakpoint = '',
            chevron_right = '',
        },
        git = {
            add = '',
            delete = '',
            change = '',
            branch = '', -- ''
        },
        lsp = {
            server = ' ', -- 
            signs = {
                error = '', -- ✗ 
                warn = '', -- 
                info = '', --  
                hint = '', -- 
            },
        },
    },
}

return M
