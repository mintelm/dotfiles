return {
    'mfussenegger/nvim-dap',
    config = function()
        require('mason-nvim-dap').setup({
            automatic_setup = true,
        })
        require('mason-nvim-dap').setup_handlers()
    end,
    dependencies = {
        {
            'jayp0521/mason-nvim-dap.nvim',
        },
        {
            'rcarriga/nvim-dap-ui',
            config = function()
                local dap = require('dap')
                local dapui = require('dapui')
                dap.listeners.after.event_initialized['dapui_config'] = function()
                    dapui.open()
                end
                dap.listeners.before.event_terminated['dapui_config'] = function()
                    dapui.close()
                end
                dap.listeners.before.event_exited['dapui_config'] = function()
                    dapui.close()
                end
                dapui.setup()
            end,
        },
        {
            'theHamsta/nvim-dap-virtual-text',
            config = function()
                require('nvim-dap-virtual-text').setup()
            end,
            dependencies = 'nvim-treesitter/nvim-treesitter',
        },
    },
}
