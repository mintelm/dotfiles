local map = require('utils').map
local unmap = require('utils').unmap
local cmd = require('utils').cmd

vim.g.mapleader = ','

-- unmap
unmap('', '<C-w>d', {})
unmap('', '<C-w><C-d>', {})

-- navigation
map('', ']q', cmd('cnext', 'zzzv'))
map('', '[q', cmd('cprev', 'zzzv'))
map('', ']Q', cmd('clast', 'zzzv'))
map('', '[Q', cmd('cfirst', 'zzzv'))
map('', ']t', cmd('tabnext'))
map('', '[t', cmd('tabprev'))
map('', ']T', cmd('tablast'))
map('', '[T', cmd('tabfirst'))

-- clear highlight on space
map('n', '<Space>', cmd('noh'))

-- fancy remaps
map('v', 'K', [[:m '<-2<CR>gv=gv]])
map('v', 'J', [[:m '>+1<CR>gv=gv]])
map('n', 'J', 'mzJ`z')
map('n', '<C-d>', '<C-d>zz')
map('n', '<C-u>', '<C-u>zz')
map('n', 'n', 'nzzzv')
map('n', 'N', 'Nzzzv')
map({ 'n', 'v' }, '<leader>y', [["+y]])
map({ 'n', 'v' }, '<leader>Y', [["+Y]])
map('n', 'Q', '<nop>')
map('c', '<enter>',
    function()
        local cmdtype = vim.fn.getcmdtype()
        if cmdtype == '/' or cmdtype == '?' then
            return '<CR>zzzv'
        end
        return '<CR>'
    end,
    { expr = true, silent = true })

-- lsp
map('n', 'gD', cmd('lua vim.lsp.buf.declaration()'))
map('n', ']d', cmd('lua vim.diagnostic.goto_next()', 'zzzv'))
map('n', '[d', cmd('lua vim.diagnostic.goto_prev()', 'zzzv'))
map('n', '<leader>rn', cmd('lua vim.lsp.buf.rename()'))
map('n', '<leader>ca', cmd('lua vim.lsp.buf.code_action()'))
map('n', '<C-f>', cmd('lua vim.lsp.buf.format({ async = true })'))

-- most of plugin related keymaps are either defined in 'plugins/hydra.lua' or in the respective plugin spec
