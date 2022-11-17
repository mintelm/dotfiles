mm.style = {
    border = {
        rectangle = { '┌', '─', '┐', '│', '┘', '─', '└', '│' },
        rounded   = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
    },
    icons = {
        modified = '',
        readonly = '',
        lsp = {
            error = '',  -- ✗ 
            warn = '',   -- 
            info = '',   --  
            hint = '',   -- 
        },
    },
    lsp = {
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
}

mm.style.current = {
    border = mm.style.border.rectangle,
}
