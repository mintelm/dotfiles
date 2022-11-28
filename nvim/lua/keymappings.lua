local map = require('utils').map

local silenced = { silent = true }
local cmd = function(command)
    return table.concat({ '<cmd>', command, '<CR>' })
end

vim.g.mapleader = ','

-- unmap
map('', '<C-b>', '', {})
map('', '<C-f>', '', {})

-- navigation
map('', ']q', ':cnext', {})
map('', '[q', ':cprev', {})
map('', ']Q', ':clast', {})
map('', '[Q', ':cfirst', {})

-- clear highlight on space
map('n', '<Space>', cmd('noh'), silenced)

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

-- hop
map('n', 's', cmd('HopChar2AC'), silenced)
map('n', 'S', cmd('HopChar2BC'), silenced)
-- not dot repeatable yet ...
-- map('', 'f', cmd 'lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })', {})
-- map('', 'F', cmd 'lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })', {})
-- map('', 't', cmd 'lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })', {})
-- map('', 'T', cmd 'lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })', {})

-- lsp
map('n', 'gD', cmd('lua vim.lsp.buf.declaration()'), silenced)
map('n', 'gd', cmd('Telescope lsp_definitions theme=ivy'), silenced)
map('n', 'gi', cmd('Telescope lsp_implementations theme=ivy'), silenced)
map('n', 'gr', cmd('Telescope lsp_references theme=ivy'), silenced)
map('n', ']d', cmd('lua vim.diagnostic.goto_next()'), silenced)
map('n', '[d', cmd('lua vim.diagnostic.goto_prev()'), silenced)
map('n', 'K', cmd('lua vim.lsp.buf.hover()'), silenced)
map('n', '<C-k>', cmd('lua vim.lsp.buf.signature_help()'), silenced)
map('n', '<leader>rn', cmd('lua vim.lsp.buf.rename()'), silenced)
map('n', '<leader>ca', cmd('lua vim.lsp.buf.code_action()'), silenced)
map('n', '<C-f>', cmd('lua vim.lsp.buf.format({ async = true })'), silenced)
