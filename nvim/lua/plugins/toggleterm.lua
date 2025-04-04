local cmd = require('utils').cmd
local augroup = require('utils').augroup

return {
    'akinsho/toggleterm.nvim',
    event = 'VeryLazy',
    config = function()
        require('toggleterm').setup({
            start_in_insert = false,
        })

        -- fix exit behavior of toggle term (E948: Job still running) on :qa
        augroup('ToggleTermFix', {
            {
                event = { 'TermEnter' },
                command = function()
                    for _, buffers in ipairs(vim.fn.getbufinfo()) do
                        local filetype = vim.api.nvim_buf_get_option(buffers.bufnr, 'filetype')
                        if filetype == 'toggleterm' then
                            vim.api.nvim_create_autocmd({ 'BufWriteCmd', 'FileWriteCmd', 'FileAppendCmd' }, {
                                buffer = buffers.bufnr,
                                command = 'q!',
                            })
                        end
                    end
                end,
            },
        })
    end,
    keys = {
        { '<leader>t', cmd('ToggleTerm direction=float') },
        { '<esc>',     '<C-\\><C-n>',                    mode = 't' },
    },
}
