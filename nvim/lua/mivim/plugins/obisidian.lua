return {
    'obsidian-nvim/obsidian.nvim',
    event = 'VeryLazy',
    opts = {
        legacy_commands = false, -- this will be removed in the next major release
        workspaces = {
            {
                name = 'work',
                path = '~/vaults/work',
            },
        },
        note_id_func = function(title)
            return title
        end,
        daily_notes = {
            folder = 'days',
        },
    },
    keys = {
        {
            '<leader>on',
            function()
                -- workaround since Obsidian currently uses vim.fn.input instead of vim.ui.input
                -- and vim.ui.input looks nicer IMO
                vim.ui.input(
                    { prompt = 'Enter note name: ', default = '', completion = 'file' },
                    function(input)
                        if input == '' or input == nil then
                            return vim.notify('Aborted', vim.log.levels.WARN)
                        end
                        vim.cmd.Obsidian('new', input)
                    end)
            end,
            desc = 'New Note'
        },
        { '<leader>of', function() vim.cmd.Obsidian('quick_switch') end, desc = 'Find Notes' },
        { '<leader>ot', function() vim.cmd.Obsidian('today') end,        desc = 'Open Today' },
        { '<leader>od', function() vim.cmd.Obsidian('dailies') end,      desc = 'Open Days' },
    },
}
