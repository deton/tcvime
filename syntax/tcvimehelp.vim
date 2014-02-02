" Vim syntax file
" Language:     tcvimehelp.vim
" Maintainer:   KIHARA Hideto <deton@m1.interq.or.jp>
" Last Change:  2014-02-02

scriptencoding utf-8

if exists("b:current_syntax")
  finish
endif

syn match tcvimeFirstPos '.' contains=tcvimeFirstKey
syn match tcvimeMidPos '.' contains=tcvimeMidKey
syn match tcvimeLastPos '.' contains=tcvimeLastKey
syn match tcvime12Pos '.' contains=tcvime12Key

syn match tcvimeFirstKey contained '' conceal
syn match tcvimeMidKey contained '' conceal
syn match tcvimeLastKey contained '' conceal
syn match tcvime12Key contained '' conceal

hi def link tcvimeFirstPos      Comment
hi def link tcvimeLastPos       Type
hi def link tcvimeMidPos        Statement
hi def link tcvime12Pos         Constant
hi def link tcvimeFirstKey      Ignore
hi def link tcvimeMidKey        Ignore
hi def link tcvimeLastKey       Ignore
hi def link tcvime12Key         Ignore

let b:current_syntax = "tcvimehelp"
