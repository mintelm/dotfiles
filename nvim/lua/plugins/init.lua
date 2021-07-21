-- Auto install packer.nvim if not exists
local fn = vim.fn
local fmt = string.format

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
    vim.notify('Downloading packer.nvim...')
    vim.notify(
        fn.system { 'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path }
    )
end

vim.cmd([[packadd packer.nvim]])

local function conf(name)
    return require(fmt('plugins.config.%s', name))
end

return require('packer').startup(function()
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- Colorscheme
    use {
        'npxbr/gruvbox.nvim',
        requires = { 'rktjmp/lush.nvim' },
        config = conf('gruvbox'),
    }

    -- Fuzzy finder
    use {
        'nvim-telescope/telescope.nvim',
        requires = { { 'nvim-lua/popup.nvim' }, { 'nvim-lua/plenary.nvim' } },
    }

    -- LSP
    use {
        'neovim/nvim-lspconfig',
        config = conf('lspconfig'),
    }

    -- Completion
    use {
        'nvim-lua/completion-nvim',
        config = conf('completion'),
    }

    -- Treesitter
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = conf('treesitter'),
    }

    -- Bufferline
    use {
        'akinsho/nvim-bufferline.lua',
        requires = 'kyazdani42/nvim-web-devicons',
        config = conf('bufferline'),
    }

    --[[ Statusline
    use {
        'datwaft/bubbly.nvim',
    }
    --]]

    -- Lightspeed
    use 'ggandor/lightspeed.nvim'

    -- git hunks/signs
    use {
        'lewis6991/gitsigns.nvim',
        requires = {
            'nvim-lua/plenary.nvim'
        },
        config = conf('gitsigns'),
    }

    use "lukas-reineke/indent-blankline.nvim"
end)
