local utils = require('utils')

local M = {}
_G.statuscolumn = M

---@return {name:string, text:string, texthl:string}[]
function M.get_signs()
    local buf = vim.api.nvim_win_get_buf(vim.g.statusline_winid)

    return vim.tbl_map(
        function(sign)
            return vim.fn.sign_getdefined(sign.name)[1]
        end,
        vim.fn.sign_getplaced(buf, { group = '*', lnum = vim.v.lnum })[1].signs)
end

function M.active()
    local sign, git_sign
    for _, s in ipairs(M.get_signs()) do
        if s.name:find('GitSign') then
            git_sign = s
        else
            sign = s
        end
    end
    local default_hl = 'IblIndent'
    local git_column = string.format('%%#%s#▎%%*', git_sign and git_sign.texthl or default_hl)
    local sign_column = string.format('%%#%s#%%-2.2{"%s"}%%*', sign and sign.texthl or default_hl, sign and sign.text or ' ')
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
