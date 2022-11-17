local utils = require('mm.utils')
local conf = utils.conf
local bootstrapped = utils.bootstrap_packer()

--- NOTE 'use' functions cannot call *upvalues* i.e. the functions
--- passed to setup or config etc. cannot reference aliased functions
--- or local variables
require('packer').startup({function(use)
    use 'wbthomason/packer.nvim'

    -- can be removed once https://github.com/neovim/neovim/pull/15436 is merged
    use 'lewis6991/impatient.nvim'

    use {
        'projekt0n/github-nvim-theme',
        config = conf('github-nvim-theme'),
    }

    use 'kyazdani42/nvim-web-devicons'

    use {
        'nvim-telescope/telescope.nvim',
        requires = {
            { 'nvim-lua/plenary.nvim' },
            { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
        },
        config = conf('telescope'),
    }

    use {
        'neovim/nvim-lspconfig',
        config = conf('lspconfig'),
        requires = {
            { 'ray-x/lsp_signature.nvim', config = conf('lsp_signature') }
        }
    }

    use {
        'L3MON4D3/LuaSnip',
        event = 'InsertEnter',
        requires = 'rafamadriz/friendly-snippets',
        config = function()
            require('luasnip/loaders/from_vscode').lazy_load()
        end,
    }

    use {
        'hrsh7th/nvim-cmp',
        requires = {
            { 'hrsh7th/cmp-path' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-nvim-lua' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-cmdline' },
            { 'lukas-reineke/cmp-rg' },
            { 'lukas-reineke/cmp-under-comparator' },
        },
        config = conf('cmp'),
    }

    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = conf('treesitter'),
    }

    use {
        'akinsho/bufferline.nvim',
        requires = 'kyazdani42/nvim-web-devicons',
        config = conf('bufferline'),
    }

    use {
        'lewis6991/gitsigns.nvim',
        config = conf('gitsigns'),
    }

    use {
        'TimUntersberger/neogit',
        requires = 'nvim-lua/plenary.nvim',
    }

    use {
        'lukas-reineke/indent-blankline.nvim',
        config = conf('indentline'),
    }

    use {
        'phaazon/hop.nvim',
        config = function()
            require('hop').setup{}
        end,
    }

    use {
        'anuvyklack/hydra.nvim',
        requires = {
            -- needed for window control hydra
            'sindrets/winshift.nvim',
        },
        config = conf('hydra'),
    }

    use {
        'stevearc/dressing.nvim',
        after = 'telescope.nvim',
        config = conf('dressing'),
    }

    use {
        'feline-nvim/feline.nvim',
        config = conf('feline'),
    }

    if bootstrapped then
        require('packer').sync()
    end
end,
})
