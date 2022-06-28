local M = { }

local silenced = { silent = true }

vim.g.mapleader = ','

-- unmap
mm.map('', '<C-b>', '', {})
mm.map('', '<C-f>', '', {})

-- navigation
mm.map('', ']q', ':cnext<CR>', {})
mm.map('', '[q', ':cprev<CR>', {})
mm.map('', ']Q', ':clast<CR>', {})
mm.map('', '[Q', ':cfirst<CR>', {})

-- clear highlight on space
mm.map('n', '<Space>', '<cmd>noh<CR>', silenced)

-- telescope
mm.map('n', '<leader>f', '<cmd>Telescope find_files<CR>', {})
mm.map('n', '<leader>gf', '<cmd>Telescope git_files<CR>', {})
mm.map('n', '<leader>gr', '<cmd>Telescope live_grep<CR>', {})

-- bufferline
mm.map('n', ']b', '<cmd>BufferLineCycleNext<CR>', silenced)
mm.map('n', '[b', '<cmd>BufferLineCyclePrev<CR>', silenced)
mm.map('n', '<leader>bf', '<cmd>BufferLinePick<CR>', silenced)
mm.map('n', '<leader>bd', '<cmd>BufferLinePickClose<CR>', silenced)
mm.map('n', '<leader>1', '<cmd>BufferLineGoToBuffer 1<CR>', silenced)
mm.map('n', '<leader>2', '<cmd>BufferLineGoToBuffer 2<CR>', silenced)
mm.map('n', '<leader>3', '<cmd>BufferLineGoToBuffer 3<CR>', silenced)
mm.map('n', '<leader>4', '<cmd>BufferLineGoToBuffer 4<CR>', silenced)
mm.map('n', '<leader>5', '<cmd>BufferLineGoToBuffer 5<CR>', silenced)
mm.map('n', '<leader>6', '<cmd>BufferLineGoToBuffer 6<CR>', silenced)
mm.map('n', '<leader>7', '<cmd>BufferLineGoToBuffer 7<CR>', silenced)
mm.map('n', '<leader>8', '<cmd>BufferLineGoToBuffer 8<CR>', silenced)
mm.map('n', '<leader>9', '<cmd>BufferLineGoToBuffer 9<CR>', silenced)

-- lsp
-- this function is passed to lsp's on_attach hook, so mappings are only loaded if lsp is
function M.lsp_mappings(bufnr)
    local function buf_set_keymap(...) mm.bmap(bufnr, ...) end

    -- most common lsp functions
    buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', silenced)
    buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', silenced)
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', silenced)
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', silenced)
    buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', silenced)
    buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', silenced)
    buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', silenced)
    buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', silenced)
    buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', silenced)
    buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', silenced)
end

return M
