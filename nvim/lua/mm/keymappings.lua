local utils = require('mm.utils')

local silenced = { silent = true }

vim.g.mapleader = ','

-- unmap
utils.map('', '<C-b>', '')
utils.map('', '<C-f>', '')

-- navigation
utils.map('', ']q', ':cnext<CR>')
utils.map('', '[q', ':cprev<CR>')
utils.map('', ']Q', ':clast<CR>')
utils.map('', '[Q', ':cfirst<CR>')

-- clear highlight on space
utils.map('n', '<Space>', '<cmd>noh<CR>', silenced)

-- telescope
utils.map('n', '<leader>f', '<cmd>Telescope find_files<CR>')
utils.map('n', '<leader>gf', '<cmd>Telescope git_files<CR>')
utils.map('n', '<leader>gr', '<cmd>Telescope live_grep<CR>')

-- lsp
utils.map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
utils.map('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
utils.map('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')
utils.map('n', 'rn', '<cmd>lua vim.lsp.buf.rename()<CR>')
utils.map('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next({ popup_opts = { border = "single" }})<CR>', silenced)
utils.map('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev({ popup_opts = { border = "single" }})<CR>', silenced)
utils.map('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')
utils.map('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help({ popup_opts = { border = "single" }})<CR>', silenced)

-- completion
utils.map('i', '<C-Space>', '<cmd>lua require"completion".triggerCompletion()<CR>')
utils.map('i', '<S-Tab>', 'pumvisible() ? "\\<C-p>" : "\\<Tab>"', { expr = true })
utils.map('i', '<Tab>', 'pumvisible() ? "\\<C-n>" : "\\<Tab>"', { expr = true })

-- bufferline
utils.map('n', ']b', '<cmd>BufferLineCycleNext<CR>', silenced)
utils.map('n', '[b', '<cmd>BufferLineCyclePrev<CR>', silenced)
utils.map('n', '<leader>bf', '<cmd>BufferLinePick<CR>', silenced)
utils.map('n', '<leader>bd', '<cmd>BufferLinePickClose<CR>', silenced)

-- gitsigns
utils.map('n', '<leader>hv', '<cmd>lua require"gitsigns".preview_hunk()<CR>')
utils.map('n', '<leader>ha', '<cmd>lua require"gitsigns".stage_hunk()<CR>')
utils.map('n', '<leader>hu', '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>')
utils.map('n', '<leader>hr', '<cmd>lua require"gitsigns".reset_hunk()<CR>')
utils.map('n', ']h', '<cmd>lua require"gitsigns".next_hunk()<CR>')
utils.map('n', '[h', '<cmd>lua require"gitsigns".prev_hunk()<CR>')

-- neogit
utils.map('n', '<leader>gs', '<cmd>lua require"neogit".open()<CR>')
