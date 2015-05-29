" keyword Vim syntax file
" Language:	    gbasic
" Maintainer:	tracyone <tracyone@live.cn>
" Last Change:	2015-05-27/22:32:19

if exists("b:current_syntax")
    finish
endif

let b:current_syntax="gbasic"

" highlight keywords of gbasic
syntax match gbasicKeyword "\v\c<if>|<elseif>|<sub>|<function>|<dimi>|<dims>|<return>|<byref>|<for>|<else>|<then>|<iff>|<to>"
syntax match gbasicKeyword "\v\c<next>|<while>|<wend>|<break>|<continue>"
syntax match gbasicKeyword "\v\c<end *(if|function|sub)>"

highlight def link gbasicKeyword keyword

" highlight bulidin function
syntax match gbasicBulidin "\v\c<ANDB>|<NOTB>|<ORB>|<SHL>|<SHR>|<XORB>|<CONTACT>|<CONFIRM>|<DIM>|<EXECCode>|<EXIT>"
syntax match gbasicBulidin "\v\c<FOR_TO_NAXT>|<GetLabelType>|<getvartype>|<GOTO>|<msgbox>|<option>|<pprint>|<print>|<fprint>|<redim>|<rem>"
syntax match gbasicBulidin "\v\c<setdim>|<settimer>|<strexpand>|<cls>|<getch\$|<gotoxy>|<input>|<hidekeyboard>|<keyboardstate>|<loadkeyboad>|<howkeyboard>"
syntax match gbasicBulidin "\v\c<getmenuid>|<hidemenu>|<loadmenu>|<loadmenu>|<chkdate>|<date>|<dateadd>|<datediff>|<dayofweek>|<time>|<animation>"
syntax match gbasicBulidin "\v\c<animimage>|<copyimage>|<crashing>|<drawellipse>|<drawline>|<drawrect>|<fillrect>|<getimage2>|<getimage>|<getimagefile>|<getimagesize>"
syntax match gbasicBulidin "\v\c<getpiximage>|<getscreen>|<gettextheight>|<gettextwidth>|<getxres>|<getyres>|<paint>|<putimage2>|<putimage>|<playsound>|<puttitles>"
syntax match gbasicBulidin "\v\c<roundrect>|<recordsound>|<savepage>|<setautopaint>|<setpixel>|<setpiximage>|<textout>|<textoutclip>|<transimage>|<update>|<gberrno\$"
syntax match gbasicBulidin "\v\c<addrof>|<calllibfunc>|<closeapp>|<getapplist\$|<getappontop>|<getintstr>|<loadgalaxy>|<loadlib>|<os_exec>|<setintstr>|<sendgalaxy>"
syntax match gbasicBulidin "\v\c<startthread>|<switchapp>|<unloadlib>|<decrypt>|<encrypt>|<getmd5>|<setenckey>|<createobject>|<curfld\$|<getfldcount>|<getfldname\$"
syntax match gbasicBulidin "\v\c<getfldtype>|<getfldval\$|<getfldval2\$|<getformdata>|<indic>|<loadcss>|<loadedpage\$|<loadfont>|<loadicon\$|<etfldval>|<setfocu>"
syntax match gbasicBulidin "\v\c<setformdata>|<setstyle\$|<showcursor>|<unloadfont>|<encode>|<fattr>|<fclose>|<fdelete>|<feof>|<flist>|<fmkdir>"
syntax match gbasicBulidin "\v\c<fopen>|<fprint>|<fread\$|<freadbin\$|<freadbin2\$|<freadln\$|<freadln2\$|<frename>|<fseek>|<fsize>|<ftell>"
syntax match gbasicBulidin "\v\c<fwrite>|<fwritebin>|<fwritebin2>|<loadblobfile>|<loadblobfile2>|<saveblobfile>|<abs>|<asc>|<atan>|<chr>|<cos>"
syntax match gbasicBulidin "\v\c<exp>|<ftnd>|<format>|<ftoa>|<getticks>|<getusrid>|<int>|<left>|<len>|<loadarray>|<log>"
syntax match gbasicBulidin "\v\c<log10>|<ltrim\$|<rtrim\$|<trim\$|<matcharray>|<mid>|<mtdb>|<pow>|<rand>|<repl\$|<replace>"
syntax match gbasicBulidin "\v\c<request\$|<right>|<round>|<sin>|<sleep>|<space>|<split>|<sortarray>|<sqrt>|<strtofloat>|<strtoint>"
syntax match gbasicBulidin "\v\c<tan>|<ubound>|<ucase\$|<lcase\$|<db_showgrid>|<gridselected\$|<db_showlut>|<lutselected\$|<lutselname\$|<getlutstr\$|<gridselected>"
syntax match gbasicBulidin "\v\c<setlutstr>|<showcalc>|<showdate>|<httpdnld>|<httpdnldabort>|<httpdnldable>|<httpupld>|<httpupldupdate>|<ping>|<getevent>|<getkey>"
syntax match gbasicBulidin "\v\c<getkeystate>|<getmousex>|<getmousey>|<keyhandled>|<mousehandled>|<devclose>|<deverror>|<devopen>|<devread>|<devwrite>|<loadurl>"
syntax match gbasicBulidin "\v\c<submit>|<encode>|<decode>|<getosver\$|<readprofile>|<setosver>|<writeprofile>|<getscrlval>|<setformres>|<setscrlval>|<setscrlwidth>"
syntax match gbasicBulidin "\v\c<showscroll>|<getmessage>|<getnotifysrc>|<getnotifydata>|<msglistener>|<sendmessage>|<authsucess>|<sync>|<tounicode>|<toutf8>|<toutf16>"
syntax match gbasicBulidin "\v\c<xmlclose>|<xmlfetch>|<xmlgotofirst>|<xmlparse>|<xmlparsefile>|<xpath>|<xmlscript>|<xvalue>"
highlight def link gbasicBulidin Function

" highlight comment of gbasic

" important comment in single quote comment
syntax match gbasicBold "\v\*\*\* +.*$" contained

" regluar comment
syntax region gbasicComment start="/\*"  end="\*/"
syntax match gbasicComment "\v'.*$" contains=gbasicBold
syntax match gbasicComment "\v//.*$" contains=gbasicBold

highlight def link gbasicBold Tag
highlight def link gbasicComment Comment


" highlight number of gbasic

" highlight preprocessor of gbasic
syntax match gbasicPreProc "\v^ *#include +"
syntax match gbasicPreProc "\v^ *#define +"
highlight def link gbasicPreProc PreProc

" highlight quote string of gbasic
syntax region gbasicString start=/\v"/ skip=/\v\\./ end=/\v"/
highlight def link gbasicString String
"
