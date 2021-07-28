return function()
    vim.cmd('autocmd BufEnter * lua require"completion".on_attach()')
    vim.cmd('set shortmess+=c')

    mm.opt('o', 'completeopt', 'menuone,noinsert,noselect')

    vim.g.completion_confirm_key = ''
    vim.g.completion_matching_strategy_list = { 'exact', 'substring', 'fuzzy' }
    vim.g.completion_matching_smart_case = 1
    vim.g.completion_enable_auto_popup = 0
end
