local model = 'claude-opus-4.5'

local copilot_group = mivim.utils.augroup('copilot', false)
vim.api.nvim_create_autocmd('User', {
    group = copilot_group,
    pattern = 'BlinkCmpMenuOpen',
    callback = function()
        require('copilot.suggestion').dismiss()
        vim.b.copilot_suggestion_hidden = true
    end,
})
vim.api.nvim_create_autocmd('User', {
    group = copilot_group,
    pattern = 'BlinkCmpMenuClose',
    callback = function()
        vim.b.copilot_suggestion_hidden = false
    end,
})

return {
    {
        'zbirenbaum/copilot.lua',
        event = 'VeryLazy',
        opts = {
            panel = { enabled = false },
            copilot_model = model,
        },
        keys = {
            { '<leader>ct', function() require('copilot.suggestion').toggle_auto_trigger() end, desc = 'Toggle Copilot Suggestions' },
        },
        specs = {
            {
                'saghen/blink.cmp',
                optional = true,
                opts = function(_, opts)
                    local ai_accept = function()
                        if require('copilot.suggestion').is_visible() then
                            require('copilot.suggestion').accept()
                            return true
                        end
                    end

                    -- insert copilot accept function into blink's <Tab> keymaps before 'fallback'
                    for i, v in ipairs(opts.keymap['<Tab>']) do
                        if v == 'fallback' then
                            table.insert(opts.keymap['<Tab>'], i, ai_accept)
                            break
                        end
                    end
                end
            },
        },
    },
    {
        'olimorris/codecompanion.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-treesitter/nvim-treesitter',
        },
        opts = {
            adapters = {
                http = {
                    copilot = function()
                        return require('codecompanion.adapters').extend('copilot', {
                            schema = {
                                model = {
                                    default = model,
                                },
                            },
                        })
                    end,
                }
            },
        },
        keys = {
            { '<leader>cc', function() require('codecompanion').toggle() end, desc = 'Toggle Code Companion Chat', },
        },
    },
}
