-- setup statuscolumn
vim.api.nvim_create_autocmd({ 'BufWinEnter', 'BufModifiedSet', 'FileType' }, {
    group = mivim.utils.augroup('statuscolumn'),
    callback = function()
        if vim.bo.buftype == '' and vim.bo.modifiable and not string.find(vim.bo.filetype, 'Neogit') then
            vim.wo.statuscolumn = '%!v:lua.mivim.statuscolumn.show()'
        else
            vim.wo.statuscolumn = ''
        end
    end,
})

-- highlight yank for 250ms
vim.api.nvim_create_autocmd('TextYankPost', {
    group = mivim.utils.augroup('highlight_yank'),
    callback = function()
        vim.highlight.on_yank({ on_visual = false, timeout = 250 })
    end,
})

-- toggle hiding invisible chars on insert
local toggle_group = mivim.utils.augroup('toggle_invisible_chars', false)
vim.api.nvim_create_autocmd({ 'WinLeave', 'BufLeave', 'InsertEnter' }, {
    group = toggle_group,
    callback = function()
        vim.o.list = false
    end,
})
vim.api.nvim_create_autocmd({ 'WinEnter', 'BufEnter', 'InsertLeave' }, {
    group = toggle_group,
    callback = function()
        vim.o.list = true
    end,
})
