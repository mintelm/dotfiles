local utils = require('utils')

vim.g.mapleader = ','

-- unmap
utils.map('', '<C-b>', '')
utils.map('', '<C-f>', '')

-- navigation
utils.map('', '[q', ':cprev<CR>')
utils.map('', ']q', ':cnext<CR>')
utils.map('', '[Q', ':cfirst<CR>')
utils.map('', ']Q', ':clast<CR>')

-- clear highlight on space
utils.map('n', '<Space>', '<cmd>noh<CR>', {silent=true})

-- telescope
utils.map('n', '<leader>f', '<cmd>Telescope find_files<CR>')
utils.map('n', '<leader>b', '<cmd>Telescope buffers<CR>')
utils.map('n', '<leader>gf', '<cmd>Telescope git_files<CR>')
utils.map('n', '<leader>gr', '<cmd>Telescope live_grep<CR>')

-- lsp
local silenced = {silent=true}
utils.map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
utils.map('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
utils.map('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')
utils.map('n', 'rn', '<cmd>lua vim.lsp.buf.rename()<CR>')
utils.map('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', silenced)
utils.map('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', silenced)
utils.map('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')
utils.map('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', silenced)

-- completion
utils.map('i', '<C-Space>', '<cmd>lua require\'completion\'.triggerCompletion()<CR>')
utils.map('i', '<S-Tab>', 'pumvisible() ? "\\<C-p>" : "\\<Tab>"', {expr = true})
utils.map('i', '<Tab>', 'pumvisible() ? "\\<C-n>" : "\\<Tab>"', {expr = true})
