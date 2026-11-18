local map = mivim.utils.map
local cmd = mivim.utils.cmd

vim.g.mapleader = ','

-- unmap
vim.keymap.del('', '<C-w>d')
vim.keymap.del('', '<C-w><C-d>')

-- navigation
-- ('' and 'v' would include select mode, where mappings hijack typing over snippet placeholders)
local nxo = { 'n', 'x', 'o' }
map(nxo, ']q', cmd('cnext', 'zz'))
map(nxo, '[q', cmd('cprev', 'zz'))
map(nxo, ']Q', cmd('clast', 'zz'))
map(nxo, '[Q', cmd('cfirst', 'zz'))
map(nxo, ']t', cmd('tabnext'))
map(nxo, '[t', cmd('tabprev'))
map(nxo, ']T', cmd('tablast'))
map(nxo, '[T', cmd('tabfirst'))

-- clear highlight on space
map('n', '<Space>', cmd('noh'))

-- fancy remaps
map('x', 'K', [[:m '<-2<CR>gv=gv]])
map('x', 'J', [[:m '>+1<CR>gv=gv]])
map('n', 'J', 'mzJ`z')
map('n', '<C-d>', '<C-d>zz')
map('n', '<C-u>', '<C-u>zz')
map('n', 'n', 'nzz')
map('n', 'N', 'Nzz')
map({ 'n', 'x' }, '<leader>y', [["+y]])
map({ 'n', 'x' }, '<leader>Y', [["+Y]])
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
map('n', ']d', cmd('lua vim.diagnostic.jump({ count = 1 })', 'zz'), { desc = 'Next Diagnostic' })
map('n', '[d', cmd('lua vim.diagnostic.jump({ count = -1 })', 'zz'), { desc = 'Previous Diagnostic' })
map('n', '<leader>rn', cmd('lua vim.lsp.buf.rename()'), { desc = 'Rename Symbol' })
map('n', '<leader>ca', cmd('lua vim.lsp.buf.code_action()'), { desc = 'Code Action' })
map('n', '<C-f>', cmd('lua vim.lsp.buf.format({ async = true })'), { desc = 'Format Buffer' })
