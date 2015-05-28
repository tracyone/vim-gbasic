" Vim indent file
" Language:         gbasic
" Maintainer:       tracyone <tracyone@live.cn>
" Original Author:  tracyone <tracyone@live.cn>
" Latest Revision:  2015-05-28/13:17:53

if exists("b:did_indent")
  finish
endif
let b:did_indent = 1

setlocal indentexpr=GetGbasicIndent()
setlocal indentkeys=!^F,o,O,0),=~sub,=~function,=~if,=~endif,=~for,=~else
setlocal indentkeys+==~elseif
"setlocal nosmartindent

if exists("*GetGbasicIndent")
  finish
endif

let s:cpo_save = &cpo
set cpo&vim

function s:buffer_shiftwidth()
  return &shiftwidth
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

function! GetGbasicIndent()
  let lnum = prevnonblank(v:lnum - 1)
  if lnum == 0
    return 0
  endif

  let pnum = prevnonblank(lnum - 1)
  "echom "pp line:".pnum."cur line:".v:lnum."p line".lnum

  "ind 初始化为前一非空行的缩进空格数
  let ind = indent(lnum)
  "echom "init ind:".ind
  let line = getline(lnum)
  "如果前一行匹配到分支，并且非终止，那么说明当前行在分支内部，所以要比前一行增加缩进
  if line =~ '\c^\s*\%(if\|then\|else\|elseif\|while\|for\|to\)\>' 
      if line !~ '\v\c^\s*<end\s=(if>|wend>|next>)'
          let ind += s:indent_value('default')
          "echom "add"
      endif
  elseif line =~ '\v\c^\s*(<sub>|<function>)\s+'
      "处于sub或者function之中的话要缩进
    if line !~ '\v\c^\s*<end\s=(sub>|function>)'
      let ind += s:indent_value('default')
    endif
  elseif s:is_continuation_line(line)
      "如果前一行遇到过行符号（_)，且前前一行是无效或者没有遇到过行符号那么增加缩进
    if pnum == 0 || !s:is_continuation_line(getline(pnum))
      let ind += s:indent_value('continuation-line')
    endif
  elseif pnum != 0 && s:is_continuation_line(getline(pnum))
      "如果前前一行是..
    let ind = indent(s:find_continued_lnum(pnum))
  endif

  let pine = line
  let line = getline(v:lnum)
  if line =~ '\v\c^\s*(<then>|<to>|<else>|<elseif>|<next>)' || line =~ '\v\c^\s*<end\s=(sub>|function>|if)'
    let ind -= s:indent_value('default')
    "echom "sub"
  endif

  "echom "result:".ind
  return ind
endfunction

function! s:is_continuation_line(line)
    "该行包括了_在尾部
  return a:line =~ '\%(\%(^\|[^\\]\)_\)$' 
endfunction

function! s:find_continued_lnum(lnum)
  let i = a:lnum
  while i > 1 && s:is_continuation_line(getline(i - 1))
    let i -= 1
  endwhile
  return i
endfunction

function! s:is_case_label(line, pnum)
  if a:line !~ '^\s*(\=.*)' 
    return 0
  endif

  if a:pnum > 0
    let pine = getline(a:pnum)
    if !(s:is_case(pine) || s:is_case_ended(pine))
      return 0
    endif
  endif

  let suffix = substitute(a:line, '^\s*(\=', "", "")
  let nesting = 0
  let i = 0
  let n = strlen(suffix)
  while i < n
    let c = suffix[i]
    let i += 1
    if c == '\\'
      let i += 1
    elseif c == '('
      let nesting += 1
    elseif c == ')'
      if nesting == 0
        return 1
      endif
      let nesting -= 1
    endif
  endwhile
  return 0
endfunction

function! s:is_case(line)
  return a:line =~ '^\s*case\>'
endfunction

function! s:is_case_break(line)
  return a:line =~ '^\s*;[;&]'
endfunction

function! s:is_case_ended(line)
  return s:is_case_break(a:line) || a:line =~ ';[;&]\s*\%(#.*\)\=$'
endfunction

function! s:is_case_empty(line)
  if a:line =~ '^\s*$' || a:line =~ '^\s*#'
    return s:is_case_empty(getline(v:lnum - 1))
  else
    return a:line =~ '^\s*case\>'
  endif
endfunction

let &cpo = s:cpo_save
unlet s:cpo_save
