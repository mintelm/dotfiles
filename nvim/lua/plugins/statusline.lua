local function config()
    local style = require('style')
    local pad_icon = require('utils').pad_str

    require('lualine').setup({
        options = {
            theme = 'auto',
            component_separators = '',
            section_separators = { left = '', right = '' },
        },
        sections = {
            lualine_a = {
                {
                    'mode',
                    icon = style.icons.ui.vim,
                    separator = { left = '', right = '' },
                },
            },
            lualine_b = {
                { 'branch', icon = style.icons.git.branch, separator = '|' },
                {
                    'diff',
                    symbols = {
                        added = pad_icon(style.icons.git.add, false, true),
                        modified = pad_icon(style.icons.git.change, false, true),
                        removed = pad_icon(style.icons.git.delete, false, true),
                    },
                    source = function()
                        ---@diagnostic disable-next-line: undefined-field
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
                        modified = pad_icon(style.icons.ui.modified, false, true),
                        readonly = style.icons.ui.readonly,
                        unnamed = '',
                    },
                },
            },
            lualine_x = { 'encoding', { 'fileformat', padding = { left = 1, right = 2 } } },
            lualine_y = {
                {
                    'diagnostics',
                    symbols = {
                        error = pad_icon(style.icons.lsp.signs.error, false, true),
                        warn = pad_icon(style.icons.lsp.signs.warn, false, true),
                        info = pad_icon(style.icons.lsp.signs.info, false, true),
                        hint = pad_icon(style.icons.lsp.signs.hint, false, true),
                    },
                    separator = '|',
                },
                -- lsp server custom component
                {
                    function()
                        local msg = ''
                        local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
                        local clients = vim.lsp.get_active_clients()
                        if next(clients) then
                            for _, client in ipairs(clients) do
                                local filetypes = client.config.filetypes
                                if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                                    if msg == '' then
                                        msg = client.name
                                    elseif not msg:find(client.name) then
                                        msg = msg .. pad_icon(style.icons.lsp.server, true, true) .. client.name
                                    end
                                end
                            end
                        end
                        return msg
                    end,
                    icon = style.icons.lsp.server,
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
        },
    })
end

return {
    'nvim-lualine/lualine.nvim',
    config = config,
    dependencies = {
        'kyazdani42/nvim-web-devicons',
        -- colorscheme needs to be loaded for theme = 'auto'
        'projekt0n/github-nvim-theme',
    },
}
