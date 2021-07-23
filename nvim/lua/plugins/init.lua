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

vim.cmd('packadd packer.nvim')

local function conf(name)
    return require(fmt('plugins.config.%s', name))
end

return require('packer').startup(function()
    use 'wbthomason/packer.nvim'

    use {
        'npxbr/gruvbox.nvim',
        requires = 'rktjmp/lush.nvim',
        config = conf('gruvbox'),
    }

    use {
        'nvim-telescope/telescope.nvim',
        requires = { 'nvim-lua/popup.nvim', 'nvim-lua/plenary.nvim' },
        config = conf('telescope')
    }

    use {
        'neovim/nvim-lspconfig',
        config = conf('lspconfig'),
    }

    use {
        'nvim-lua/completion-nvim',
        config = conf('completion'),
    }

    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = conf('treesitter'),
    }

    use {
        'hoob3rt/lualine.nvim',
        requires = 'kyazdani42/nvim-web-devicons',
        config = conf('lualine'),
    }

    use {
        'akinsho/nvim-bufferline.lua',
        requires = 'kyazdani42/nvim-web-devicons',
        config = conf('bufferline'),
    }

    use {
        'lewis6991/gitsigns.nvim',
        requires = 'nvim-lua/plenary.nvim',
        config = conf('gitsigns'),
    }

    use {
        'TimUntersberger/neogit',
        requires = 'nvim-lua/plenary.nvim',
        config = function()
            require('neogit').setup({ })
        end
    }

    use {
        'lukas-reineke/indent-blankline.nvim',
        config = conf('indentline'),
    }

    use {
        'dstein64/nvim-scrollview',
        config = function()
            require('telescope').setup({
                scrollview_blend = 100,
            })
        end,
    }

    use 'ggandor/lightspeed.nvim'
end)
