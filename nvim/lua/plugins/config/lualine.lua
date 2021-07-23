return function()
    local function get_lsp_name()
        local icon = '  ' -- 
        local msg = icon .. 'No Active Lsp'
        local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
        local clients = vim.lsp.get_active_clients()

        if next(clients) == nil
            then return msg
        end

        for _, client in ipairs(clients) do
            local filetypes = client.config.filetypes
            if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                return icon .. client.name
            end
        end

        return msg
    end

    local function get_lsp_sign(type)
        local name = 'LspDiagnosticsSign' .. type
        local sign = vim.fn.sign_getdefined(name)

        return sign[1].text
    end

    require('lualine').setup({
        options = {
            theme = 'gruvbox',
            component_separators = { '', '|' },
            section_separators = { '', '' },
        },
        sections = {
            lualine_b = {
                'branch',
                {
                    'diff',
                    symbols = { added = ' ', modified = '柳 ', removed = ' ' }
                },
            },
            lualine_c = {
                { get_lsp_name },
                {
                    'diagnostics',
                    sources = { 'nvim_lsp' },
                    symbols = {
                        error = get_lsp_sign('Error'),
                        warn = get_lsp_sign('Warning'),
                        info = get_lsp_sign('Information'),
                        hint = get_lsp_sign('Hint'),
                    }
                }
            },
            lualine_x = {
                'encoding',
                'fileformat',
                'filetype',
            },
        },
    })
end
