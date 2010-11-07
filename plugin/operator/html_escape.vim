" vim:foldmethod=marker:fen:
scriptencoding utf-8

" Load Once {{{
if exists('g:loaded_html_escape') && g:loaded_html_escape
    finish
endif
let g:loaded_html_escape = 1
" }}}
" Saving 'cpoptions' {{{
let s:save_cpo = &cpo
set cpo&vim
" }}}


function! s:convert_entities(escape_table)
    return map(copy(a:escape_table), '"\\&" . v:val . ";"')
endfunction
function! s:escape_regex(regex)
    return substitute(a:regex, '[&]', '\="\\" . submatch(0)', 'g')
endfunction
function! s:make_reverse_table(escape_table)
    let h = {}
    for [k, v] in items(a:escape_table)
        " Assumption: `v` does not contain regex.
        let h["&" . v . ";"] = s:escape_regex(k)
    endfor
    return h
endfunction



let s:escape_table = {
\   '&': 'amp',
\   '<': 'lt',
\   '>': 'gt',
\}

if !exists('g:operator_html_escape_escape_table')
    let g:operator_html_escape_escape_table =
    \   s:convert_entities(s:escape_table)
else
    call extend(
    \   g:operator_html_escape_escape_table,
    \   s:convert_entities(s:escape_table),
    \   'keep'
    \)
endif

if !exists('g:operator_html_escape_escape_default_flags')
    let g:operator_html_escape_escape_default_flags = 'g'
endif


if !exists('g:operator_html_escape_unescape_table')
    let g:operator_html_escape_unescape_table =
    \   s:make_reverse_table(s:escape_table)
else
    call extend(
    \   g:operator_html_escape_unescape_table,
    \   s:make_reverse_table(s:escape_table),
    \   'keep'
    \)
endif

if !exists('g:operator_html_escape_unescape_default_flags')
    let g:operator_html_escape_unescape_default_flags = 'g'
endif


call operator#user#define('html-escape', 'operator#html_escape#escape')
call operator#user#define('html-unescape', 'operator#html_escape#unescape')


" Restore 'cpoptions' {{{
let &cpo = s:save_cpo
" }}}
