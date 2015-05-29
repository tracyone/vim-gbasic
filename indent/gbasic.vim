" Vim indent file
" Language:         gbasic
" Maintainer:       tracyone <tracyone@live.cn>
" Original Author:  tracyone <tracyone@live.cn>
" Latest Revision:  2015-05-28/13:17:53

if exists("b:did_indent")
    finish
endif
let b:did_indent = 1

"定义触发缩进的按键或者输入
setlocal indentexpr=GetGbasicIndent()
setlocal indentkeys=!^F,o,O,0),=~elseif,=~endif,=~else,=~while
setlocal indentkeys+==~wend,=~next,=~end,=~sub,=~function,=~for,=~if
"setlocal nosmartindent

if exists("*GetGbasicIndent")
    finish
endif

let s:cpo_save = &cpo
set cpo&vim

function s:buffer_shiftwidth()
    return &shiftwidth
endfunction

let s:enable_dbg = 0
function! s:Debug(string)
    if s:enable_dbg == 1
        echom a:string
    endif
endfunction


"这里使用的是同个函数..除了最后一个选项貌似其它都一样。
let s:sh_indent_defaults = {
            \ 'default': function('s:buffer_shiftwidth'),
            \ 'continuation-line': function('s:buffer_shiftwidth'),
            \ 'case-labels': function('s:buffer_shiftwidth'),
            \ 'case-statements': function('s:buffer_shiftwidth'),
            \ 'case-breaks': 0 }

function! s:indent_value(option)
    "返回缩进的空格数
    let Value = exists('b:sh_indent_options')
                \ && has_key(b:sh_indent_options, a:option) ?
                \ b:sh_indent_options[a:option] :
                \ s:sh_indent_defaults[a:option]
    if type(Value) == type(function('type'))
        return Value()
    endif
    return Value
endfunction

"GetGbasicIndent function --------{{{
function! GetGbasicIndent()
    let lnum = prevnonblank(v:lnum - 1)
    if lnum == 0
        return 0
    endif

    let pnum = prevnonblank(lnum - 1)
    call s:Debug("pp line:".pnum."cur line:".v:lnum."p line".lnum) 

    "ind 初始化为前一非空行的缩进空格数
    let ind = indent(lnum)
    call s:Debug( "init ind:".ind )
    let line = getline(lnum)
    "如果前一行匹配到分支，并且非终止，那么说明当前行在分支内部，所以要比前一行增加缩进
    if line =~ '\c^\s*\%(if\|then\|else\|elseif\|while\|for\)\>' 
        if line !~ '\v\c^\s*(<end\s=if>|wend>|next>)'
            let ind += s:indent_value('default')
            call s:Debug('add')
        endif
    elseif line =~ '\v\c^\s*(<sub>|<function>)\s+'
        "处于sub或者function之中的话要缩进
        if line !~ '\v\c^\s*<end\s=(sub>|function>)'
            let ind += s:indent_value('default')
            call s:Debug( "in sub or func" )
        endif
    endif 

    if s:is_continuation_line(line)
        "如果前一行遇到过行符号（_)，且前前一行是无效或者没有遇到过行符号那么增加缩进
        call s:Debug("p line has _")
        if pnum == 0 || !s:is_continuation_line(getline(pnum))
            "如果前前行不是说明前行是首个出现的过行符号的，
            let tmp2 = indent(lnum)
            if  line =~ '\v\c^\s*dims>\s+\w+\$\(\d+\)'
                let colno = match(line,'\v[(]',0,2)
            elseif line =~ '\v\c^\s*function>\s*\w+\$*\s*\('
                let colno = match(line,'\v[(]')
                let tmp2 = tmp2?tmp2+1:1
            elseif line =~ '\v^\s*\w+\$'
                let colno = match(line,'\v["]')
            else
                let colno = match(line,'\v[\s]')
                let tmp2 -= 1
            endif
            if colno != -1
                let ind = colno+tmp2
                call s:Debug("match".colno."ind".ind)
            endif
            call s:Debug("pp line has no _") 
        endif
    elseif pnum != 0 && s:is_continuation_line(getline(pnum))
        "如果前前一行是..
        let tmpnum = s:find_continued_lnum(pnum)
        if  getline(tmpnum) =~ '\v\c^\s*(<sub>|<function>)\s+'
            let ind = s:buffer_shiftwidth()
        else
            let ind = indent(tmpnum)
        endif
        call s:Debug( "pp line has _:".ind )
    endif

    let pine = line
    let line = getline(v:lnum)
    if line =~ '\v\c^\s*(<then>|<to>|<else>|<elseif>|<next>)' || line =~ '\v\c^\s*(<end\s=(sub>|function>|if)|wend)'
        if  ind-s:indent_value('default') >= 0 
            let ind -= s:indent_value('default')
        endif
        call s:Debug("sub")
    endif
    if  line =~ '\v\c^\s*(<sub>|<function>)'
        "当前行是函数或者过程则缩进永远是0
        let ind=0
    endif

    call s:Debug("result:".ind)
    return ind
endfunction
"}}}

function! s:is_continuation_line(line)
    "该行包括了_在尾部
    return a:line =~ '\%(\%(^\|[^\\]\)_\)$' 
endfunction

function! s:find_continued_lnum(lnum)
    let i = a:lnum
    while i > 1 && s:is_continuation_line(getline(i - 1))
        call s:Debug("has _:".i)
        let i -= 1
    endwhile
    call s:Debug("return:".i)
    return i
endfunction

let &cpo = s:cpo_save
unlet s:cpo_save
