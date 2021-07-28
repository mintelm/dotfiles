local silenced = { silent = true }

vim.g.mapleader = ','

-- unmap
mm.map('', '<C-b>', '')
mm.map('', '<C-f>', '')

-- navigation
mm.map('', ']q', ':cnext<CR>')
mm.map('', '[q', ':cprev<CR>')
mm.map('', ']Q', ':clast<CR>')
mm.map('', '[Q', ':cfirst<CR>')

-- clear highlight on space
mm.map('n', '<Space>', '<cmd>noh<CR>', silenced)

-- telescope
mm.map('n', '<leader>f', '<cmd>Telescope find_files<CR>')
mm.map('n', '<leader>gf', '<cmd>Telescope git_files<CR>')
mm.map('n', '<leader>gr', '<cmd>Telescope live_grep<CR>')

-- lsp
mm.map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
mm.map('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
mm.map('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')
mm.map('n', 'rn', '<cmd>lua vim.lsp.buf.rename()<CR>')
mm.map('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next({ popup_opts = { border = "single" }})<CR>', silenced)
mm.map('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev({ popup_opts = { border = "single" }})<CR>', silenced)
mm.map('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')
mm.map('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help({ popup_opts = { border = "single" }})<CR>', silenced)
mm.map('n', '<leader>qf', '<cmd>lua vim.lsp.buf.code_action()<CR>')

-- completion
mm.map('i', '<C-Space>', '<cmd>lua require"completion".triggerCompletion()<CR>')
mm.map('i', '<S-Tab>', 'pumvisible() ? "\\<C-p>" : "\\<Tab>"', { expr = true })
mm.map('i', '<Tab>', 'pumvisible() ? "\\<C-n>" : "\\<Tab>"', { expr = true })

-- bufferline
mm.map('n', ']b', '<cmd>BufferLineCycleNext<CR>', silenced)
mm.map('n', '[b', '<cmd>BufferLineCyclePrev<CR>', silenced)
mm.map('n', '<leader>bf', '<cmd>BufferLinePick<CR>', silenced)
mm.map('n', '<leader>bd', '<cmd>BufferLinePickClose<CR>', silenced)

-- gitsigns
mm.map('n', '<leader>hv', '<cmd>lua require"gitsigns".preview_hunk()<CR>')
mm.map('n', '<leader>ha', '<cmd>lua require"gitsigns".stage_hunk()<CR>')
mm.map('n', '<leader>hu', '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>')
mm.map('n', '<leader>hr', '<cmd>lua require"gitsigns".reset_hunk()<CR>')
mm.map('n', ']h', '<cmd>lua require"gitsigns".next_hunk()<CR>')
mm.map('n', '[h', '<cmd>lua require"gitsigns".prev_hunk()<CR>')

-- neogit
mm.map('n', '<leader>gs', '<cmd>lua require"neogit".open()<CR>')
