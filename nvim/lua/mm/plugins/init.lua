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
    return require(fmt('mm.plugins.config.%s', name))
end

return require('packer').startup(function()
    use 'wbthomason/packer.nvim'

    use {
        'npxbr/gruvbox.nvim',
        requires = 'rktjmp/lush.nvim',
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
        requires = { 'nvim-lua/plenary.nvim', 'sindrets/diffview.nvim' },
        config = function()
            require('neogit').setup({
                integrations = {
                    diffview = true
                }
            })
        end
    }

    use {
        'lukas-reineke/indent-blankline.nvim',
        config = conf('indentline'),
    }

    use {
        'dstein64/nvim-scrollview',
        config = function()
            vim.g.scrollview_column = 1
            vim.g.scrollview_current_only = true
        end,
    }

    use 'ggandor/lightspeed.nvim'
end)