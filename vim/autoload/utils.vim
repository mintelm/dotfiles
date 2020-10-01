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

function! utils#CocDiagnostic(kind, sign) abort
    let info = get(b:, 'coc_diagnostic_info', 0)
    if empty(info) || get(info, a:kind, 0) == 0
        return ''
    endif
    return printf('%s %d', a:sign, info[a:kind])
endfunction

function! utils#CocErrors() abort
    let sign = get(g:, 'coc_status_error_sign', 'E')
    return utils#CocDiagnostic('error', sign)
endfunction

function! utils#CocWarnings() abort
    let sign = get(g:, 'coc_status_warning_sign', 'W')
    return utils#CocDiagnostic('warning', sign)
endfunction

function! utils#CocInfos() abort
    let sign = get(g:, 'coc_status_info_sign', 'I')
    return utils#CocDiagnostic('information', sign)
endfunction

function! utils#CocHints() abort
    let sign = get(g:, 'coc_status_hint_sign', 'H')
    return utils#CocDiagnostic('hints', sign)
endfunction

function! utils#CocShortStatus() abort
    let status = get(g:, 'coc_status', '')
    return status
endfunction
