local map = require('utils').map
local cmd = require('utils').cmd

local silenced = { silent = true }

vim.g.mapleader = ','

-- most of plugin related keymaps are defined in 'plugins/hydra.lua'

-- unmap
map('', '<C-b>', '', {})
map('', '<C-f>', '', {})

-- navigation
map('', ']q', cmd('cnext', 'zzzv'), silenced)
map('', '[q', cmd('cprev', 'zzzv'), silenced)
map('', ']Q', cmd('clast', 'zzzv'), silenced)
map('', '[Q', cmd('cfirst', 'zzzv'), silenced)
map('', ']t', cmd('tabnext'), silenced)
map('', '[t', cmd('tabprev'), silenced)
map('', ']T', cmd('tablast'), silenced)
map('', '[T', cmd('tabfirst'), silenced)

-- clear highlight on space
map('n', '<Space>', cmd('noh'), silenced)

-- fancy remaps
map('v', 'K', [[:m '<-2<CR>gv=gv]], silenced)
map('v', 'J', [[:m '>+1<CR>gv=gv]], silenced)
map('n', 'J', 'mzJ`z', silenced)
map('n', '<C-d>', '<C-d>zz', silenced)
map('n', '<C-u>', '<C-u>zz', silenced)
map('n', 'n', 'nzzzv', silenced)
map('n', 'N', 'Nzzzv', silenced)
map({ 'n', 'v' }, '<leader>y', [["+y]], silenced)
map({ 'n', 'v' }, '<leader>Y', [["+Y]], silenced)
map('n', 'Q', '<nop>', silenced)
map('c', '<enter>',
    function()
        local cmdtype = vim.fn.getcmdtype()
        if cmdtype == '/' or cmdtype == '?' then
            return '<CR>zzzv'
        end
        return '<CR>'
    end,
    { expr = true, silent = true })

-- bufferline
map('n', ']b', cmd('BufferLineCycleNext'), silenced)
map('n', '[b', cmd('BufferLineCyclePrev'), silenced)
map('n', '<leader>bf', cmd('BufferLinePick'), silenced)
map('n', '<leader>bd', cmd('BufferLinePickClose'), silenced)
map('n', '<leader>1', cmd('BufferLineGoToBuffer 1'), silenced)
map('n', '<leader>2', cmd('BufferLineGoToBuffer 2'), silenced)
map('n', '<leader>3', cmd('BufferLineGoToBuffer 3'), silenced)
map('n', '<leader>4', cmd('BufferLineGoToBuffer 4'), silenced)
map('n', '<leader>5', cmd('BufferLineGoToBuffer 5'), silenced)
map('n', '<leader>6', cmd('BufferLineGoToBuffer 6'), silenced)
map('n', '<leader>7', cmd('BufferLineGoToBuffer 7'), silenced)
map('n', '<leader>8', cmd('BufferLineGoToBuffer 8'), silenced)
map('n', '<leader>9', cmd('BufferLineGoToBuffer 9'), silenced)

-- file explorer
map('n', '<leader>e', cmd('NvimTreeToggle'), silenced)

-- terminal
map('n', '<leader>t', cmd('ToggleTerm direction=float'), silenced)
map('t', '<esc>', [[<C-\><C-n>]], silenced)

-- taskrunner
map('n', '<leader>rt', cmd('OverseerRun'), silenced)

-- undotree
map('n', '<leader>u', cmd('UndotreeToggle'), silenced)

-- lsp
map('n', 'gD', cmd('lua vim.lsp.buf.declaration()'), silenced)
map('n', 'gd', cmd('Telescope lsp_definitions'), silenced)
map('n', 'gi', cmd('Telescope lsp_implementations'), silenced)
map('n', 'gr', cmd('Telescope lsp_references'), silenced)
map('n', ']d', cmd('lua vim.diagnostic.goto_next()', 'zzzv'), silenced)
map('n', '[d', cmd('lua vim.diagnostic.goto_prev()', 'zzzv'), silenced)
map('n', 'K', cmd('lua vim.lsp.buf.hover()'), silenced)
map('n', '<C-k>', cmd('lua vim.lsp.buf.signature_help()'), silenced)
map('n', '<leader>rn', cmd('lua vim.lsp.buf.rename()'), silenced)
map('n', '<leader>ca', cmd('lua vim.lsp.buf.code_action()'), silenced)
map('n', '<C-f>', cmd('lua vim.lsp.buf.format({ async = true })'), silenced)
