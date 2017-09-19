" Export Context Dictionary for unit testing {{{1
function! s:get_SID()
    return matchstr(expand('<sfile>'), '<SNR>\d\+_')
endfunction
let s:SID = s:get_SID()
delfunction s:get_SID

function! laboris#__context__()
    return { 'sid': s:SID, 'scope': s: }
endfunction

" Functions {{{1
function! s:remove_priority()
    :s/^(\d)\s\+//ge
endfunction

function! s:get_current_date()
    return strftime('%d-%m-%YT%H:%M:%S')
endfunction

function! laboris#prepend_date()
    execute 'normal! I' . s:get_current_date() . ' '
endfunction

function! laboris#replace_date()
    let current_line = getline('.')
    if (current_line =~ '^\(([0-9])\)\?\d\{2\}-\d\{2\}-\d\{2,4\} ') &&
                \ exists('g:laboris_existing_date') && g:laboris_existing_date == 'n'
        return
    endif
    execute 's/^\(([0-9]) \)\?\(\d\{2\}-\d\{2\}-\d\{2,4\}T\d\{2\}:\d\{2\}:\d\{2\} \)\?/\1' . s:get_current_date() . ' /'
endfunction

function! laboris#mark_as_done()
    call s:remove_priority()
    call laboris#prepend_date()
    execute 'normal! Ix '
endfunction

function! laboris#mark_all_as_done()
    :g!/^x /:call laboris#mark_as_done()
endfunction

function! s:append_to_file(file, lines)
    let l:lines = []

    " Place existing tasks in done.txt at the beggining of the list.
    if filereadable(a:file)
        call extend(l:lines, readfile(a:file))
    endif

    " Append new completed tasks to the list.
    call extend(l:lines, a:lines)

    " Write to file.
    call writefile(l:lines, a:file)
endfunction

function! laboris#remove_completed()
    " Check if we can write to done.txt before proceeding.

    let l:target_dir = expand('%:p:h')
    let l:todo_file = expand('%:p')
    let l:done_file = substitute(substitute(l:todo_file, 'todo.txt$', 'done.txt', ''), 'Todo.txt$', 'Done.txt', '')
    if !filewritable(l:done_file) && !filewritable(l:target_dir)
        echoerr "Can't write to file 'done.txt'"
        return
    endif

    let l:completed = []
    :g/^x /call add(l:completed, getline(line(".")))|d
    call s:append_to_file(l:done_file, l:completed)
endfunction

function! laboris#sort_by_context() range
    execute a:firstline . "," . a:lastline . "sort /\\(^\\| \\)\\zs@[^[:blank:]]\\+/ r"
endfunction

function! laboris#sort_by_project() range
    execute a:firstline . "," . a:lastline . "sort /\\(^\\| \\)\\zs+[^[:blank:]]\\+/ r"
endfunction

function! laboris#prioritize_increase()
    normal 0f)h
endfunction

function! laboris#prioritize_decrease()
    normal 0f)h
endfunction

function! laboris#prioritize_add(priority)
    " Need to figure out how to only do this if the first visible letter in a line is not (
    :call laboris#prioritize_add_action(a:priority)
endfunction

function! laboris#prioritize_add_action(priority)
    execute 's/^\(([0-9]) \)\?/(' . a:priority . ') /'
endfunction
