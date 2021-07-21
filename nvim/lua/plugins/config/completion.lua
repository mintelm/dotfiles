return function()
    local utils = require('utils')

    vim.cmd("autocmd BufEnter * lua require'completion'.on_attach()")
    vim.cmd([[set shortmess+=c]])

    utils.opt('o', 'completeopt', 'menuone,noinsert,noselect')

    vim.g.completion_confirm_key = ""
    vim.g.completion_matching_strategy_list = { 'exact', 'substring', 'fuzzy' }
    vim.g.completion_enable_auto_popup = 0
end
