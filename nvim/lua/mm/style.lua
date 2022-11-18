mm.style = {
    border = {
        rectangle = { '┌', '─', '┐', '│', '┘', '─', '└', '│' },
        rounded   = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
    },
    icons = {
        modified = '',
        readonly = '',
        lines = '',
        columns = '',
        telescope = '',
        git = {
            add = '',
            delete = '',
            change = '',
            branch = '',
        },
        lsp = {
            server = ' ', -- 
            signs = {
                error = '',  -- ✗ 
                warn = '',   -- 
                info = '',   --  
                hint = '',   -- 
            },
            kinds = {
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
        },
    },
}

mm.style.current = {
    border = mm.style.border.rounded,
}
