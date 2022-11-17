return function()
    local hydra = require('hydra.statusline')
    local get_hl = require('mm.highlights').get_hl
    local components = {
        active = {},
        inactive = {}
    }

    -- left section
    components.active[1] = {
        -- Component that shows vi mode and active hydra
        {
            provider = 'vi_mode_hydra',
            hl = function()
                local hl = {
                    name = require('feline.providers.vi_mode').get_mode_highlight_name(),
                    fg = require('feline.providers.vi_mode').get_mode_color(),
                    style = 'bold'
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
                    file_readonly_icon = mm.style.icons.readonly .. ' ',
                    file_modified_icon = mm.style.icons.modified .. ' ',
                },
            },
            hl = {
                fg = 'grey',
            },
            right_sep = ' ',
        },
        -- Component that shows current git branch
        {
            provider = 'git_branch',
            hl = {
                fg = 'white',
            },
        },
        -- Component that shows git diff additions
        {
            provider = 'git_diff_added',
            hl = function()
                return {
                    fg = get_hl('GitSignsAdd', 'fg', 'green'),
                }
            end,
        },
        -- Component that shows git diff removals
        {
            provider = 'git_diff_removed',
            hl = function()
                return {
                    fg = get_hl('GitSignsDelete', 'fg', 'red'),
                }
            end,
        },
        -- Component that shows git diff changes
        {
            provider = 'git_diff_changed',
            hl = function()
                return {
                    fg = get_hl('GitSignsChange', 'fg', 'orange'),
                }
            end,
        }
    }

    -- right section
    components.active[2] = {
        {
            provider = 'diagnostic_errors',
        },
        {
            provider = 'diagnostic_warnings',
        },
        {
            provider = 'diagnostic_hints',
        },
        {
            provider = 'diagnostic_info',
        },
        {
            provider = 'lsp_client_names',
        },
        {
            provider = 'position',
        },
        {
            provider = 'line_percentage',
        },
        {
            provider = {
                name = 'scroll_bar',
                opts = {
                    reverse = true,
                },
            },
            hl = {
                fg = 'skyblue',
                style = 'bold',
            },
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
            end
        }
    })
end
