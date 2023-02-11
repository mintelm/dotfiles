return {
    'mfussenegger/nvim-dap',
    config = function()
        require('dap').defaults.fallback.terminal_win_cmd = '10split terminal'

        vim.fn.sign_define('DapBreakpoint', { text = '🛑', texthl = '', linehl = '', numhl = '' })
        --vim.fn.sign_define('DapStopped', { text = '→', texthl = '#56D364', linehl = '', numhl = '' })

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
        {
            'jayp0521/mason-nvim-dap.nvim',
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
