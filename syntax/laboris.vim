" Vim syntax file
" Language: Laboris
" Maintainer: Arden Rasmussen
" URL: https://github.com/LuxAtrumStudio/vim-laboris

if exists('b:current_syntax')
  finish
endif

runtime! syntax/html.vim

syn spell toplevel

let b:regesc='[]()?.*@='

function s:CreateRegion(name, start, end, options, matchgroup)
  let matchgroup = a:matchgroup != ''?
    \ (' matchgroup=' . a:matchgroup) : 
    \ ''
  exec 'syn region ' . a:name . matchgroup . ' start=/' . a:start . '/ end=/' . a:end . '/ ' . a:options
endfunction

function s:CreateNonContainedMatch(name, regex, conceal)
  let conceal = a:conceal != ''?
    \ (a:conceal) :
    \ ''
  exec 'syn match ' . a:name . ' /' . a:regex . '/ ' . conceal
endfunction

function s:CreateMatch(name, regex, conceal)
  let conceal = a:conceal != ''?
    \ (a:conceal) :
    \ ''
  exec 'syn match ' . a:name . ' /' . a:regex . '/ contained ' . conceal
endfunction

call s:CreateRegion('laborisTask', '^', '$', 'fold contains=laborisDateTime,laborisProject', '')
call s:CreateRegion('laborisDone', '^[xX]', '$', 'fold contains=laborisDateTime,laborisProject', '')

call s:CreateMatch('laborisDateTime', '\v(0?[1-9]|[12][0-9]|3[01])-(0?[0-9]|1[012])-([0-9]{4}|[0-9]{2})(T([01]?[0-9]|2[0-4]):([0-5]?[0-9])(:[0-5]?[0-9])?)?', '')


call s:CreateMatch('laborisProject', '+[^[:blank:]]\+', '')

hi def laborisDateTimeHl ctermfg=3
hi def link laborisDateTime PreProc
hi def laborisProjectHl ctermfg=6
hi def link laborisProject Special
" hi def link laborisTask TODO

hi def link laborisDone Comment

let b:current_syntax = "laboris"
