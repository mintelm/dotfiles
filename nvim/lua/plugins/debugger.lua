local style = require('style')

return {
    'rcarriga/nvim-dap-ui',
    event = 'VeryLazy',
    dependencies = {
        { 'nvim-neotest/nvim-nio' },
        {
            'mfussenegger/nvim-dap',
            init = function()
                local dap = require('dap')
                local dapui = require('dapui')

                if vim.fn.filereadable('.vscode/launch.json') then
                    -- map launch.json type to filetypes (e.g. cppdbg = { 'c', 'cpp' })
                    require('dap.ext.vscode').load_launchjs(nil, { cppdbg = { 'c', 'cpp' } })
                end

                dap.repl.commands = vim.tbl_extend('force', dap.repl.commands, {
                    custom_commands = {
                        ['.restart'] = dap.restart,
                    },
                })

                vim.fn.sign_define('DapBreakpoint', { text = style.icons.ui.breakpoint, texthl = 'f38b83' })
                vim.fn.sign_define('DapStopped', { text = style.icons.ui.chevron_right, texthl = 'f38b83' })

                dap.listeners.after.stackTrace['auto-center'] = function()
                    vim.cmd.normal('zzzv')
                end
                dap.listeners.after.event_initialized['dapui'] = function()
                    dapui.open({ reset = true })
                end
                dap.listeners.after.event_terminated['dapui'] = function()
                    dapui.close()
                    dap.repl.close()
                end
                dap.listeners.after.event_exited['dapui'] = function()
                    dapui.close()
                    dap.repl.close()
                end
            end,
        },
    },
    opts = {
        controls = {
            enabled = false,
        },
        windows = {
            indent = 2,
        },
        layouts = {
            {
                elements = {
                    { id = 'scopes',      size = 0.25, },
                    { id = 'breakpoints', size = 0.25, },
                    { id = 'stacks',      size = 0.25, },
                    { id = 'watches',     size = 0.25, },
                },
                position = 'left',
                size = 40,
            },
            {
                elements = {
                    { id = 'console', size = 1, },
                },
                position = 'bottom',
                size = 10,
            },
        },
    },
    keys = {
        { '<Leader>db', function() require('dap').toggle_breakpoint() end,        desc = 'Toggle Breakpoint' },
        { '<Leader>dc', function() require('dap').continue() end,                 desc = 'Continue' },
        { '<Leader>ds', function() require('dap').step_over() end,                desc = 'Step Over' },
        { '<Leader>di', function() require('dap').step_into() end,                desc = 'Step Into' },
        { '<Leader>do', function() require('dap').step_out() end,                 desc = 'Step Out' },
        { '<Leader>dr', function() require('dap').repl_open() end,                desc = 'Open REPL' },
        { '<Leader>du', function() require('dapui').toggle({ reset = true }) end, desc = 'Toggle UI' },
        { '<Leader>dw', function() require('dapui').elements.watches.add() end,   desc = 'Add To Watchlist' },
    },
}
