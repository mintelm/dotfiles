return function()
    local hydra = require('hydra')
    local gitsigns = require('gitsigns')
    local hints = require('mm.plugins.hydra_hints')
    local cmd = function(command)
        return table.concat({ '<cmd>', command, '<CR>' })
    end
    local default_config = {
        invoke_on_body = true,
        hint = {
            position = 'bottom',
            border = mm.style.current.border,
        },
    }

    hydra({
        name = 'Git',
        config = mm.merge({color = 'pink'}, default_config),
        hint = hints.git,
        mode = { 'n', 'x' },
        body = '<leader>g',
        heads = {
            { '<Enter>', cmd 'Neogit', { exit = true, nowait = true } },
            { 's', cmd 'Gitsigns stage_hunk' },
            { 'S', gitsigns.stage_buffer },
            { 'u', gitsigns.undo_stage_hunk },
            { 'r', cmd 'Gitsigns reset_hunk' },
            { 'R', gitsigns.reset_buffer },
            { 'v', gitsigns.preview_hunk },
            { 'b', gitsigns.toggle_current_line_blame },
            { 'B', function() gitsigns.blame_line{ full = true } end },
            { 'j', function()
                    if vim.wo.diff then return ']c' end
                    vim.schedule(function() gitsigns.next_hunk() end)
                    return '<Ignore>'
                end, { expr = true } },
            { 'k', function()
                    if vim.wo.diff then return '[c' end
                    vim.schedule(function() gitsigns.prev_hunk() end)
                    return '<Ignore>'
                end, { expr = true } },
            { '<Esc>', nil, { exit = true, nowait = true, desc = false } },
        },
    })

    hydra({
        name = 'Telescope',
        config = mm.merge({color = 'teal'}, default_config),
        hint = hints.telescope,
        mode = 'n',
        body = '<Leader>f',
        heads = {
            { 'f', cmd 'Telescope find_files' },
            { 'r', cmd 'Telescope live_grep' },
            { 'g', cmd 'Telescope git_files' },
            { '/', cmd 'Telescope current_buffer_fuzzy_find' },
            { '?', cmd 'Telescope search_history' },
            { ';', cmd 'Telescope command_history' },
            { 'c', cmd 'Telescope commands' },
            { '<Enter>', cmd 'Telescope', { exit = true } },
            { '<Esc>', nil, { exit = true, nowait = true, desc = false} },
        }
    })

    hydra({
        name = 'Window',
        config = default_config,
        hint = hints.window,
        mode = 'n',
        body = '<C-w>',
        heads = {
            -- Move focus
            { 'w', '<C-w>w' },
            { '<C-w>', '<C-w>w', { desc = false } },
            { 'h', '<C-w>h' },
            { 'j', '<C-w>j' },
            { 'k', '<C-w>k' },
            { 'l', '<C-w>l' },
            -- Move window
            { 'H', cmd 'WinShift left' },
            { 'J', cmd 'WinShift down' },
            { 'K', cmd 'WinShift up' },
            { 'L', cmd 'WinShift right' },
            -- Split
            { 's', '<C-w>s' },
            { 'v', '<C-w>v' },
            { 'q', cmd 'try | close | catch | endtry', { desc = 'close window' } },
            -- Size
            { '+', '<C-w>+' },
            { '-', '<C-w>-' },
            { '>', '2<C-w>>', { desc = 'increase width' } },
            { '<', '2<C-w><', { desc = 'decrease width' } },
            { '=', '<C-w>=', { desc = 'equalize'} },
            --
            { '<Esc>', nil, { exit = true, nowait = true, desc = false } },
        },
    })
end
