local M = {}

M = {
    border = {
        rectangle = { '┌', '─', '┐', '│', '┘', '─', '└', '│' },
        rounded = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
    },
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
            branch = '',
        },
        lsp = {
            server = ' ', -- 
            signs = {
                error = '', -- ✗ 
                warn = '', -- 
                info = '', --  
                hint = '', -- 
            },
            kinds = {
                -- use PascalCase for easy mapping
                Text = '',
                Method = '',
                Function = '',
                Constructor = '',
                Field = '', -- '',
                Variable = '', -- '',
                Class = '', -- '',
                Interface = '',
                Module = '',
                Property = 'ﰠ',
                Unit = '塞',
                Value = '',
                Enum = '',
                Keyword = '', -- '',
                Snippet = '', -- '', '',
                Color = '',
                File = '',
                Reference = '', -- '',
                Folder = '',
                EnumMember = '',
                Constant = '', -- '',
                Struct = '', -- 'פּ',
                Event = '',
                Operator = '',
                TypeParameter = '',
            },
            mason = {
                installed = '✓',
                pending = '➜',
                uninstalled = '✗',
            },
        },
    },
}

M.current = {
    border = M.border.rounded,
}

return M
