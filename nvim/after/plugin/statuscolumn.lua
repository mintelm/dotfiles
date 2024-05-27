local utils = require('utils')

local M = {}
_G.statuscolumn = M

---@return {lnum:number, sign_text:string, sign_hl_group:string}[]
function M.get_signs_in_extmarks()
    return vim.tbl_map(
        function(extmark)
            -- extmarks is a list of [extmark_id, row, col, details]
            return {
                lnum = extmark[2] + 1, -- have to compensate with +1 because extmarks row starts from 0
                sign_text = extmark[4].sign_text,
                sign_hl_group = extmark[4].sign_hl_group
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

function M.active()
    local sign, git_sign
    for _, s in ipairs(M.get_signs_in_extmarks()) do
        if s.sign_hl_group:find('GitSign') then
            git_sign = s
        else
            sign = s
        end
    end
    local default_hl = 'IblIndent'
    local git_column = string.format('%%#%s#▎%%*', git_sign and git_sign.sign_hl_group or default_hl)
    local sign_column = string.format('%%#%s#%%-2.2{"%s"}%%*', sign and sign.sign_hl_group or default_hl, sign and sign.sign_text or ' ')
    local line_column = '%-4.4{&nu&&v:virtnum==0 ? v:lnum : ""} %=%2.2{&rnu&&v:virtnum==0 ? v:relnum : ""} '
    local end_column = string.format('%%#%s#▎%%*', default_hl)

    local components = {
        git_column,
        sign_column,
        line_column,
        end_column,
    }

    return table.concat(components)
end

utils.augroup('StatusColumn', {
    {
        event = { 'BufWinEnter', 'BufModifiedSet', 'FileType' },
        pattern = { '*' },
        command = function()
            if vim.bo.buftype == '' and vim.bo.modifiable and not string.find(vim.bo.filetype, 'Neogit') then
                vim.wo.statuscolumn = '%!v:lua.statuscolumn.active()'
            else
                vim.wo.statuscolumn = ''
            end
        end,
    },
})
