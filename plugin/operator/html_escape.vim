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


call operator#user#define('html-escape', 'operator#html_escape#escape')
call operator#user#define('html-unescape', 'operator#html_escape#unescape')


" Restore 'cpoptions' {{{
let &cpo = s:save_cpo
" }}}
