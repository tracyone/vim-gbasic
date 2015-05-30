let s:scomment = 0
let s:comment_indent_level = 0

let s:ssub = 0

function! s:IndentLevel(lnum)
    return indent(a:lnum)/&shiftwidth
endfunction

function! s:NextNonBlankLine(lnum)
    let numlines = line('$')
    let current = a:lnum + 1
    while current <= numlines
        let tmp2=getline(current)
        if tmp2 =~? '\v.*\*\/$'
            return current
        elseif tmp2 =~? '\v\S'
            return current
        endif
        let current += 1
    endwhile
    return -2
endfunction

function! Getbasicfold(lnum)
    let tmp = getline(a:lnum)
    if  tmp =~? '\v^\s*$'
        return '-1'
    elseif tmp =~? '\v^.*\/\*.*$' 
        let s:scomment = a:lnum
        if   s:scomment > 2
            let s:comment_indent_level = <SID>IndentLevel(s:scomment-1)+1
        else
            let s:comment_indent_level = 1
        endif
        return ">".s:comment_indent_level
    elseif tmp =~? '\v.*\*\/$'
        let tmp = s:comment_indent_level
        let s:scomment = 0
        return "<".tmp
    elseif tmp =~? '\v\c^\s*(<sub>|<function>)'
        let s:ssub = a:lnum
        return ">1"
    elseif tmp =~? '\v\c^\s*<end\s*(sub|function)>'
        let s:ssub = 0
        return "<1"
    endif

    let this_indent = <SID>IndentLevel(a:lnum)

    if  a:lnum > s:scomment && s:scomment != 0
        return s:comment_indent_level
    endif
    if  a:lnum > s:ssub && s:ssub != 0
        if  this_indent > 0
            return this_indent
        endif
        return '1'
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

"matchit plugin
let b:match_words = '\c\<if\>:\c\<else\s*if\>:\c\<else\>:\c\<end\s*if\>,'
            \ . '\c\<sub\>:\c\<end\s*sub\>,'
            \ . '\c\<function\>:\c\<end\s*function\>,'
            \ . '\c\<for\>:\c\<break\>:\c\<continue\>:\c\<next\>,'
            \ . '\c\<while\>:\c\<break\>:\c\<continue\>:\c\<wend\>'
