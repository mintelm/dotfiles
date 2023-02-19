local utils = require('utils')
local style = require('style')

local hints = {
    git = [[
^ ^ ^                           _<Enter>_: Neogit
^
^ _j_: next hunk   _s_: stage hunk        _r_: reset hunk     _b_: blame line
^ _k_: prev hunk   _u_: undo stage hunk   _v_: preview hunk   _B_: blame show full ^
^ ^ ^              _S_: stage buffer      _R_: reset buffer
]],
    window = [[
^ ^^^^   ^ ^ Move ^ ^   ^^^^    ^ ^   Split        ^ ^ ^ ^ Size
^ ^^^^---^-^------^-^---^^^^   -^-^-------------   ^-^-^-^---------- ^
^  ^ ^ _k_ ^ ^  ^ ^ _K_ ^ ^    _s_: horizontally   _+_ _-_: height
^  _h_ _w_ _l_  _H_ ^ ^ _L_    _v_: vertically     _>_ _<_: width
^  ^ ^ _j_ ^ ^  ^ ^ _J_ ^ ^    _q_: close          ^ _=_ ^: equalize
^ ^^^ focus ^^^^^ window
]],
    telescope = [[
^ ^ ^                    ^ ^    _<Enter>_: list all pickers
^
^ _f_: find files        _r_: live grep      _/_: search in file    _c_: execute command
^ _g_: find git files    _s_: lsp symbols    _?_: search history    _:_: command-line history ^
]],
    dap = [[
^ _b_: toggle breakpoint    _s_: step over    _o_: step out    ^
^ _c_: continue             _i_: step into    _r_: toggle repl
]],
}

local function config()
    local hydra = require('hydra')
    local cmd = function(command)
        return table.concat({ '<cmd>', command, '<CR>' })
    end
    local default_config = {
        invoke_on_body = true,
        hint = {
            position = 'bottom',
            border = style.current.border,
        },
    }

    hydra({
        name = 'Window',
        config = default_config,
        hint = hints.window,
        mode = 'n',
        body = '<C-w>',
        heads = {
            -- Move focus
            { 'w',     '<C-w>w' },
            { '<C-w>', '<C-w>w',                            { desc = false } },
            { 'h',     '<C-w>h' },
            { 'j',     '<C-w>j' },
            { 'k',     '<C-w>k' },
            { 'l',     '<C-w>l' },
            -- Move window
            { 'H',     cmd('WinShift left') },
            { 'J',     cmd('WinShift down') },
            { 'K',     cmd('WinShift up') },
            { 'L',     cmd('WinShift right') },
            -- Split
            { 's',     '<C-w>s' },
            { 'v',     '<C-w>v' },
            { 'q',     cmd('try | close | catch | endtry'), { desc = 'close window' } },
            -- Size
            { '+',     '<C-w>+' },
            { '-',     '<C-w>-' },
            { '>',     '2<C-w>>',                           { desc = 'increase width' } },
            { '<',     '2<C-w><',                           { desc = 'decrease width' } },
            { '=',     '<C-w>=',                            { desc = 'equalize' } },
            --
            { '<Esc>', nil,                                 { exit = true, nowait = true, desc = false } },
        },
    })

    hydra({
        name = 'Git',
        config = utils.merge({ color = 'pink' }, default_config),
        hint = hints.git,
        mode = { 'n', 'x' },
        body = '<leader>g',
        heads = {
            { '<Enter>', cmd('Neogit'),                             { exit = true, nowait = true } },
            { 's',       cmd('Gitsigns stage_hunk') },
            { 'S',       cmd('Gitsigns stage_buffer') },
            { 'u',       cmd('Gitsigns undo_stage_hunk') },
            { 'r',       cmd('Gitsigns reset_hunk') },
            { 'R',       cmd('Gitsigns reset_buffer') },
            { 'v',       cmd('Gitsigns preview_hunk') },
            { 'b',       cmd('Gitsigns toggle_current_line_blame') },
            { 'B',       cmd('Gitsigns blame_line { full = true }') },
            { 'j',
                function()
                    if vim.wo.diff then return ']c' end
                    vim.schedule(function() vim.cmd('Gitsigns next_hunk') end)
                    return '<Ignore>'
                end,
                { expr = true }, },
            { 'k',
                function()
                    if vim.wo.diff then return '[c' end
                    vim.schedule(function() vim.cmd('Gitsigns prev_hunk') end)
                    return '<Ignore>'
                end,
                { expr = true }, },
            { '<Esc>', nil, { exit = true, nowait = true, desc = false } },
        },
    })

    hydra({
        name = 'Telescope',
        config = utils.merge({ color = 'teal' }, default_config),
        hint = hints.telescope,
        mode = 'n',
        body = '<Leader>f',
        heads = {
            { 'f',       cmd('Telescope find_files') },
            { 'r',       cmd('Telescope live_grep') },
            { 'g',       cmd('Telescope git_files') },
            { 's',       cmd('Telescope lsp_document_symbols theme=get_dropdown') },
            { '/',       cmd('Telescope current_buffer_fuzzy_find') },
            { '?',       cmd('Telescope search_history') },
            { ':',       cmd('Telescope command_history theme=get_ivy') },
            { 'c',       cmd('Telescope commands theme=get_ivy') },
            { '<Enter>', cmd('Telescope'),                                        { exit = true } },
            --
            { '<Esc>',   nil,                                                     { exit = true, nowait = true, desc = false }, },
        },
    })

    hydra({
        name = 'Debugging',
        config = utils.merge({ color = 'pink' }, default_config),
        hint = hints.dap,
        mode = 'n',
        body = '<Leader>d',
        heads = {
            { 'b',     cmd('DapToggleBreakpoint') },
            { 'c',     cmd('DapContinue') },
            { 's',     cmd('DapStepOver') },
            { 'i',     cmd('DapStepInto') },
            { 'o',     cmd('DapStepOut') },
            { 'r',     cmd('DapReplToggle') },
            { '<Esc>', nil,                       { exit = true, nowait = true, desc = false }, },
        },
    })
end

return {
    'anuvyklack/hydra.nvim',
    config = config,
    dependencies = 'sindrets/winshift.nvim',
}
