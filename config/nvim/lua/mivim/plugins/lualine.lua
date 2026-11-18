--- @param icon string
--- @return string
local function pad_icon(icon)
    return icon .. ' '
end

return {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    dependencies = 'nvim-tree/nvim-web-devicons',
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
                        added = pad_icon(mivim.style.icons.git.add),
                        modified = pad_icon(mivim.style.icons.git.change),
                        removed = pad_icon(mivim.style.icons.git.delete),
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
                        modified = pad_icon(mivim.style.icons.ui.modified),
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
                        error = pad_icon(mivim.style.icons.lsp.signs.error),
                        warn = pad_icon(mivim.style.icons.lsp.signs.warn),
                        info = pad_icon(mivim.style.icons.lsp.signs.info),
                        hint = pad_icon(mivim.style.icons.lsp.signs.hint),
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
            'man',
            'nvim-dap-ui',
        },
    },
}
