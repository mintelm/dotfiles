local style = require('style')
local actions = require('telescope.actions')

return {
    'nvim-telescope/telescope.nvim',
    event = 'VeryLazy',
    dependencies = {
        { 'nvim-lua/plenary.nvim' },
        { 'kyazdani42/nvim-web-devicons' },
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make', },
    },
    config = function()
        require('telescope').load_extension('fzf')
        require('telescope').setup({
            defaults = {
                prompt_prefix = style.icons.ui.telescope .. ' ',
                set_env = { ['COLORTERM'] = 'truecolor' },
                mappings = {
                    i = {
                        ['<c-c>'] = function()
                            vim.cmd('stopinsert!')
                        end,
                        ['<esc>'] = actions.close,
                        ['<c-s>'] = actions.select_horizontal,
                        ['<c-j>'] = actions.cycle_history_next,
                        ['<c-k>'] = actions.cycle_history_prev,
                    },
                },
                file_ignore_patterns = {
                    '%.jpg', '%.jpeg', '%.png', '%.otf', '%.ttf', '%.o', '%.arxml', '%.dvg', '%.dll*', '%.exe', '%.defines', '%.jar',
                },
                layout_strategy = 'flex',
            },
        })
    end
}
