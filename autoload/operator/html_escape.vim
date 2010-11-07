" vim:foldmethod=marker:fen:
scriptencoding utf-8

" Saving 'cpoptions' {{{
let s:save_cpo = &cpo
set cpo&vim
" }}}

" http://vim.wikia.com/wiki/HTML_entities


function! operator#html_escape#escape(__unused__) "{{{
    let default_flags = g:operator_html_escape_escape_default_flags
    for [from, to_info] in items(g:operator_html_escape_escape_table)
        if type(to_info) == type("")
            let [to, flags] = [to_info, default_flags]
        elseif type(to_info) == type({})
            let [to, flags] = [to_info.to, get(to_info, 'flags', default_flags)]
        else
            continue    " invalid value, skip.
        endif

        silent execute "'[,']" 's/' . from . '/' . to . '/' . flags
    endfor
endfunction "}}}

function! operator#html_escape#unescape(__unused__) "{{{
    let default_flags = g:operator_html_escape_unescape_default_flags
    for [from, to_info] in items(g:operator_html_escape_unescape_table)
        if type(to_info) == type("")
            let [to, flags] = [to_info, default_flags]
        elseif type(to_info) == type({})
            let [to, flags] = [to_info.to, get(to_info, 'flags', default_flags)]
        else
            continue    " invalid value, skip.
        endif

        silent execute "'[,']" 's/' . from . '/' . to . '/' . flags
    endfor
endfunction "}}}


" Restore 'cpoptions' {{{
let &cpo = s:save_cpo
" }}}
