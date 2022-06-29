local palette = {
    dark_grey = '#1d2021',
    red = '#fb4632',
    aqua = '#8ec07c',
    blue = '#83a598',
    yellow = '#fabd2e',
}

mm.style = {
    border = {
        line = { '🭽', '▔', '🭾', '▕', '🭿', '▁', '🭼', '▏' },
        rectangle = { '┌', '─', '┐', '│', '┘', '─', '└', '│' },
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
        kinds = {
            Class = 'ﴯ',
            Color = '',
            Constant = '',
            Constructor = '',
            Enum = '',
            EnumMember = '',
            Event = '',
            Field = 'ﰠ',
            File = '',
            Folder = '',
            Function = '',
            Interface = '',
            Keyword = '',
            Method = '',
            Module = '',
            Operator = '',
            Property = 'ﰠ',
            Reference = '',
            Snippet = '',
            Struct = 'פּ',
            Type = '',
            TypeParameter = '',
            Text = '',
            Unit = '塞',
            Value = '',
            Variable = '',
            --[[
            Class = ' Class',
            Color = ' Color',
            Constant = ' Constant',
            Constructor = ' Constructor',
            Enum = '了 Enum',
            EnumMember = ' Enum',
            Event = '鬒 Event',
            Field = '識 Field',
            File = ' File',
            Folder = ' Folder',
            Function = 'ƒ Function',
            Interface = 'ﰮ Interface',
            Keyword = ' Keyword',
            Method = ' Method',
            Module = ' Module',
            Operator = ' Operator',
            Property = ' Property',
            Reference = '渚 Reference',
            Snippet = ' Snippet',
            Struct = ' Struct',
            Text = ' Text',
            Type = ' Type',
            TypeParameter = ' TypeParameter',
            Unit = ' Unit',
            Value = ' Value',
            Variable = ' Variable',
            --]]
        }
    },
    palette = palette,
}

mm.style.current = {
  border = mm.style.border.rectangle,
}
