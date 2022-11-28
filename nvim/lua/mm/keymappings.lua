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
mm.map('n', 'gD', cmd('lua vim.lsp.buf.declaration()'), silenced)
mm.map('n', 'gd', cmd('Telescope lsp_definitions theme=ivy'), silenced)
mm.map('n', 'gi', cmd('Telescope lsp_implementations theme=ivy'), silenced)
mm.map('n', 'gr', cmd('Telescope lsp_references theme=ivy'), silenced)
mm.map('n', ']d', cmd('lua vim.diagnostic.goto_next()'), silenced)
mm.map('n', '[d', cmd('lua vim.diagnostic.goto_prev()'), silenced)
mm.map('n', 'K', cmd('lua vim.lsp.buf.hover()'), silenced)
mm.map('n', '<C-k>', cmd('lua vim.lsp.buf.signature_help()'), silenced)
mm.map('n', '<leader>rn', cmd('lua vim.lsp.buf.rename()'), silenced)
mm.map('n', '<leader>ca', cmd('lua vim.lsp.buf.code_action()'), silenced)
mm.map('n', '<C-f>', cmd('lua vim.lsp.buf.format({ async = true })'), silenced)
