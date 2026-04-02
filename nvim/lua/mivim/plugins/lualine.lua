local pad_icon = mivim.utils.pad_str

return {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    dependencies = 'kyazdani42/nvim-web-devicons',
    opts = {
        options = {
            component_separators = '',
            section_separators = { left = '', right = '' },
        },
        sections = {
            lualine_a = {
                {
                    'mode',
                    icon = mivim.style.icons.ui.vim,
                    separator = { left = '', right = '' },
                },
            },
            lualine_b = {
                { 'branch', icon = mivim.style.icons.git.branch, separator = '|' },
                {
                    'diff',
                    symbols = {
                        added = pad_icon(mivim.style.icons.git.add, false, true),
                        modified = pad_icon(mivim.style.icons.git.change, false, true),
                        removed = pad_icon(mivim.style.icons.git.delete, false, true),
                    },
                    source = function()
                        local gitsigns = vim.b.gitsigns_status_dict
                        if gitsigns then
                            return {
                                added = gitsigns.added,
                                modified = gitsigns.changed,
                                removed = gitsigns.removed
                            }
                        end
                    end,
                },
            },
            lualine_c = {
                { 'filetype', icon_only = true, padding = { left = 1, right = 0 } },
                {
                    'filename',
                    newfile_status = true,
                    symbols = {
                        modified = pad_icon(mivim.style.icons.ui.modified, false, true),
                        readonly = mivim.style.icons.ui.readonly,
                        unnamed = '',
                    },
                },
            },
            lualine_x = { 'encoding', { 'fileformat', padding = { left = 1, right = 2 } } },
            lualine_y = {
                {
                    'diagnostics',
                    symbols = {
                        error = pad_icon(mivim.style.icons.lsp.signs.error, false, true),
                        warn = pad_icon(mivim.style.icons.lsp.signs.warn, false, true),
                        info = pad_icon(mivim.style.icons.lsp.signs.info, false, true),
                        hint = pad_icon(mivim.style.icons.lsp.signs.hint, false, true),
                    },
                    separator = '|',
                },
                {
                    'lsp_status',
                    icon = mivim.style.icons.lsp.server,
                },
            },
            lualine_z = {
                { 'progress' },
                { 'location', padding = { left = 0, right = 1 }, separator = { left = '', right = '' } },
            },
        },
        extensions = {
            'nvim-tree',
            'toggleterm',
            'man',
            'mason',
            'nvim-dap-ui',
        },
    },
}
