local utils = require('utils')

local cmd = vim.cmd

local tab_width = 4
local c_tab_width = 8

cmd('syntax enable')
cmd('filetype plugin indent on')
cmd('autocmd TextYankPost * lua vim.highlight.on_yank { on_visual = false, timeout = 250 }')
-- toggle hiding invisible chars on insert
cmd('autocmd InsertEnter * lua vim.wo.list = false')
cmd('autocmd InsertLeave * lua vim.wo.list = true')
cmd('autocmd FileType c,cpp,objc,objcpp,sh,make lua require("utils").set_tab_width(' .. c_tab_width .. ')')

utils.set_tab_width(tab_width)
utils.opt('b', 'expandtab', true)
utils.opt('b', 'smartindent', true)

utils.opt('o', 'title', true)
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
