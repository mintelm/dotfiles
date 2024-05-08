local utils = require('utils')

local M = {}
_G.Status = M

---@return {name:string, text:string, texthl:string}[]
function M.get_signs()
    local buf = vim.api.nvim_win_get_buf(vim.g.statusline_winid)

    return vim.tbl_map(
        function(sign)
            return vim.fn.sign_getdefined(sign.name)[1]
        end,
        vim.fn.sign_getplaced(buf, { group = '*', lnum = vim.v.lnum })[1].signs)
end

function M.column()
    local sign, git_sign
    for _, s in ipairs(M.get_signs()) do
        if s.name:find('GitSign') then
            git_sign = s
        else
            sign = s
        end
    end
    local grey_delimiter = '%#IblIndent#▎%*'
    local components = {
        git_sign and ('%#' .. git_sign.texthl .. '#▎%*') or grey_delimiter,
        sign and ('%#' .. sign.texthl .. '#' .. sign.text .. '%*') or '  ',
        '%-4.4{&nu ? v:lnum : ""} %=%2.2{&rnu ? v:relnum : ""}',
        ' ' .. grey_delimiter,
    }

    return table.concat(components, '')
end

utils.augroup('StatusColumn', {
    {
        event = { 'BufEnter', 'WinEnter' },
        pattern = { '*' },
        command = function()
            if vim.bo.buftype == '' and vim.bo.modifiable then
                vim.wo.statuscolumn = '%!v:lua.Status.column()'
            else
                vim.wo.statuscolumn = ''
            end
        end,
    },
})
