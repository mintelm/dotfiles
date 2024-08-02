local utils = require('utils')

-- fix exit behavior of toggle term (E948: Job still running) on :qa
utils.augroup('ToggleTermFix', {
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

return {
    'akinsho/toggleterm.nvim',
    event = 'VeryLazy',
    opts = {
        start_in_insert = false,
        float_opts = {
            border = require('style').current.border,
        }
    },
}
