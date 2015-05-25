if exists("b:current_syntax")
    finish
endif

let b:current_syntax="gbasic"

syntax match gbasicKeyword "\v\c<sub>|<if>|<dimi>|<function>|<elseif>"
highlight def link gbasicKeyword Keyword
