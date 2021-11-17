local fn = vim.fn
local fmt = string.format
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

-- Auto install packer.nvim if not exists
if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

local function conf(name)
    return require(fmt('mm.plugins.config.%s', name))
end

return require('packer').startup(function(use)
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
        'ms-jpq/coq-nvim',
        requires = { 'ms-jpq/coq.artifacts' },
        config = conf('coq-nvim'),
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

    if packer_bootstrap then
        require('packer').sync()
    end
end)
