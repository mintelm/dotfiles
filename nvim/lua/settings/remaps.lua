local map = require('utils').map
local unmap = require('utils').unmap
local cmd = require('utils').cmd

vim.g.mapleader = ','

-- unmap
unmap('', '<C-w>d', {})
unmap('', '<C-w><C-d>', {})

-- navigation
map('', ']q', cmd('cnext', 'zz'))
map('', '[q', cmd('cprev', 'zz'))
map('', ']Q', cmd('clast', 'zz'))
map('', '[Q', cmd('cfirst', 'zz'))
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
map('n', 'n', 'nzz')
map('n', 'N', 'Nzz')
map({ 'n', 'v' }, '<leader>y', [["+y]])
map({ 'n', 'v' }, '<leader>Y', [["+Y]])
map('n', 'Q', '<nop>')
map('c', '<enter>',
    function()
        local cmdtype = vim.fn.getcmdtype()
        if cmdtype == '/' or cmdtype == '?' then
            return '<CR>zz'
        end
        return '<CR>'
    end,
    { expr = true, silent = true })

-- lsp
map('n', 'gD', cmd('lua vim.lsp.buf.declaration()'), { desc = 'Go To Declarations' })
map('n', ']d', cmd('lua vim.diagnostic.goto_next()', 'zz'), { desc = 'Next Diagnostic' })
map('n', '[d', cmd('lua vim.diagnostic.goto_prev()', 'zz'), { desc = 'Previous Diagnostic' })
map('n', '<leader>rn', cmd('lua vim.lsp.buf.rename()'), { desc = 'Rename Symbol' })
map('n', '<leader>ca', cmd('lua vim.lsp.buf.code_action()'), { desc = 'Code Action' })
map('n', '<C-f>', cmd('lua vim.lsp.buf.format({ async = true })'), { desc = 'Format Buffer' })
