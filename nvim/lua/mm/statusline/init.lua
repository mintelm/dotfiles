-- Resources
-- 1. https://github.com/akinsho/dotfiles/blob/main/.config/nvim/lua/as/statusline/init.lua
-- 2. https://github.com/ahmedelgabri/dotfiles/blob/acf6dc587f6b76024fad32391655fa910fc1ae3e/config/.vim/lua/_/statusline.lua
-- 3. https://github.com/elenapan/dotfiles/blob/master/config/nvim/statusline.vim

local H = require('mm.highlights')
local utils = require('mm.statusline.utils')

local function colors()
    local bg_color = H.darken_color(H.get_hl('PmenuThumb', 'bg'), -50)

    local comment_fg = H.get_hl('Comment', 'fg')
    local string_fg = H.get_hl('String', 'fg')
    local delimiter_fg = H.get_hl('Delimiter', 'fg')
    local number_fg = H.get_hl('Number', 'fg')
    local identifier_fg = H.get_hl('Identifier', 'fg')
    local inc_search_fg = H.get_hl('Search', 'fg')
    local error_color = H.get_hl('ErrorMsg', 'fg')
    local warning_color = H.get_hl('WarningMsg', 'fg')

    H.set_hls({
        { 'StatusLine', { guibg = bg_color, gui = 'NONE' } },
        { 'StatusLineNC', { guibg = bg_color, gui = 'NONE' } },
        { 'StMetadata', { guibg = bg_color, guifg = comment_fg } },
        { 'StMetadataPrefix', { guibg = bg_color, guifg = comment_fg, gui = 'bold' } },
        { 'StModified', { guibg = bg_color, guifg = string_fg } },
        { 'StGit', { guibg = bg_color, guifg = error_color } },
        { 'StGreen', { guibg = bg_color, guifg = string_fg } },
        { 'StOrange', { guibg = bg_color, guifg = delimiter_fg, gui = 'bold' } },
        { 'StDirectory', { guibg = bg_color, guifg = 'Gray', gui = 'italic' } },
        { 'StParentDirectory', { guibg = bg_color, guifg = string_fg, gui = 'bold' } },
        { 'StFilename', { guibg = bg_color, guifg = 'LightGray', gui = 'bold' }, },
        { 'StFilenameInactive', { guibg = bg_color, guifg = 'LightGray', gui = 'italic,bold' }, },
        { 'StTitle', { guibg = bg_color, guifg = 'LightGray', gui = 'bold' } },
        { 'StComment', { guibg = bg_color, guifg = comment_fg } },
        { 'StError', { guibg = bg_color, guifg = error_color } },
        { 'StWarning', { guibg = bg_color, guifg = warning_color } },
        { 'StInfo', { guibg = bg_color, guifg = comment_fg, gui = 'bold' } },
        { 'StModeNormal', { guibg = bg_color, gui = 'bold' } },
        { 'StModeInsert', { guibg = bg_color, guifg = string_fg, gui = 'bold' } },
        { 'StModeVisual', { guibg = bg_color, guifg = number_fg, gui = 'bold' } },
        { 'StModeReplace', { guibg = bg_color, guifg = identifier_fg, gui = 'bold' } },
        { 'StModeCommand', { guibg = bg_color, guifg = inc_search_fg, gui = 'bold' } },
    })
end

local function append(tbl, next, priority)
    priority = priority or 0
    local component, length = unpack(next)
    if component and component ~= '' and next and tbl then
        table.insert(tbl, { component = component, priority = priority, length = length })
    end
end

--- @param statusline table
--- @param available_space number
local function display(statusline, available_space)
    local str = ''
    local items = utils.prioritize(statusline, available_space)
    for _, item in ipairs(items) do
        if type(item.component) == 'string' then
            str = str .. item.component
        end
    end

    return str
end

---Aggregate pieces of the statusline
---@param tbl table
---@return function
local function make_status(tbl)
    return function(...)
        for i = 1, select('#', ...) do
            local item = select(i, ...)
            append(tbl, unpack(item))
        end
    end
end

