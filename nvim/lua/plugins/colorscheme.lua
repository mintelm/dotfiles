local function config()
    local theme_style = 'dark_default'
    local colors = require('github-theme.palette').get_palette(theme_style)

    require('github-theme').setup({
        theme_style = theme_style,
        dark_float = true,
        dark_sidebar = true,
        function_style = 'bold',
        comment_style = 'NONE',
        keyword_style = 'NONE',
        variable_style = 'NONE',
        colors = {
            git_signs = {
                add = colors.git.add,
                change = colors.git.change,
                delete = colors.git.delete,
            },
        },
    })

    vim.api.nvim_set_hl(0, 'BufferLineTabSelected', { link = 'BufferLineBufferSelected' })

    -- vscode like style
    vim.api.nvim_set_hl(0, 'PmenuSel', { bg = '#161b22', fg = 'NONE' })
    vim.api.nvim_set_hl(0, 'Pmenu', { fg = '#C5CDD9', bg = '#22252A' })

    vim.api.nvim_set_hl(0, 'CmpItemAbbrDeprecated', { fg = '#7E8294', bg = 'NONE', strikethrough = true })
    vim.api.nvim_set_hl(0, 'CmpItemAbbrMatch', { fg = '#82AAFF', bg = 'NONE', bold = true })
    vim.api.nvim_set_hl(0, 'CmpItemAbbrMatchFuzzy', { fg = '#82AAFF', bg = 'NONE', bold = true })
    vim.api.nvim_set_hl(0, 'CmpItemMenu', { fg = '#C792EA', bg = 'NONE', italic = true })

    vim.api.nvim_set_hl(0, 'CmpItemKindField', { fg = '#EED8DA', bg = '#B5585F' })
    vim.api.nvim_set_hl(0, 'CmpItemKindProperty', { fg = '#EED8DA', bg = '#B5585F' })
    vim.api.nvim_set_hl(0, 'CmpItemKindEvent', { fg = '#EED8DA', bg = '#B5585F' })

    vim.api.nvim_set_hl(0, 'CmpItemKindText', { fg = '#C3E88D', bg = '#9FBD73' })
    vim.api.nvim_set_hl(0, 'CmpItemKindEnum', { fg = '#C3E88D', bg = '#9FBD73' })
    vim.api.nvim_set_hl(0, 'CmpItemKindKeyword', { fg = '#C3E88D', bg = '#9FBD73' })

    vim.api.nvim_set_hl(0, 'CmpItemKindConstant', { fg = '#FFE082', bg = '#D4BB6C' })
    vim.api.nvim_set_hl(0, 'CmpItemKindConstructor', { fg = '#FFE082', bg = '#D4BB6C' })
    vim.api.nvim_set_hl(0, 'CmpItemKindReference', { fg = '#FFE082', bg = '#D4BB6C' })

    vim.api.nvim_set_hl(0, 'CmpItemKindFunction', { fg = '#EADFF0', bg = '#A377BF' })
    vim.api.nvim_set_hl(0, 'CmpItemKindStruct', { fg = '#EADFF0', bg = '#A377BF' })
    vim.api.nvim_set_hl(0, 'CmpItemKindClass', { fg = '#EADFF0', bg = '#A377BF' })
    vim.api.nvim_set_hl(0, 'CmpItemKindModule', { fg = '#EADFF0', bg = '#A377BF' })
    vim.api.nvim_set_hl(0, 'CmpItemKindOperator', { fg = '#EADFF0', bg = '#A377BF' })

    vim.api.nvim_set_hl(0, 'CmpItemKindVariable', { fg = '#C5CDD9', bg = '#7E8294' })
    vim.api.nvim_set_hl(0, 'CmpItemKindFile', { fg = '#C5CDD9', bg = '#7E8294' })

    vim.api.nvim_set_hl(0, 'CmpItemKindUnit', { fg = '#F5EBD9', bg = '#D4A959' })
    vim.api.nvim_set_hl(0, 'CmpItemKindSnippet', { fg = '#F5EBD9', bg = '#D4A959' })
    vim.api.nvim_set_hl(0, 'CmpItemKindFolder', { fg = '#F5EBD9', bg = '#D4A959' })

    vim.api.nvim_set_hl(0, 'CmpItemKindMethod', { fg = '#DDE5F5', bg = '#6C8ED4' })
    vim.api.nvim_set_hl(0, 'CmpItemKindValue', { fg = '#DDE5F5', bg = '#6C8ED4' })
    vim.api.nvim_set_hl(0, 'CmpItemKindEnumMember', { fg = '#DDE5F5', bg = '#6C8ED4' })

    vim.api.nvim_set_hl(0, 'CmpItemKindInterface', { fg = '#D8EEEB', bg = '#58B5A8' })
    vim.api.nvim_set_hl(0, 'CmpItemKindColor', { fg = '#D8EEEB', bg = '#58B5A8' })
    vim.api.nvim_set_hl(0, 'CmpItemKindTypeParameter', { fg = '#D8EEEB', bg = '#58B5A8' })
