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
    return escape(a:regex, '&')
endfunction
function! s:make_reverse_table(escape_table)
    let h = {}
    for [k, v] in items(a:escape_table)
        " Assumption: `v` does not contain regex.
        let h["\\&" . v . ";"] = s:escape_regex(k)
    endfor
    return h
endfunction



" From perl module HTML::Entities.
let s:escape_table = {
\   '&': 'amp',
\   '<': 'lt',
\   '>': 'gt',
\   'quot': '"',
\   'apos': "'",
\
\   nr2char(198): "AElig",
\   nr2char(193): "Aacute",
\   nr2char(194): "Acirc",
\   nr2char(192): "Agrave",
\   nr2char(197): "Aring",
\   nr2char(195): "Atilde",
\   nr2char(196): "Auml",
\   nr2char(199): "Ccedil",
\   nr2char(208): "ETH",
\   nr2char(201): "Eacute",
\   nr2char(202): "Ecirc",
\   nr2char(200): "Egrave",
\   nr2char(203): "Euml",
\   nr2char(205): "Iacute",
\   nr2char(206): "Icirc",
\   nr2char(204): "Igrave",
\   nr2char(207): "Iuml",
\   nr2char(209): "Ntilde",
\   nr2char(211): "Oacute",
\   nr2char(212): "Ocirc",
\   nr2char(210): "Ograve",
\   nr2char(216): "Oslash",
\   nr2char(213): "Otilde",
\   nr2char(214): "Ouml",
\   nr2char(222): "THORN",
\   nr2char(218): "Uacute",
\   nr2char(219): "Ucirc",
\   nr2char(217): "Ugrave",
\   nr2char(220): "Uuml",
\   nr2char(221): "Yacute",
\   nr2char(225): "aacute",
\   nr2char(226): "acirc",
\   nr2char(230): "aelig",
\   nr2char(224): "agrave",
\   nr2char(229): "aring",
\   nr2char(227): "atilde",
\   nr2char(228): "auml",
\   nr2char(231): "ccedil",
\   nr2char(233): "eacute",
\   nr2char(234): "ecirc",
\   nr2char(232): "egrave",
\   nr2char(240): "eth",
\   nr2char(235): "euml",
\   nr2char(237): "iacute",
\   nr2char(238): "icirc",
\   nr2char(236): "igrave",
\   nr2char(239): "iuml",
\   nr2char(241): "ntilde",
\   nr2char(243): "oacute",
\   nr2char(244): "ocirc",
\   nr2char(242): "ograve",
\   nr2char(248): "oslash",
\   nr2char(245): "otilde",
\   nr2char(246): "ouml",
\   nr2char(223): "szlig",
\   nr2char(254): "thorn",
\   nr2char(250): "uacute",
\   nr2char(251): "ucirc",
\   nr2char(249): "ugrave",
\   nr2char(252): "uuml",
\   nr2char(253): "yacute",
\   nr2char(255): "yuml",
\
\   nr2char(169): "copy",
\   nr2char(174): "reg",
\   nr2char(160): "nbsp",
\
\   nr2char(161): "iexcl",
\   nr2char(162): "cent",
\   nr2char(163): "pound",
\   nr2char(164): "curren",
\   nr2char(165): "yen",
\   nr2char(166): "brvbar",
\   nr2char(167): "sect",
\   nr2char(168): "uml",
\   nr2char(170): "ordf",
\   nr2char(171): "laquo",
\   nr2char(172): "not",
\   nr2char(173): "shy",
\   nr2char(175): "macr",
\   nr2char(176): "deg",
\   nr2char(177): "plusmn",
\   nr2char(185): "sup1",
\   nr2char(178): "sup2",
\   nr2char(179): "sup3",
\   nr2char(180): "acute",
\   nr2char(181): "micro",
\   nr2char(182): "para",
\   nr2char(183): "middot",
\   nr2char(184): "cedil",
\   nr2char(186): "ordm",
\   nr2char(187): "raquo",
\   nr2char(188): "frac14",
\   nr2char(189): "frac12",
\   nr2char(190): "frac34",
\   nr2char(191): "iquest",
\   nr2char(215): "times",
\   nr2char(247): "divide",
\
\   nr2char(338): "OElig",
\   nr2char(339): "oelig",
\   nr2char(352): "Scaron",
\   nr2char(353): "scaron",
\   nr2char(376): "Yuml",
\   nr2char(402): "fnof",
\   nr2char(710): "circ",
\   nr2char(732): "tilde",
\   nr2char(913): "Alpha",
\   nr2char(914): "Beta",
\   nr2char(915): "Gamma",
\   nr2char(916): "Delta",
\   nr2char(917): "Epsilon",
\   nr2char(918): "Zeta",
\   nr2char(919): "Eta",
\   nr2char(920): "Theta",
\   nr2char(921): "Iota",
\   nr2char(922): "Kappa",
\   nr2char(923): "Lambda",
\   nr2char(924): "Mu",
\   nr2char(925): "Nu",
\   nr2char(926): "Xi",
\   nr2char(927): "Omicron",
\   nr2char(928): "Pi",
\   nr2char(929): "Rho",
\   nr2char(931): "Sigma",
\   nr2char(932): "Tau",
\   nr2char(933): "Upsilon",
\   nr2char(934): "Phi",
\   nr2char(935): "Chi",
\   nr2char(936): "Psi",
\   nr2char(937): "Omega",
\   nr2char(945): "alpha",
\   nr2char(946): "beta",
\   nr2char(947): "gamma",
\   nr2char(948): "delta",
\   nr2char(949): "epsilon",
\   nr2char(950): "zeta",
\   nr2char(951): "eta",
\   nr2char(952): "theta",
\   nr2char(953): "iota",
\   nr2char(954): "kappa",
\   nr2char(955): "lambda",
\   nr2char(956): "mu",
\   nr2char(957): "nu",
\   nr2char(958): "xi",
\   nr2char(959): "omicron",
\   nr2char(960): "pi",
\   nr2char(961): "rho",
\   nr2char(962): "sigmaf",
\   nr2char(963): "sigma",
\   nr2char(964): "tau",
\   nr2char(965): "upsilon",
\   nr2char(966): "phi",
\   nr2char(967): "chi",
\   nr2char(968): "psi",
\   nr2char(969): "omega",
\   nr2char(977): "thetasym",
\   nr2char(978): "upsih",
\   nr2char(982): "piv",
\   nr2char(8194): "ensp",
\   nr2char(8195): "emsp",
\   nr2char(8201): "thinsp",
\   nr2char(8204): "zwnj",
\   nr2char(8205): "zwj",
\   nr2char(8206): "lrm",
\   nr2char(8207): "rlm",
\   nr2char(8211): "ndash",
\   nr2char(8212): "mdash",
\   nr2char(8216): "lsquo",
\   nr2char(8217): "rsquo",
\   nr2char(8218): "sbquo",
\   nr2char(8220): "ldquo",
\   nr2char(8221): "rdquo",
\   nr2char(8222): "bdquo",
\   nr2char(8224): "dagger",
\   nr2char(8225): "Dagger",
\   nr2char(8226): "bull",
\   nr2char(8230): "hellip",
\   nr2char(8240): "permil",
\   nr2char(8242): "prime",
\   nr2char(8243): "Prime",
\   nr2char(8249): "lsaquo",
\   nr2char(8250): "rsaquo",
\   nr2char(8254): "oline",
\   nr2char(8260): "frasl",
\   nr2char(8364): "euro",
\   nr2char(8465): "image",
\   nr2char(8472): "weierp",
\   nr2char(8476): "real",
\   nr2char(8482): "trade",
\   nr2char(8501): "alefsym",
\   nr2char(8592): "larr",
\   nr2char(8593): "uarr",
\   nr2char(8594): "rarr",
\   nr2char(8595): "darr",
\   nr2char(8596): "harr",
\   nr2char(8629): "crarr",
\   nr2char(8656): "lArr",
\   nr2char(8657): "uArr",
\   nr2char(8658): "rArr",
\   nr2char(8659): "dArr",
\   nr2char(8660): "hArr",
\   nr2char(8704): "forall",
\   nr2char(8706): "part",
\   nr2char(8707): "exist",
\   nr2char(8709): "empty",
\   nr2char(8711): "nabla",
\   nr2char(8712): "isin",
\   nr2char(8713): "notin",
\   nr2char(8715): "ni",
\   nr2char(8719): "prod",
\   nr2char(8721): "sum",
\   nr2char(8722): "minus",
\   nr2char(8727): "lowast",
\   nr2char(8730): "radic",
\   nr2char(8733): "prop",
\   nr2char(8734): "infin",
\   nr2char(8736): "ang",
\   nr2char(8743): "and",
\   nr2char(8744): "or",
\   nr2char(8745): "cap",
\   nr2char(8746): "cup",
\   nr2char(8747): "int",
\   nr2char(8756): "there4",
\   nr2char(8764): "sim",
\   nr2char(8773): "cong",
\   nr2char(8776): "asymp",
\   nr2char(8800): "ne",
\   nr2char(8801): "equiv",
\   nr2char(8804): "le",
\   nr2char(8805): "ge",
\   nr2char(8834): "sub",
\   nr2char(8835): "sup",
\   nr2char(8836): "nsub",
\   nr2char(8838): "sube",
\   nr2char(8839): "supe",
\   nr2char(8853): "oplus",
\   nr2char(8855): "otimes",
\   nr2char(8869): "perp",
\   nr2char(8901): "sdot",
\   nr2char(8968): "lceil",
\   nr2char(8969): "rceil",
\   nr2char(8970): "lfloor",
\   nr2char(8971): "rfloor",
\   nr2char(9001): "lang",
\   nr2char(9002): "rang",
\   nr2char(9674): "loz",
\   nr2char(9824): "spades",
\   nr2char(9827): "clubs",
\   nr2char(9829): "hearts",
\   nr2char(9830): "diams",
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
