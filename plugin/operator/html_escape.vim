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


let s:escape_table = {
\   '&': '\&amp;',
\   '<': '\&lt;',
\   '>': '\&gt;',
\}
if !exists('g:operator_html_escape_escape_table')
    let g:operator_html_escape_escape_table = s:escape_table
else
    call extend(g:operator_html_escape_escape_table, s:escape_table, 'keep')
endif

if !exists('g:operator_html_escape_escape_default_flags')
    let g:operator_html_escape_escape_default_flags = 'g'
endif


let s:unescape_table = {
\   '&amp;': '\&',
\   '&lt;': '<',
\   '&gt;': '>',
\}
if !exists('g:operator_html_escape_unescape_table')
    let g:operator_html_escape_unescape_table = s:unescape_table
else
    call extend(g:operator_html_escape_unescape_table, s:unescape_table, 'keep')
endif

if !exists('g:operator_html_escape_unescape_default_flags')
    let g:operator_html_escape_unescape_default_flags = 'g'
endif


call operator#user#define('html-escape', 'operator#html_escape#escape')
call operator#user#define('html-unescape', 'operator#html_escape#unescape')


" Restore 'cpoptions' {{{
let &cpo = s:save_cpo
" }}}