function _G.statusline()
    local curwin = vim.g.statusline_winid or 0
    local curbuf = vim.api.nvim_win_get_buf(curwin)
    local available_space = vim.api.nvim_win_get_width(curwin)
    local ctx = {
        bufnum = curbuf,
        winid = curwin,
        bufname = vim.fn.bufname(curbuf),
        preview = vim.wo[curwin].previewwindow,
        readonly = vim.bo[curbuf].readonly,
        filetype = vim.bo[curbuf].ft,
        buftype = vim.bo[curbuf].bt,
        modified = vim.bo[curbuf].modified,
        fileformat = vim.bo[curbuf].fileformat,
        shiftwidth = vim.bo[curbuf].shiftwidth,
        expandtab = vim.bo[curbuf].expandtab,
    }
    -- Modifiers
    local plain = utils.is_plain(ctx)
    local file_modified = utils.modified(ctx, '●')
    local inactive = vim.api.nvim_get_current_win() ~= curwin
    local focused = vim.g.vim_in_focus or true
    local minimal = plain or inactive or not focused

    -- Setup
    local item = utils.item
    local item_if = utils.item_if
    local separator = { '%=' }
    local statusline = { }
    local add = make_status(statusline)

    add(
        { utils.spacer(1), 0 }
    )

    -- Filename
    local segments = utils.file(ctx, minimal)
    local dir, parent, file = segments.dir, segments.parent, segments.file
    local dir_item = utils.item(dir.item, dir.hl, dir.opts)
    local parent_item = utils.item(parent.item, parent.hl, parent.opts)
    local file_item = utils.item(file.item, file.hl, file.opts)
    local readonly_item = utils.item(utils.readonly(ctx), 'StError')

    -- show a minimal statusline with only the mode and file component
    if minimal then
        add({ readonly_item, 1 }, { dir_item, 3 }, { parent_item, 2 }, { file_item, 0 })
        return display(statusline, available_space)
    end

    local git_status = vim.b.gitsigns_status_dict or { }
    local lsp_status = utils.diagnostic_info(ctx)

    add(
        -- Left Section
        { item(utils.mode()), 0 },
        { item_if(file_modified, ctx.modified, 'StModified'), 1 },
        { readonly_item, 2 },
        { dir_item, 3 },
        { parent_item, 2 },
        { file_item, 0 },
        { item(git_status.head, 'StOrange', { prefix = '', prefix_color = 'StGit', before = ' ' }), 1 },
        { item(git_status.added, 'StTitle', { prefix = '', prefix_color = 'StGreen' }), 3 },
        { item(git_status.changed, 'StTitle', { prefix = '', prefix_color = 'StWarning' }), 3 },
        { item(git_status.removed, 'StTitle', { prefix = '', prefix_color = 'StError' }), 3 },
        { separator },
        -- Middle Section
        { separator },
        -- Right Section
        {
            item_if(
                lsp_status.error.count,
                lsp_status.error,
                'StError',
                { prefix = lsp_status.error.sign }
            ),
            1,
        },
        {
            item_if(
                lsp_status.warning.count,
                lsp_status.warning,
                'StWarning',
                { prefix = lsp_status.warning.sign }
            ),
            3,
        },
        {
            item_if(
                lsp_status.info.count,
                lsp_status.info,
                'StInfo',
                { prefix = lsp_status.info.sign }
            ),
            4,
        },
        { item(utils.lsp_status(), 'StMetadata'), 4 },
        -- Current line number/total line number
        {
            utils.line_info {
                prefix = '',
                prefix_color = 'StMetadataPrefix',
                current_hl = 'StTitle',
                total_hl = 'StComment',
                sep_hl = 'StComment',
            },
            7,
        }
    )

    return display(statusline, available_space)
end

local function setup_autocommands()
    mm.augroup('CustomStatusLine', {
        {
            events = { 'VimEnter', 'ColorScheme' },
            targets = { '*' },
            command = colors,
        },
    })
end

-- attach autocommands
setup_autocommands()

-- :h qf.vim, disable qf statusline
vim.g.qf_disable_statusline = 1

-- set the statusline
vim.o.statusline = '%!v:lua.statusline()'
