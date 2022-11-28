local utils = require('utils')
local conf = utils.conf
local bootstrapped = utils.bootstrap_packer()

--- NOTE 'use' functions cannot call *upvalues* i.e. the functions
--- passed to setup or config etc. cannot reference aliased functions
--- or local variables
require('packer').startup({
    function(use)
        use('wbthomason/packer.nvim')

        -- can be removed once https://github.com/neovim/neovim/pull/15436 is merged
        use('lewis6991/impatient.nvim')

        use({
            'projekt0n/github-nvim-theme',
            config = conf('github_theme'),
        })

        use('kyazdani42/nvim-web-devicons')

        use({
            'nvim-telescope/telescope.nvim',
            requires = {
                { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
                { 'nvim-lua/plenary.nvim' },
            },
            config = conf('telescope'),
        })

        use({
            'stevearc/dressing.nvim',
            after = 'telescope.nvim',
            config = conf('dressing'),
        })

        use({
            'lewis6991/gitsigns.nvim',
            config = conf('gitsigns'),
        })

        use({
            'TimUntersberger/neogit',
            requires = 'nvim-lua/plenary.nvim',
        })

        use({
            'rcarriga/nvim-notify',
            config = conf('notify'),
        })

        use({
            'nvim-treesitter/nvim-treesitter',
            config = conf('treesitter'),
        })

        use({
            'feline-nvim/feline.nvim',
            config = conf('feline'),
        })

        use({
            'akinsho/bufferline.nvim',
            config = conf('bufferline'),
        })

        use({
            'lukas-reineke/indent-blankline.nvim',
            config = conf('indentline'),
        })

        use({
            'phaazon/hop.nvim',
            config = conf('hop'),
        })

        use({
            'williamboman/mason.nvim',
            config = conf('mason'),
        })

        use({
            'neovim/nvim-lspconfig',
            requires = {
                { 'ray-x/lsp_signature.nvim', config = conf('lsp_signature') },
                { 'williamboman/mason-lspconfig.nvim' },
            },
            config = conf('lspconfig'),
            after = 'mason.nvim',
        })

        use({
            'jose-elias-alvarez/null-ls.nvim',
            requires = { 'jayp0521/mason-null-ls.nvim' },
            config = conf('null_ls'),
            after = 'mason.nvim',
        })

        use({
            'mfussenegger/nvim-dap',
            requires = { 'jayp0521/mason-nvim-dap.nvim' },
            config = conf('dap'),
            after = 'mason.nvim',
        })

        use({
            'hrsh7th/nvim-cmp',
            requires = {
                'hrsh7th/cmp-path',
                'hrsh7th/cmp-nvim-lsp',
                'hrsh7th/cmp-nvim-lua',
                'saadparwaiz1/cmp_luasnip',
                'hrsh7th/cmp-buffer',
                'hrsh7th/cmp-cmdline',
                'lukas-reineke/cmp-rg',
                'lukas-reineke/cmp-under-comparator',
            },
            config = conf('cmp'),
        })

        use({
            'L3MON4D3/LuaSnip',
            requires = 'rafamadriz/friendly-snippets',
            event = 'InsertEnter',
            config = conf('luasnip'),
        })

        use({
            'anuvyklack/hydra.nvim',
            requires = 'sindrets/winshift.nvim',
            config = conf('hydra'),
        })

        if bootstrapped then
            require('packer').sync()
        end
    end,
})
