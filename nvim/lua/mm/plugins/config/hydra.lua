return function()
    local hydra = require('hydra')
    local function cmd(command)
        return table.concat({ '<cmd>', command, '<CR>' })
    end

    hydra({
        name = 'Window Management',
        config = {
            timeout = 4000,
            hint = {
                position = 'bottom',
                border = 'rounded',
            },
        },
        mode = 'n',
        body = '<C-w>',
        heads = {
            -- Move focus
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
            { '<Esc>', nil,  { exit = true }},
        },
        hint = [[
            ^^^^^^     Move     ^^^^^^   ^^     Split         ^^^^    Size
            ^^^^^^--------------^^^^^^   ^^---------------    ^^^^------------- 
            ^ ^ _k_ ^ ^   ^ ^ _K_ ^ ^    _s_: horizontally    _+_ _-_: height
            _h_ ^ ^ _l_   _H_ ^ ^ _L_    _v_: vertically      _>_ _<_: width
            ^ ^ _j_ ^ ^   ^ ^ _J_ ^ ^    _q_: close           ^ _=_ ^: equalize
            focus^^^^^^   window^^^^^^
            ^ ^ ^ ^ ^ ^   ^ ^ ^ ^ ^ ^    ^ ^ ^ ^ ^ ^ ^ ^ ^   ^ ^ ^ ^    _<Esc>_
        ]],
    })
end
