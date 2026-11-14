local opt = vim.opt_local
local api = vim.api
local fn = vim.fn

opt.buflisted = false
opt.winfixheight = true
opt.signcolumn = 'yes'

api.nvim_win_set_height(0, math.max(math.min(fn.line('$'), 15), 10))
