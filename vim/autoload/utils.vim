function utils#SetTabs(tabwidth)
    execute "set tabstop=".a:tabwidth
    execute "set shiftwidth=".a:tabwidth
    execute "set softtabstop=".a:tabwidth
endfunction

function! GitStatus()
    if !get(g:, 'gitgutter_enabled', 0) || empty(FugitiveHead())
        return ''
    endif
    let [ l:added, l:modified, l:removed ] = GitGutterGetHunkSummary()
    return printf('~%d +%d -%d', l:modified, l:added, l:removed)
endfunction
