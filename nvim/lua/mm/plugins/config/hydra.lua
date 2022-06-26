return function()
    local hydra = require('hydra')
    local cmd = function(command)
        return table.concat({ '<cmd>', command, '<CR>' })
    end
    local default_config = {
            invoke_on_body = true,
            hint = {
                position = 'bottom',
                border = 'rounded',
            },
    }

    hydra({
        name = 'Window Management',
        config = default_config,
        mode = 'n',
        body = '<C-w>',
        heads = {
            -- Move focus
            { 'w', '<C-w>w' },
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
