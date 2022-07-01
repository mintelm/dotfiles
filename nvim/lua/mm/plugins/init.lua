local utils = require('mm.utils.packer')

local conf = utils.conf

utils.bootstrap_packer()

--- NOTE "use" functions cannot call *upvalues* i.e. the functions
--- passed to setup or config etc. cannot reference aliased functions
--- or local variables
require('packer').startup({function(use)
    use 'wbthomason/packer.nvim'

    use 'ellisonleao/gruvbox.nvim'

    use 'kyazdani42/nvim-web-devicons'

    -- can be removed once https://github.com/neovim/neovim/pull/15436 is merged
    use('lewis6991/impatient.nvim')

    use {
        'nvim-telescope/telescope.nvim',
        requires = 'nvim-lua/plenary.nvim',
        config = conf('telescope'),
    }

    use {
        'neovim/nvim-lspconfig',
        config = conf('lspconfig'),
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
        event = 'InsertEnter',
        requires = {
            { 'hrsh7th/cmp-nvim-lsp', after = 'nvim-lspconfig' },
            { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' },
            { 'hrsh7th/cmp-path', after = 'nvim-cmp' },
            { 'hrsh7th/cmp-cmdline', after = 'nvim-cmp' },
            { 'saadparwaiz1/cmp_luasnip', after = 'nvim-cmp' },
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
            'anuvyklack/keymap-layer.nvim',
            'sindrets/winshift.nvim',
        },
        config = conf('hydra'),
    }

    use {
        'stevearc/dressing.nvim',
        after = 'telescope.nvim',
        config = conf('dressing'),
    }
end,
})
