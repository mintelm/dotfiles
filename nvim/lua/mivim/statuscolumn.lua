local M = {}

local hidden_filetypes = { 'gitcommit', 'help' }
local default_hl = 'IblIndent'

--- @return {lnum:number, sign_text:string, sign_hl_group:string, priority:number}[]
local function get_signs_in_extmarks()
    return vim.tbl_map(
        function(extmark)
            -- extmarks is a list of [extmark_id, row, col, details]
            return {
                lnum = extmark[2] + 1, -- have to compensate with +1 because extmarks row starts from 0
                sign_text = extmark[4].sign_text,
                sign_hl_group = extmark[4].sign_hl_group,
                priority = extmark[4].priority or 0,
            }
        end,
        vim.api.nvim_buf_get_extmarks(
            0,
            -1,
            { vim.v.lnum - 1, 0 },  -- have to compensate with -1 because extmarks row start from 0
            { vim.v.lnum - 1, -1 }, -- have to compensate with -1 because extmarks row start from 0
            { details = true, type = 'sign' }
        ))
end

--- @return string
local function git_column()
    local sign

    -- find git sign
    for _, s in ipairs(get_signs_in_extmarks()) do
        if s.sign_hl_group and s.sign_hl_group:find('GitSign') then
            sign = s
        end
    end

    return string.format('%%#%s#▎%%*', sign and sign.sign_hl_group or default_hl)
end

--- @return string
local function sign_column()
    local sign
    local current_max_priority = 0

    -- find highest priority sign
    for _, s in ipairs(get_signs_in_extmarks()) do
        if s.sign_hl_group and not s.sign_hl_group:find('GitSign') and s.priority > current_max_priority then
            sign = s
            current_max_priority = s.priority
        end
    end

    return string.format('%%#%s#%%-2.2{"%s"}%%*', sign and sign.sign_hl_group or default_hl, sign and sign.sign_text or ' ')
end

--- @return string
local function line_column()
    return '%-4.4{&nu&&v:virtnum==0 ? v:lnum : ""} '
end

--- @return string
local function rel_column()
    return '%=%2.2{&rnu&&v:virtnum==0&&v:relnum<100 ? v:relnum : ""} '
end

--- @return string
local function end_column()
    return string.format('%%#%s#▎%%*', default_hl)
end

--- @return string
function M.get_statuscol_string()
    return table.concat({
        git_column(),
        sign_column(),
        line_column(),
        rel_column(),
        end_column(),
    })
end

vim.wo.statuscolumn = '%!v:lua.require("mivim.statuscolumn").get_statuscol_string()'

vim.api.nvim_create_autocmd('FileType', {
    group = mivim.utils.augroup('statuscolumn_hidden_ft'),
    pattern = hidden_filetypes,
    callback = function()
        vim.wo.number = false
        vim.wo.relativenumber = false
        vim.wo.signcolumn = 'no'
        vim.wo.statuscolumn = ''
    end
})
vim.api.nvim_create_autocmd('BufModifiedSet', {
    group = mivim.utils.augroup('statuscolumn_hidden_bt'),
    callback = function()
        if not vim.bo.modifiable or vim.bo.buftype ~= '' then
            vim.wo.number = false
            vim.wo.relativenumber = false
            vim.wo.signcolumn = 'no'
            vim.wo.statuscolumn = ''
        end
    end
})

return M
