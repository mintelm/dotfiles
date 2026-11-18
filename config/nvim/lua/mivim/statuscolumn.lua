local M = {}

local hidden_filetypes = { 'Neogit' }
local default_hl = 'LineNr'

-- everything after the sign only depends on the width of the line number column
local tails = {}

--- @param width integer
--- @return string
local function get_tail(width)
    if not tails[width] then
        tails[width] = table.concat({
            -- line number
            string.format('%%-%d.%d{&nu&&v:virtnum==0 ? v:lnum : ""} ', width, width),
            -- relative line number
            '%=%2.2{&rnu&&v:virtnum==0&&v:relnum<100 ? v:relnum : ""} ',
            -- separator
            string.format('%%#%s#▎%%*', default_hl),
        })
    end

    return tails[width]
end

--- @return string
function M.get_statuscol_string()
    -- '%!' is evaluated in the context of the current window, the window being drawn is g:statusline_winid
    local buf = vim.api.nvim_win_get_buf(vim.g.statusline_winid)
    local row = vim.v.lnum - 1 -- have to compensate with -1 because extmarks row starts from 0
    local git_hl, sign_hl, sign_text, max_priority = default_hl, default_hl, ' ', 0

    -- extmarks is a list of [extmark_id, row, col, details]
    local extmarks = vim.api.nvim_buf_get_extmarks(buf, -1, { row, 0 }, { row, -1 }, { details = true, type = 'sign' })
    for _, extmark in ipairs(extmarks) do
        local details = extmark[4]
        local hl = details.sign_hl_group

        if hl then
            if hl:find('GitSign') then
                git_hl = hl
            elseif (details.priority or 0) > max_priority then
                -- highest priority sign wins
                sign_hl, sign_text, max_priority = hl, details.sign_text or ' ', details.priority
            end
        end
    end

    -- at least 4 digits wide, grows for buffers with 10000+ lines
    local width = math.max(4, #tostring(vim.api.nvim_buf_line_count(buf)))

    return string.format('%%#%s#▎%%*%%#%s#%%-2.2{"%s"}%%*', git_hl, sign_hl, sign_text) .. get_tail(width)
end

vim.o.statuscolumn = '%!v:lua.require("mivim.statuscolumn").get_statuscol_string()'

vim.api.nvim_create_autocmd({ 'BufWinEnter', 'BufModifiedSet', 'FileType' }, {
    group = mivim.utils.augroup('statuscolumn'),
    callback = function()
        local filetype = vim.bo.filetype
        local is_hidden_filetype = vim.iter(hidden_filetypes):any(function(ft)
            return filetype:find(ft) ~= nil
        end)

        if vim.bo.buftype ~= '' or not vim.bo.modifiable or is_hidden_filetype then
            -- [0][0] acts like :setlocal, so the window gets its numbers back once it shows a regular buffer again
            local wo = vim.wo[0][0]
            wo.statuscolumn = ''
            wo.number = false
            wo.relativenumber = false
        end
    end,
})

return M
