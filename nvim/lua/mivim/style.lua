local M = {}

M = {
    icons = {
        ui = {
            vim = '', -- 
            modified = '',
            readonly = '',
            lines = '',
            columns = '',
            telescope = '',
            breakpoint = '',
            chevron_right = '',
            virtual_prefix = '', -- ''
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
            mason = {
                installed = '✓',
                pending = '➜',
                uninstalled = '✗',
            },
        },
    },
}

return M
