return function()
    vim.g.indent_blankline_char = '┊' --┆ │ 
    vim.g.indent_blankline_show_first_indent_level = false
    vim.g.indent_blankline_show_trailing_blankline_indent = false
    vim.g.indent_blankline_show_current_context = false
    vim.g.indent_blankline_context_highlight_list = { 'Delimiter' }
    vim.g.indent_blankline_filetype_exclude = {
        'startify',
        'dashboard',
        'log',
        'fugitive',
        'gitcommit',
        'packer',
        'vimwiki',
        'markdown',
        'json',
        'txt',
        'vista',
        'help',
        'NvimTree',
        'git',
        'TelescopePrompt',
        'undotree',
        'flutterToolsOutline',
        'org',
        'orgagenda',
        '', -- for all buffers without a file type
    }
    vim.g.indent_blankline_buftype_exclude = { 'terminal', 'nofile' }
    vim.g.indent_blankline_context_patterns = {
        'class',
        'function',
        'method',
        'block',
        'list_literal',
        'selector',
        '^if',
        '^table',
        'if_statement',
        'while',
        'for',
    }
end