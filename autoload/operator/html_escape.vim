" vim:foldmethod=marker:fen:
scriptencoding utf-8

" Saving 'cpoptions' {{{
let s:save_cpo = &cpo
set cpo&vim
" }}}

" http://vim.wikia.com/wiki/HTML_entities


function! operator#html_escape#escape(motion_wiseness) "{{{
    call s:replace_range('s:do_escape', a:motion_wiseness)
endfunction "}}}
function! s:do_escape(text) "{{{
    return s:substitute(
    \   a:text,
    \   g:operator_html_escape_escape_default_flags,
    \   g:operator_html_escape_escape_table
    \)
endfunction "}}}

function! operator#html_escape#unescape(motion_wiseness) "{{{
    call s:replace_range('s:do_unescape', a:motion_wiseness)
endfunction "}}}
function! s:do_unescape(text) "{{{
    return s:substitute(
    \   a:text,
    \   g:operator_html_escape_unescape_default_flags,
    \   g:operator_html_escape_unescape_table
    \)
endfunction "}}}


function! s:substitute(text, default_flags, table) "{{{
    let text = a:text
    for [from, to_info] in items(a:table)
        if type(to_info) == type("")
            let [to, flags] = [to_info, a:default_flags]
        elseif type(to_info) == type({})
            let [to, flags] = [to_info.to, get(to_info, 'flags', a:default_flags)]
        else
            continue    " invalid value, skip.
        endif

        let flags .= 'e'    " for avoiding errors.
        let text = substitute(text, from, to, flags)
    endfor
    return text
endfunction "}}}


" From operator-camelize.vim
function! s:yank_range(motion_wiseness) "{{{
    " Select previously-selected range in visual mode.
    " NOTE: `normal! gv` does not work
    " when user uses operator from normal mode.

    " From http://gist.github.com/356290
    " But specialized to operator-user.

    try
        " For saving &selection. See :help :map-operator
        let sel_save = &l:selection
        let &l:selection = "inclusive"
        " Save @@.
        let reg_save     = getreg('z', 1)
        let regtype_save = getregtype('z')

        if a:motion_wiseness == 'char'
            let ex = '`[v`]"zy'
        elseif a:motion_wiseness == 'line'
            let ex = '`[V`]"zy'
        elseif a:motion_wiseness == 'block'
            let ex = '`[' . "\<C-v>" . '`]"zy'
        else
            " silent execute 'normal! `<' . a:motion_wiseness . '`>'
            echoerr 'internal error, sorry: this block never be reached'
        endif
        execute 'silent normal!' ex
        return @z
    finally
        let &l:selection = sel_save
        call setreg('z', reg_save, regtype_save)
    endtry
endfunction "}}}
function! s:convert_wiseness(motion_wiseness) "{{{
    return get({
    \   'char': 'v',
    \   'line': 'V',
    \   'block': "\<C-v>",
    \}, a:motion_wiseness, '')
endfunction "}}}
function! s:paste_range(motion_wiseness, text) "{{{
    let reg_z_save     = getreg('z', 1)
    let regtype_z_save = getregtype('z')

    try
        call setreg('z', a:text, s:convert_wiseness(a:motion_wiseness))
        silent normal! gv"zp
    finally
        call setreg('z', reg_z_save, regtype_z_save)
    endtry
endfunction "}}}
function! s:replace_range(funcname, motion_wiseness) "{{{
    " Yank the range's text.
    let text = {a:funcname}(s:yank_range(a:motion_wiseness))
    " Paste the text to the range.
    call s:paste_range(a:motion_wiseness, text)
endfunction "}}}


" Restore 'cpoptions' {{{
let &cpo = s:save_cpo
" }}}
