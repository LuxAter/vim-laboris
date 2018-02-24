" File: vim-laboris
" Description: Laboris filetype detection

function! s:SetGlobalOption(opt, val)
  if !exists("g:" . a:opt)
    let g:{a:opt} = a:val
  endif
endfunction

setlocal textwidth=0
setlocal wrapmargin=0


nnoremap <script> <silent> <buffer> <localleader>s :%sort<CR>
vnoremap <script> <silent> <buffer> <localleader>s :sort<CR>
nnoremap <script> <silent> <buffer> <localleader>s@ :%call laboris#sort_by_context()<CR>
vnoremap <script> <silent> <buffer> <localleader>s@ :call laboris#sort_by_context()<CR>
nnoremap <script> <silent> <buffer> <localleader>s+ :%call laboris#sort_by_project()<CR>
vnoremap <script> <silent> <buffer> <localleader>s+ :call laboris#sort_by_project()<CR>
nnoremap <script> <silent> <buffer> <localleader>sd :%call laboris#sort_by_date()<CR>
vnoremap <script> <silent> <buffer> <localleader>sd :call laboris#sort_by_date()<CR>
nnoremap <script> <silent> <buffer> <localleader>sdd :%call laboris#sort_by_due_date()<CR>
vnoremap <script> <silent> <buffer> <localleader>sdd :call laboris#sort_by_due_date()<CR>

nnoremap <script> <silent> <buffer> <localleader>j :call laboris#prioritize_increase()<CR>
vnoremap <script> <silent> <buffer> <localleader>j :call laboris#prioritize_increase()<CR>
nnoremap <script> <silent> <buffer> <localleader>k :call laboris#prioritize_decrease()<CR>
vnoremap <script> <silent> <buffer> <localleader>k :call laboris#prioritize_decrease()<CR>
nnoremap <script> <silent> <buffer> <localleader>0 :call laboris#prioritize_add('0')<CR>
vnoremap <script> <silent> <buffer> <localleader>0 :call laboris#prioritize_add('0')<CR>
nnoremap <script> <silent> <buffer> <localleader>1 :call laboris#prioritize_add('1')<CR>
vnoremap <script> <silent> <buffer> <localleader>1 :call laboris#prioritize_add('1')<CR>
nnoremap <script> <silent> <buffer> <localleader>2 :call laboris#prioritize_add('2')<CR>
vnoremap <script> <silent> <buffer> <localleader>2 :call laboris#prioritize_add('2')<CR>
nnoremap <script> <silent> <buffer> <localleader>3 :call laboris#prioritize_add('3')<CR>
vnoremap <script> <silent> <buffer> <localleader>3 :call laboris#prioritize_add('3')<CR>
nnoremap <script> <silent> <buffer> <localleader>4 :call laboris#prioritize_add('4')<CR>
vnoremap <script> <silent> <buffer> <localleader>4 :call laboris#prioritize_add('4')<CR>
nnoremap <script> <silent> <buffer> <localleader>5 :call laboris#prioritize_add('5')<CR>
vnoremap <script> <silent> <buffer> <localleader>5 :call laboris#prioritize_add('5')<CR>

inoremap <script> <silent> <buffer> date<Tab> <C-R>=strftime("%d-%m-%Y %h:%m:%s")<CR>
nnoremap <script> <silent> <buffer> <localleader>d :call laboris#replace_date()<CR>
vnoremap <script> <silent> <buffer> <localleader>d :call laboris#replace_date()<CR>

nnoremap <script> <silent> <buffer> <localleader>x :call laboris#mark_as_done()<CR>
vnoremap <script> <silent> <buffer> <localleader>x :call laboris#mark_as_done()<CR>

nnoremap <script> <silent> <buffer> <localleader>X :call laboris#mark_all_as_done()<CR>

nnoremap <script> <silent> <buffer> <localleader>D :call laboris#remove_completed()<CR>
