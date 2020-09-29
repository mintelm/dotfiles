function utils#SetTabs(tabwidth)
    execute "set tabstop=".a:tabwidth
    execute "set shiftwidth=".a:tabwidth
    execute "set softtabstop=".a:tabwidth
endfunction

function! utils#GitStatus()
  let [a,m,r] = GitGutterGetHunkSummary()
  return printf('+%d ~%d -%d', a, m, r)
endfunction

function! utils#ShowDocumentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction
