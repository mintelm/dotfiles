local fn = vim.fn
local fmt = string.format
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

-- Auto install packer.nvim if not exists
if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
end

local function conf(name)
    return require(fmt('mm.plugins.config.%s', name))
end

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    use {
        'ellisonleao/gruvbox.nvim',
        requires = 'rktjmp/lush.nvim',
        config = conf('gruvbox'),
    }

    use {
        'nvim-telescope/telescope.nvim',
        requires = 'nvim-lua/plenary.nvim',
        config = conf('telescope')
    }

    use {
        'neovim/nvim-lspconfig',
        config = conf('lspconfig'),
    }

    use {
        'L3MON4D3/LuaSnip',
        requires = 'rafamadriz/friendly-snippets',
        config = function()
            require('luasnip/loaders/from_vscode').lazy_load()
        end,
    }

    use {
        'hrsh7th/nvim-cmp',
        requires = {
            'hrsh7th/cmp-nvim-lsp',
            'saadparwaiz1/cmp_luasnip',
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

    -- use 'ggandor/lightspeed.nvim'

    use {
        'phaazon/hop.nvim',
        config = function()
            require'hop'.setup{}
        end,
    }

    use {
        'anuvyklack/hydra.nvim',
        config = conf('hydra'),
    }

    if packer_bootstrap then
        require('packer').sync()
    end
end)
