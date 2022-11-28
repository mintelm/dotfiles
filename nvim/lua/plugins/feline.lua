return function()
    local hydra = require('hydra.statusline')
    local get_hl = require('utils').get_hl
    local colors = require('github-theme.palette').get_palette('dark_default')
    local icons = require('style').icons
    local components = {
        active = {},
        inactive = {},
    }

    local function pad_icon(icon, padding)
        if padding == 'left' then
            return ' ' .. icon
        elseif padding == 'right' then
            return icon .. ' '
        elseif padding == 'both' then
            return ' ' .. icon .. ' '
        end
    end

    -- left section
    components.active[1] = {
        -- Component that shows vi mode and active hydra
        {
            provider = 'vi_mode_hydra',
            hl = function()
                local hl = {
                    name = require('feline.providers.vi_mode').get_mode_highlight_name(),
                    fg = require('feline.providers.vi_mode').get_mode_color(),
                    style = 'bold',
                }

                if hydra.is_active() then
                    hl.fg = get_hl('Hydra' .. hydra.get_color(), 'fg')
                end

                return hl
            end,
            left_sep = ' ',
            right_sep = ' ',
        },
        -- Component that shows file info
        {
            provider = {
                name = 'file_info',
                opts = {
                    type = 'relative-short',
                    file_readonly_icon = icons.readonly,
                    file_modified_icon = pad_icon(icons.modified, 'right'),
                },
            },
            hl = {
                fg = colors.syntax.comment,
            },
        },
        -- Component that shows current git branch
        {
            provider = 'git_branch',
            icon = pad_icon(icons.git.branch, 'both'),
            hl = {
                fg = colors.fg,
                style = 'bold',
            },
        },
        -- Component that shows git diff additions
        {
            provider = 'git_diff_added',
            icon = pad_icon(icons.git.add, 'both'),
            hl = {
                fg = colors.git.add,
                style = 'bold',
            },
        },
        -- Component that shows git diff removals
        {
            provider = 'git_diff_removed',
            icon = pad_icon(icons.git.delete, 'both'),
            hl = {
                fg = colors.git.delete,
                style = 'bold',
            },
        },
        -- Component that shows git diff changes
        {
            provider = 'git_diff_changed',
            icon = pad_icon(icons.git.change, 'both'),
            hl = {
                fg = colors.git.change,
                style = 'bold',
            },
        },
    }

    -- right section
    components.active[2] = {
        {
            provider = 'diagnostic_errors',
            icon = pad_icon(icons.lsp.signs.error, 'both'),
            hl = {
                fg = colors.error,
            },
        },
        {
            provider = 'diagnostic_warnings',
            icon = pad_icon(icons.lsp.signs.warn, 'both'),
            hl = {
                fg = colors.warning,
            },
        },
        {
            provider = 'diagnostic_hints',
            icon = pad_icon(icons.lsp.signs.hint, 'both'),
            hl = {
                fg = colors.hint,
            },
        },
        {
            provider = 'diagnostic_info',
            icon = pad_icon(icons.lsp.signs.info, 'both'),
            hl = {
                fg = colors.info,
            },
        },
        {
            provider = 'lsp_client_names',
            icon = pad_icon(icons.lsp.server, 'both'),
            hl = {
                fg = colors.fg,
                style = 'bold',
            },
            right_sep = ' ',
        },
        {
            provider = {
                name = 'position',
                opts = {
                    format = icons.lines .. ' {line} ' .. icons.columns .. ' {col}',
                },
            },
            hl = {
                fg = colors.syntax.comment,
            },
            right_sep = ' ',
        },
        {
            provider = {
                name = 'scroll_bar',
                opts = {
                    reverse = true,
                },
            },
            hl = function()
                return {
                    fg = require('feline.providers.vi_mode').get_mode_color(),
                    style = 'bold',
                }
            end,
            right_sep = ' ',
        },
    }

    components.inactive[1] = vim.deepcopy(components.active[1])
    components.inactive[2] = components.active[2]

    require('feline').setup({
        components = components,
        custom_providers = {
            vi_mode_hydra = function()
                local mode = require('feline.providers.vi_mode').get_vim_mode()

                if hydra.is_active() then
                    mode = hydra.get_name():upper()
                end

                return ' ' .. mode
            end,
        },
    })
end
