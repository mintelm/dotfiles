local palette = {
    dark_grey = '#1d2021',
    red = '#fb4632',
    aqua = '#8ec07c',
    blue = '#83a598',
    yellow = '#fabd2e',
}

mm.style = {
    border = {
        rectangle = { '┌', '─', '┐', '│', '┘', '─', '└', '│' },
        rounded   = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
    },
    icons = {
        error = '',  -- ✗ 
        warn = '',   -- 
        info = '',   --  
        hint = '',   -- 
    },
    lsp = {
        colors = {
            error = palette.red,
            warn = palette.yellow,
            info = palette.blue,
            hint = palette.aqua,
        },
        kind_highlights = {
            Text = 'String',
            Method = 'TSMethod',
            Function = 'Function',
            Constructor = 'TSConstructor',
            Field = 'TSField',
            Variable = 'TSVariable',
            Class = 'purescriptStructure',
            Interface = 'Constant',
            Module = 'Include',
            Property = 'TSProperty',
            Unit = 'Constant',
            Value = 'TSVariable',
            Enum = 'Type',
            Keyword = 'Keyword',
            File = 'Directory',
            Reference = 'PreProc',
            Constant = 'Constant',
            Struct = 'Type',
            Snippet = 'Label',
            Event = 'TSVariable',
            Operator = 'Operator',
            TypeParameter = 'Type',
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
    palette = palette,
}

mm.style.current = {
    border = mm.style.border.rectangle,
}
