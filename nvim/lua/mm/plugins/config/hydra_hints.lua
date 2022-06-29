return {
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
^ ^ ^                               _<Enter>_: list all pickers
^
^ _f_: find files        _r_: live grep           _/_: search in file   _;_: command-line history ^
^ _g_: find git files    _c_: execute command     _?_: search history
]],
}
