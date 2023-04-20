local style = require('style')

local function dap_config()
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

    vim.fn.sign_define('DapBreakpoint', { text = style.icons.ui.breakpoint })
    vim.fn.sign_define('DapStopped', { text = style.icons.ui.chevron_right })

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
end

return {
    {
        'mfussenegger/nvim-dap',
        config = dap_config,
        dependencies = {
            {
                'rcarriga/nvim-dap-ui',
                opts = {
                    controls = {
                        enabled = false,
                    },
                    windows = {
                        indent = 2,
                    },
                    floating = {
                        border = style.current.border,
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
            },
            {
                'jayp0521/mason-nvim-dap.nvim',
                config = function()
                    require('mason-nvim-dap').setup({
                        ensure_installed = { 'cppdbg' },
                        automatic_setup = true,
                        handlers = {},
                    })
                end,
                dependencies = { 'williamboman/mason.nvim' },
            },
        },
    },
}
