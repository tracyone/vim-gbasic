function! s:IndentLevel(lnum)
    return indent(a:lnum)/&shiftwidth
endfunction

function! s:NextNonBlankLine(lnum)
    let numlines = line('$')
    let current = a:lnum + 1
    while current <= numlines
        if getline(current) =~? '\v\S'
            return current
        endif
        let current += 1
    endwhile
    return -2
endfunction

function! Getbasicfold(lnum)
    if getline(a:lnum) =~? '\v^\s*$'
        return '-1'
    endif
    let this_indent = <SID>IndentLevel(a:lnum)
    let next_indent = <SID>IndentLevel(<SID>NextNonBlankLine(a:lnum))
    if next_indent == this_indent
        return this_indent
    elseif next_indent < this_indent
        return this_indent
    elseif next_indent > this_indent
        return '>' . next_indent
    endif
endfunction

function! s:NextSection(type, backwards,visual)
    if a:visual
        normal! gv
    endif
    if a:type == 1
        let pattern = '\v\c^ *(sub>|function>)'
    elseif a:type == 2
        let pattern = '\v\c^ *end +(sub>|function>)'
    endif
    if a:backwards
        let dir = '/'
        let l:sflag='/e'
    else
        let dir = '?'
        let l:sflag=''
    endif
    execute 'silent normal! ' . dir . pattern . l:sflag ."\r"
endfunction

setlocal foldmethod=expr
setlocal foldexpr=Getbasicfold(v:lnum)

noremap <script> <buffer> <silent> [[ :call <SID>NextSection(1,0,0)<cr>
noremap <script> <buffer> <silent> ]] :call <SID>NextSection(1,1,0)<cr>
noremap <script> <buffer> <silent> [] :call <SID>NextSection(2,0,0)<cr>
noremap <script> <buffer> <silent> ][ :call <SID>NextSection(2,1,0)<cr>

vnoremap <script> <buffer> <silent> [[ :call <SID>NextSection(1,0,1)<cr>
vnoremap <script> <buffer> <silent> ]] :call <SID>NextSection(1,1,1)<cr>
vnoremap <script> <buffer> <silent> [] :call <SID>NextSection(2,0,1)<cr>
vnoremap <script> <buffer> <silent> ][ :call <SID>NextSection(2,1,1)<cr>

