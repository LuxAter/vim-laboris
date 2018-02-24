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

call s:CreateRegion('htmlH1', '^\s*#', '\($\|[^\\]#\+\)', 'concealends', 'laborisDelimiter')
call s:CreateRegion('htmlH2', '^\s*##', '\($\|[^\\]#\+\)', 'concealends', 'laborisDelimiter')
call s:CreateRegion('htmlH3', '^\s*###', '\($\|[^\\]#\+\)', 'concealends', 'laborisDelimiter')
call s:CreateRegion('htmlH4', '^\s*####', '\($\|[^\\]#\+\)', 'concealends', 'laborisDelimiter')
call s:CreateRegion('htmlH5', '^\s*#####', '\($\|[^\\]#\+\)', 'concealends', 'laborisDelimiter')
call s:CreateRegion('htmlH6', '^\s*######', '\($\|[^\\]#\+\)', 'concealends', 'laborisDelimiter')

syn cluster laborisHeader contains=htmlH1,htmlH2,htmlH3,htmlH4,htmlH5,htmlH6

call s:CreateRegion('laborisItalic', '\*', '\*', 'concealends', 'laborisDelimiter')
call s:CreateRegion('laborisBold', '\*\*', '\*\*', 'concealends', 'laborisDelimiter')

call s:CreateRegion('laborisTask', '^([^12345])', '$', 'fold contains=laborisDateTime,laborisTime,laborisDue,laborisProject,laborisTarget,@headers,laborisItalic,laborisBold', '')
call s:CreateRegion('laborisDone', '^x', '$', 'fold contains=laborisDateTime,laborisTime,laborisProject,laborisTarget,laborisItalic,laborisBold', '')
call s:CreateRegion('laborisTask1', '^(1)', '$', 'fold contains=laborisDateTime,laborisTime,laborisDue,laborisProject,laborisTarget,laborisItalic,laborisBold', '')
call s:CreateRegion('laborisTask2', '^(2)', '$', 'fold contains=laborisDateTime,laborisTime,laborisDue,laborisProject,laborisTarget,laborisItalic,laborisBold', '')
call s:CreateRegion('laborisTask3', '^(3)', '$', 'fold contains=laborisDateTime,laborisTime,laborisDue,laborisProject,laborisTarget,laborisItalic,laborisBold', '')
call s:CreateRegion('laborisTask4', '^(4)', '$', 'fold contains=laborisDateTime,laborisTime,laborisDue,laborisProject,laborisTarget,laborisItalic,laborisBold', '')
call s:CreateRegion('laborisTask5', '^(5)', '$', 'fold contains=laborisDateTime,laborisTime,laborisDue,laborisProject,laborisTarget,laborisItalic,laborisBold', '')

call s:CreateMatch('laborisDue', '\v(due:)(([0-9]{4,2})[\/\.-](1[012]|0?[0-9])[\/\.-]([12][0-9]|3[01]|0?[1-9])([T\s]([01]?[0-9]|2[0-4]):([0-5]?[0-9])(:[0-5]?[0-9])?)?)', '')
call s:CreateMatch('laborisTime', '\v(due:[^\s]*)@<!(([01]?[0-9]|2[0-4]):([0-5]?[0-9])(:[0-5]?[0-9])?)', '')
call s:CreateMatch('laborisDateTime', '\v(due:[^\s]*)@<!(([0-9]{4,2})[\/\.-](1[012]|0?[0-9])[\/\.-]([12][0-9]|3[01]|0?[1-9])([T\s]([01]?[0-9]|2[0-4]):([0-5]?[0-9])(:[0-5]?[0-9])?)?)', '')

call s:CreateMatch('laborisProject', '+[^[:blank:]]\+', '')
call s:CreateMatch('laborisTarget', '@[^[:blank:]]\+', '')

hi def link laborisDateTime  Type
hi def link laborisTime      Type
hi def link laborisProject   Special
hi def link laborisTarget    Keyword
hi def link laborisDue       WarningMsg

hi def link laborisDone      Comment
hi def link laborisTask1     Error
hi def link laborisTask2     Character
hi def link laborisTask3     Todo
hi def link laborisTask4     Function
hi def link laborisTask5     String

hi def laborisItalic cterm=italic term=italic gui=italic
" hi def link todoItalicEnd todoItalic
hi def laborisBold cterm=bold term=bold gui=bold

hi def link laborisDelimiter Delimiter

let b:current_syntax = "laboris"
