return {
    'mfussenegger/nvim-dap',
    config = function()
        local dap = require('dap')
        local icons = require('style').icons
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

        if vim.fn.filereadable('.vscode/launch.json') then
            -- map launch.json type to filetypes (e.g. cppdbg = { 'c', 'cpp' })
            require('dap.ext.vscode').load_launchjs(nil, { cppdbg = { 'c', 'cpp' } })
        end

        dap.defaults.fallback.terminal_win_cmd = 'ToggleTerm size=10 direction=horizontal [dap-terminal]'
        vim.fn.sign_define(
            'DapBreakpoint',
            { text = icons.ui.breakpoint, texthl = 'GitSignsDelete', linehl = '', numhl = '' }
        )
        vim.fn.sign_define(
            'DapStopped',
            { text = icons.ui.chevron_right, texthl = 'GitSignsAdd', linehl = 'GitSignsAdd', numhl = 'GitSignsAdd' }
        )

        dap.listeners.after['event_terminated']['cleanup'] = function(_, _)
            close_dap_buffers()
            dap.close()
            dap.clear_breakpoints()
            dap.repl.close()
        end
        dap.listeners.after['event_exited']['cleanup'] = function(_, _)
            close_dap_buffers()
            dap.close()
            dap.clear_breakpoints()
            dap.repl.close()
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
                        return require('style').icons.ui.virtual_prefix
                            .. ' '
                            .. variable.name
                            .. ' = '
                            .. variable.value
                    end,
                })
            end,
        },
    },
}
