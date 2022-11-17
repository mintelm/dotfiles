local M = { }

local silenced = { silent = true }
local cmd = function(command)
    return table.concat({ '<cmd>', command, '<CR>' })
end

vim.g.mapleader = ','

-- unmap
mm.map('', '<C-b>', '', {})
mm.map('', '<C-f>', '', {})

-- navigation
mm.map('', ']q', ':cnext', {})
mm.map('', '[q', ':cprev', {})
mm.map('', ']Q', ':clast', {})
mm.map('', '[Q', ':cfirst', {})

-- clear highlight on space
mm.map('n', '<Space>', cmd('noh'), silenced)

-- bufferline
mm.map('n', ']b', cmd('BufferLineCycleNext'), silenced)
mm.map('n', '[b', cmd('BufferLineCyclePrev'), silenced)
mm.map('n', '<leader>bf', (cmd 'BufferLinePick'), silenced)
mm.map('n', '<leader>bd', cmd('BufferLinePickClose'), silenced)
mm.map('n', '<leader>1', cmd('BufferLineGoToBuffer 1'), silenced)
mm.map('n', '<leader>2', cmd('BufferLineGoToBuffer 2'), silenced)
mm.map('n', '<leader>3', cmd('BufferLineGoToBuffer 3'), silenced)
mm.map('n', '<leader>4', cmd('BufferLineGoToBuffer 4'), silenced)
mm.map('n', '<leader>5', cmd('BufferLineGoToBuffer 5'), silenced)
mm.map('n', '<leader>6', cmd('BufferLineGoToBuffer 6'), silenced)
mm.map('n', '<leader>7', cmd('BufferLineGoToBuffer 7'), silenced)
mm.map('n', '<leader>8', cmd('BufferLineGoToBuffer 8'), silenced)
mm.map('n', '<leader>9', cmd('BufferLineGoToBuffer 9'), silenced)

-- hop
mm.map('n', 's', cmd('HopChar2AC'), silenced)
mm.map('n', 'S', cmd('HopChar2BC'), silenced)
-- not dot repeatable yet ...
-- mm.map('', 'f', cmd 'lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })', {})
-- mm.map('', 'F', cmd 'lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })', {})
-- mm.map('', 't', cmd 'lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })', {})
-- mm.map('', 'T', cmd 'lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })', {})

-- lsp
-- this function is passed to lsp's on_attach hook, so mappings are only loaded if lsp is
function M.lsp_mappings(bufnr)
    local function buf_set_keymap(...) mm.bmap(bufnr, ...) end

    -- most common lsp functions
    buf_set_keymap('n', 'gD', cmd('lua vim.lsp.buf.declaration()'), silenced)
    buf_set_keymap('n', 'gd', cmd('Telescope lsp_definitions theme=ivy'), silenced)
    buf_set_keymap('n', 'gi', cmd('Telescope lsp_implementations theme=ivy'), silenced)
    buf_set_keymap('n', 'gr', cmd('Telescope lsp_references theme=ivy'), silenced)
    buf_set_keymap('n', ']d', cmd('lua vim.diagnostic.goto_next()'), silenced)
    buf_set_keymap('n', '[d', cmd('lua vim.diagnostic.goto_prev()'), silenced)
    buf_set_keymap('n', 'K', cmd('lua vim.lsp.buf.hover()'), silenced)
    buf_set_keymap('n', '<C-k>', cmd('lua vim.lsp.buf.signature_help()'), silenced)
    buf_set_keymap('n', '<leader>rn', cmd('lua vim.lsp.buf.rename()'), silenced)
    buf_set_keymap('n', '<leader>ca', cmd('lua vim.lsp.buf.code_action()'), silenced)
end

return M
