" vim:foldmethod=marker:fen:
scriptencoding utf-8

" Saving 'cpoptions' {{{
let s:save_cpo = &cpo
set cpo&vim
" }}}

" http://vim.wikia.com/wiki/HTML_entities


function! operator#html_escape#escape(__unused__) "{{{
    call s:substitute(
    \   g:operator_html_escape_escape_default_flags,
    \   g:operator_html_escape_escape_table
    \)
endfunction "}}}

function! operator#html_escape#unescape(__unused__) "{{{
    call s:substitute(
    \   g:operator_html_escape_unescape_default_flags,
    \   g:operator_html_escape_unescape_table
    \)
endfunction "}}}


function! s:substitute(default_flags, table) "{{{
    for [from, to_info] in items(a:table)
        if type(to_info) == type("")
            let [to, flags] = [to_info, a:default_flags]
        elseif type(to_info) == type({})
            let [to, flags] = [to_info.to, get(to_info, 'flags', a:default_flags)]
        else
            continue    " invalid value, skip.
        endif

        let flags .= 'e'    " for avoiding errors.
        silent execute "'[,']" 's/' . from . '/' . to . '/' . flags
    endfor
endfunction "}}}


" Restore 'cpoptions' {{{
let &cpo = s:save_cpo
" }}}
