local utils = require('utils')

local cmd = vim.cmd
local indent = 4

cmd('syntax enable')
cmd('filetype plugin indent on')
cmd('au TextYankPost * lua vim.highlight.on_yank { on_visual = false, timeout = 250 }')
cmd('autocmd InsertEnter * lua vim.wo.list = false')
cmd('autocmd InsertLeave * lua vim.wo.list = true')

utils.opt('b', 'tabstop', indent)
utils.opt('b', 'expandtab', true)
utils.opt('b', 'smartindent', true)
utils.opt('b', 'shiftwidth', indent)

utils.opt('o', 'termguicolors', true)
utils.opt('o', 'shiftround', true)
utils.opt('o', 'hidden', true)
utils.opt('o', 'ignorecase', true)
utils.opt('o', 'smartcase', true)
utils.opt('o', 'scrolloff', 4 )
utils.opt('o', 'mouse', 'a')
utils.opt('o', 'clipboard','unnamed,unnamedplus')

utils.opt('w', 'number', true)
utils.opt('w', 'relativenumber', true)
utils.opt('w', 'signcolumn', 'yes:2')
utils.opt('w', 'list', true)
utils.opt('w', 'listchars', 'eol: ,tab:│ ,extends:»,precedes:«,trail:•')