end

return {
    {
        'projekt0n/github-nvim-theme',
        branch = '0.0.x',
        enabled = false,
        config = config,
        lazy = false,
        priority = 1000,
    },
    {
        'catppuccin/nvim',
        name = 'catppuccin',
        lazy = false,
        priority = 1000,
        init = function()
            vim.cmd.colorscheme('catppuccin-mocha')
        end,
        opts = {
            custom_highlights = function(C)
                return {
                    CmpItemKindSnippet = { fg = C.base, bg = C.mauve },
                    CmpItemKindKeyword = { fg = C.base, bg = C.red },
                    CmpItemKindText = { fg = C.base, bg = C.teal },
                    CmpItemKindMethod = { fg = C.base, bg = C.blue },
                    CmpItemKindConstructor = { fg = C.base, bg = C.blue },
                    CmpItemKindFunction = { fg = C.base, bg = C.blue },
                    CmpItemKindFolder = { fg = C.base, bg = C.blue },
                    CmpItemKindModule = { fg = C.base, bg = C.blue },
                    CmpItemKindConstant = { fg = C.base, bg = C.peach },
                    CmpItemKindField = { fg = C.base, bg = C.green },
                    CmpItemKindProperty = { fg = C.base, bg = C.green },
                    CmpItemKindEnum = { fg = C.base, bg = C.green },
                    CmpItemKindUnit = { fg = C.base, bg = C.green },
                    CmpItemKindClass = { fg = C.base, bg = C.yellow },
                    CmpItemKindVariable = { fg = C.base, bg = C.flamingo },
                    CmpItemKindFile = { fg = C.base, bg = C.blue },
                    CmpItemKindInterface = { fg = C.base, bg = C.yellow },
                    CmpItemKindColor = { fg = C.base, bg = C.red },
                    CmpItemKindReference = { fg = C.base, bg = C.red },
                    CmpItemKindEnumMember = { fg = C.base, bg = C.red },
                    CmpItemKindStruct = { fg = C.base, bg = C.blue },
                    CmpItemKindValue = { fg = C.base, bg = C.peach },
                    CmpItemKindEvent = { fg = C.base, bg = C.blue },
                    CmpItemKindOperator = { fg = C.base, bg = C.blue },
                    CmpItemKindTypeParameter = { fg = C.base, bg = C.blue },
                    CmpItemKindCopilot = { fg = C.base, bg = C.teal },
                }
            end,
            integrations = {
                cmp = true,
                gitsigns = true,
                telescope = true,
                treesitter = true,
                treesitter_context = true,
                notify = true,
                leap = true,
                mason = true,
                neotree = true,
                neogit = true,
                dap = {
                    enabled = true,
                    enable_ui = true,
                },
                native_lsp = {
                    enabled = true,
                    underlines = {
                        errors = { 'undercurl' },
                        warnings = { 'undercurl' },
                        hints = { 'underline' },
                        information = { 'underline' },
                    },
                },
                overseer = true,
            },
        },
    },
}
