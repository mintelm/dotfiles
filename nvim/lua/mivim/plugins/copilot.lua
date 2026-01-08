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
vim.api.nvim_create_autocmd('BufEnter', {
    group = copilot_group,
    pattern = 'copilot-*',
    callback = function()
        vim.opt_local.relativenumber = false
        vim.opt_local.number = false
        vim.opt_local.conceallevel = 0
    end,
})

return {
    {
        'zbirenbaum/copilot.lua',
        event = 'VeryLazy',
        opts = {
            suggestion = {
                auto_trigger = true,
            },
            panel = { enabled = false },
            copilot_model = model,
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
        'CopilotC-Nvim/CopilotChat.nvim',
        dependencies = {
            { 'nvim-lua/plenary.nvim', branch = 'master' },
        },
        build = 'make tiktoken',
        opts = {
            model = model,
            window = {
                title = '🤖 AI Assistant',
            },
            headers = {
                user = '👤 You',
                assistant = '🤖 Copilot',
                tool = '🔧 Tool',
            },
            separator = '━━',
        },
        keys = {
            { '<leader>cc', function() require('CopilotChat').toggle() end,        desc = 'Toggle Copilot Chat', },
            { '<leader>cs', function() require('CopilotChat').select_prompt() end, desc = 'Select Copilot Prompt', mode = { 'n', 'v' } },
        },
    },
}
