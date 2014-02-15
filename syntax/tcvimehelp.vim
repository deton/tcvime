" Vim syntax file
" Language:     tcvimehelp.vim
" Maintainer:   KIHARA Hideto <deton@m1.interq.or.jp>
" Last Change:  2014-02-09

scriptencoding utf-8

if exists("b:current_syntax")
  finish
endif

syn match tcvimeFirstPos '\^.' contains=tcvimeFirstKey
syn match tcvimeLastPos '\$.' contains=tcvimeLastKey
syn match tcvime12Pos '+.' contains=tcvime12Key

if tcvime_hide_helptbl_mark
  syn match tcvimeFirstKey contained '\^' conceal
  syn match tcvimeLastKey contained '\$' conceal
  syn match tcvime12Key contained '+' conceal
  syn match tcvimePadding ' ' conceal
else
  syn match tcvimeFirstKey contained '\^'
  syn match tcvimeLastKey contained '\$'
  syn match tcvime12Key contained '+'
  syn match tcvimePadding ' '
endif
syn match tcvimeMidLKey '>'
syn match tcvimeMidRKey '<'

hi def link tcvimeFirstPos      Comment
hi def link tcvimeLastPos       Type
hi def link tcvime12Pos         Constant
hi def link tcvimePadding       Ignore
if tcvime_hide_helptbl_mark
  hi def link tcvimeFirstKey      Ignore
  hi def link tcvimeLastKey       Ignore
  hi def link tcvime12Key         Ignore
else
  hi def link tcvimeFirstKey      Comment
  hi def link tcvimeLastKey       Type
  hi def link tcvime12Key         Constant
endif
hi def link tcvimeMidLKey       Identifier
hi def link tcvimeMidRKey       Identifier

let b:current_syntax = "tcvimehelp"
