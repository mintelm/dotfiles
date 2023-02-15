return {
    'mfussenegger/nvim-dap',
    config = function()
        local dap = require('dap')
        local close_dap_buffers = function()
            local win_handles = vim.api.nvim_list_wins()
            for _, win in pairs(win_handles) do
                local buf = vim.api.nvim_win_get_buf(win)
                if
                    vim.api.nvim_buf_get_name(buf):find('%[dap%-repl%]')
                    or vim.api.nvim_buf_get_name(buf):find('%[dap%-terminal%]')
                    or vim.api.nvim_buf_get_name(buf):find('dap%-scopes')
                    or vim.api.nvim_buf_get_name(buf):find('dap%-frames')
                then
                    vim.api.nvim_win_close(win, true)
                    vim.api.nvim_buf_delete(buf, { force = true })
                end
            end
        end

        -- close dap-buffers
        dap.listeners.after['event_terminated']['cleanup'] = function(_, _)
            close_dap_buffers()
        end
        dap.listeners.after['event_exited']['cleanup'] = function(_, _)
            close_dap_buffers()
        end

        dap.defaults.fallback.terminal_win_cmd = 'ToggleTerm size=10 direction=horizontal [dap-terminal]'
        vim.fn.sign_define('DapBreakpoint', { text = '🛑', texthl = '', linehl = '', numhl = '' })

        if vim.fn.filereadable('.vscode/launch.json') then
            -- map launch.json type to filetypes (e.g. cppdbg = { 'c', 'cpp' })
            require('dap.ext.vscode').load_launchjs(nil, { cppdbg = { 'c', 'cpp' } })
        end

        require('mason-nvim-dap').setup({
            automatic_setup = true,
        })
        require('mason-nvim-dap').setup_handlers()
    end,
    dependencies = {
        'jayp0521/mason-nvim-dap.nvim',
        'akinsho/toggleterm.nvim',
        {
            'theHamsta/nvim-dap-virtual-text',
            config = function()
                require('nvim-dap-virtual-text').setup({
                    display_callback = function(variable, _, _, _)
                        return ' ' .. variable.name .. ' = ' .. variable.value
                    end,
                })
            end,
        },
    },
}
