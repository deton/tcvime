" vi:set ts=8 sts=2 sw=2 tw=0:
scriptencoding cp932

" autoload/tcvime.vim - utility functions for tcvime.
"
" Maintainer: KIHARA Hideto <deton@m1.interq.or.jp>
" Last Change: 2013-06-08

let s:save_cpo = &cpo
set cpo&vim

if !exists("tcvime_mazegaki_edit_nocand")
  let tcvime_mazegaki_edit_nocand = 0
endif
if !exists("tcvime_keymap_for_help")
  let tcvime_keymap_for_help = &keymap
endif

if !exists("tcvime_keyboard")
  let tcvime_keyboard = "1 1 2 2 3 3 4 4 5 5 6 6 7 7 8 8 9 9 0 0 \<CR>q q w w e e r r t t y y u u i i o o p p \<CR>a a s s d d f f g g h h j j k k l l ; ; \<CR>z z x x c c v v b b n n m m , , . . / / "
  " ”šƒL[‚Ì’i‚ğ•\¦‚µ‚È‚¢ê‡‚ÍŸ‚Ì•¶š—ñ‚ğg‚¤‚æ‚¤‚É‚·‚é(qwerty)
"  let tcvime_keyboard = "q q w w e e r r t t y y u u i i o o p p \<CR>a a s s d d f f g g h h j j k k l l ; ; \<CR>z z x x c c v v b b n n m m , , . . / / "
endif

" Œğ‚º‘‚«•ÏŠ·‚ÅŠm’è‚µ‚½Œó•â‚ÌAŒó•âƒŠƒXƒg“à‚ÌˆÚ“®æˆÊ’u(0‚ªæ“ªB-1‚ÍˆÚ“®–³‚µ)
if !exists("tcvime_movecandto")
  let tcvime_movecandto = -1
endif

" Œğ‚º‘‚«•ÏŠ·Œó•â‘I‘ğ—pƒL[B
"   let g:tcvime#selectkeys = ['1','2','3','4','5','6','7','8','9','0']
" ’: Insert mode‚Å‚ÌŒó•â‘I‘ğ‚Ìê‡A
"     ‚±‚ÌƒL[‚Ån‚Ü‚élmap‚âimap‚ª‚ ‚éê‡‚ÍA|'timeoutlen'|‘Ò‚¿‚ª”­¶B
if !exists('g:tcvime#selectkeys')
  let g:tcvime#selectkeys = []
endif

" Œã’uŒ^ƒV[ƒPƒ“ƒX¨Š¿š•ÏŠ·‚ÅA•¶š”‚ªw’è‚³‚ê‚Ä‚¢‚È‚¢Û‚ÉA
" ‚±‚Ìƒpƒ^[ƒ“‚Éƒ}ƒbƒ`‚·‚é•¶š‚ª‘±‚­ŠÔ‚ÍŠ¿š‚É•ÏŠ·‚·‚éB
if !exists("g:tcvime#seq2kanji_pat")
  let g:tcvime#seq2kanji_pat = "[0-9a-z ;,\\./']*"
endif

" Œã’uŒ^ƒJƒ^ƒJƒi•ÏŠ·‚ÅA•¶š”‚ªw’è‚³‚ê‚Ä‚¢‚È‚¢Û‚ÉA
" ‚±‚Ìƒpƒ^[ƒ“‚Éƒ}ƒbƒ`‚·‚é•¶š‚ª‘±‚­ŠÔ‚ÍƒJƒ^ƒJƒi‚É•ÏŠ·‚·‚éB
let g:tcvime#hira2kata_pat = '[‚Ÿ-‚ñ][‚Ÿ-‚ñ[]*'
" “Ç‚İŠJnˆÊ’uƒ}[ƒN‚ğ' '“ü—Í‚Å‘ã‘Ö‚·‚éê‡‚Ìİ’è—á:
"   let g:tcvime#yomimarkchar = ' '
" '* ƒAƒCƒeƒ€'‚Ì‚æ‚¤‚ÉA*“™‚ÌŒã‚Ì' '‚Íc‚µ‚½‚¢ê‡‚Ìİ’è—á:
"   let g:tcvime#yomimarkchar = '\%([[:graph:]] \zs\| \)'
if exists('g:tcvime#yomimarkchar')
  let g:tcvime#hira2kata_pat = g:tcvime#yomimarkchar . '\=' . tcvime#hira2kata_pat
endif

let g:tcvime#hiragana = '‚Ÿ‚ ‚¡‚¢‚£‚¤‚¥‚¦‚§‚¨‚©‚ª‚«‚¬‚­‚®‚¯‚°‚±‚²‚³‚´‚µ‚¶‚·‚¸‚¹‚º‚»‚¼‚½‚¾‚¿‚À‚Á‚Â‚Ã‚Ä‚Å‚Æ‚Ç‚È‚É‚Ê‚Ë‚Ì‚Í‚Î‚Ï‚Ğ‚Ñ‚Ò‚Ó‚Ô‚Õ‚Ö‚×‚Ø‚Ù‚Ú‚Û‚Ü‚İ‚Ş‚ß‚à‚á‚â‚ã‚ä‚å‚æ‚ç‚è‚é‚ê‚ë‚ì‚í‚î‚ï‚ğ‚ñ'
let g:tcvime#katakana = 'ƒ@ƒAƒBƒCƒDƒEƒFƒGƒHƒIƒJƒKƒLƒMƒNƒOƒPƒQƒRƒSƒTƒUƒVƒWƒXƒYƒZƒ[ƒ\ƒ]ƒ^ƒ_ƒ`ƒaƒbƒcƒdƒeƒfƒgƒhƒiƒjƒkƒlƒmƒnƒoƒpƒqƒrƒsƒtƒuƒvƒwƒxƒyƒzƒ{ƒ|ƒ}ƒ~ƒ€ƒƒ‚ƒƒƒ„ƒ…ƒ†ƒ‡ƒˆƒ‰ƒŠƒ‹ƒŒƒƒƒƒƒ‘ƒ’ƒ“'

" insert mode‚ÉA’¼‘O‚Ìw’è‚³‚ê‚½•¶š”‚Ì‚Ğ‚ç‚ª‚È¨ƒJƒ^ƒJƒi•ÏŠ·‚ğs‚¤
" ‚½‚ß‚Ì•¶š—ñ‚ğ•Ô‚·B
"
" •¶š”‚Æ‚µ‚Ä0‚ğw’è‚·‚é‚ÆA
" g:tcvime#hira2kata_pat‚Éƒ}ƒbƒ`‚·‚é•¶š‚ª‘±‚­ŠÔ‚ÍƒJƒ^ƒJƒi•ÏŠ·‚ğs‚¤B
" (tutcode keymap‚Ìê‡AˆÈ‰º‚Ì‚æ‚¤‚ÉƒJƒ^ƒJƒi“ü—Í‚ª‰Â”\B
"  uRKtltugiehe siqljflallvƒA‚Õ‚è‚¯[‚µ‚å‚ñ¨ƒAƒvƒŠƒP[ƒVƒ‡ƒ“
" Å‰‚Ì•¶š‚¾‚¯ƒVƒtƒgƒL[‚ğ‰Ÿ‚µ‚È‚ª‚ç‘ÅŒ®‚µ‚ÄƒJƒ^ƒJƒi‚Å“ü—Í‚µ‚ÄA
" Œã‚ÍƒVƒtƒgƒL[–³‚µ‚Å‚Ğ‚ç‚ª‚È‚Å“ü—Í‚µ‚ÄAÅŒã‚ÉŒã’uŒ^ƒJƒ^ƒJƒi•ÏŠ·‚ÅA
" Å‰‚ÉƒJƒ^ƒJƒi‚Å“ü—Í‚µ‚½•¶š‚Ü‚Å‚ğ‚Ü‚Æ‚ß‚ÄƒJƒ^ƒJƒi•ÏŠ·)
" (ƒJƒ^ƒJƒiƒ‚[ƒh‚ÉØ‚è‘Ö‚¦‚½‚èu'rktltugiehe siqljfl'vA
" ‘S‚ÄƒVƒtƒgƒL[‚ğ‰Ÿ‚µ‚È‚ª‚ç‘ÅŒ®‚µ‚½‚èuRKTLTUGIEHe SIQLJFLv‚æ‚è‚àŠy‚©‚à)
"
" •¶š”‚Æ‚µ‚Ä•‰‚Ì’l‚ğw’è‚·‚é‚ÆA‚Ğ‚ç‚ª‚È‚Æ‚µ‚Äc‚·•¶š”‚Ìw’è‚Æ‚İ‚È‚·B
" (ƒJƒ^ƒJƒi‚É•ÏŠ·‚·‚é•¶š—ñ‚ª’·‚­‚Ä•¶š”‚ğ”‚¦‚é‚Ì‚ª–Ê“|‚Èê‡Œü‚¯)
" u—á‚¦‚Î‚ ‚Õ‚è‚¯[‚µ‚å‚ñvel2¨u—á‚¦‚ÎƒAƒvƒŠƒP[ƒVƒ‡ƒ“v
"
" tutcode keymap‚ÅŒã’uŒ^ƒJƒ^ƒJƒi•ÏŠ·‚ğs‚¤‚½‚ß‚Ìİ’è—á:
"     lmap <silent> e0 <C-R>=tcvime#InputConvertKatakana(0)<CR>
"     lmap <silent> e1 <C-R>=tcvime#InputConvertKatakana(1)<CR>
"     lmap <silent> e2 <C-R>=tcvime#InputConvertKatakana(2)<CR>
"     ...
"     lmap <silent> e9 <C-R>=tcvime#InputConvertKatakana(9)<CR>
" w’è‚µ‚½•¶š”‚Ì‚Ğ‚ç‚ª‚È‚ğc‚µ‚ÄƒJƒ^ƒJƒi•ÏŠ·‚·‚éê‡‚Ìİ’è—á:
"     lmap <silent> el1 <C-R>=tcvime#InputConvertKatakana(-1)<CR>
"     lmap <silent> el2 <C-R>=tcvime#InputConvertKatakana(-2)<CR>
"     lmap <silent> el3 <C-R>=tcvime#InputConvertKatakana(-3)<CR>
"     lmap <silent> el4 <C-R>=tcvime#InputConvertKatakana(-4)<CR>
"     lmap <silent> el5 <C-R>=tcvime#InputConvertKatakana(-5)<CR>
"     lmap <silent> el6 <C-R>=tcvime#InputConvertKatakana(-6)<CR>
function! tcvime#InputConvertKatakana(n)
  return tcvime#InputConvertKatakanaPos(col('.'), a:n)
endfunction

" Œã’uŒ^‚ÅƒJƒ^ƒJƒi•¶š—ñ‚ğL‚Î‚·
function! tcvime#InputConvertKatakanaExtend(n)
  let line = getline('.')
  let col = col('.')
  let pat = '\([ƒ@-ƒ–[]*\)\%' . col . 'c' " Œ»ˆÊ’uˆÈ‘O‚Ì˜A‘±‚·‚éƒJƒ^ƒJƒi
  if a:n == 0
    " ˜A‘±‚·‚éƒJƒ^ƒJƒiˆÈ‘O‚Ì˜A‘±‚·‚é‚Ğ‚ç‚ª‚È‚ğƒJƒ^ƒJƒi‚É
    let pat = '\([‚Ÿ-‚ñ][‚Ÿ-‚ñ[]*\)' . pat
  else
    " Œ»ˆÊ’uˆÈ‘O‚ÉˆÊ’u‚·‚éA˜A‘±‚·‚éƒJƒ^ƒJƒi‚Æw’è•¶š”ˆÈ‰º‚Ì‚Ğ‚ç‚ª‚È‚ğæ“¾
    let pat = '\([‚Ÿ-‚ñ[]\{,' . a:n . '}\)' . pat
  endif
  if exists('g:tcvime#yomimarkchar')
    let pat = g:tcvime#yomimarkchar . '\=' . pat
  endif
  let m = matchlist(line, pat)
  if empty(m)
    return ''
  endif
  let yomi = m[0]
  let s:prev_str = m[1] . m[2]
  let s:commit_str = tcvime#hira2kata(m[1]) . m[2]
  return substitute(yomi, '.', "\<BS>", 'g') . s:commit_str
endfunction

let s:prev_str = ''
let s:commit_str = ''

" ’¼‘O‚ÌŒã’uŒ^ƒJƒ^ƒJƒi•ÏŠ·‚ğk‚ß‚é
function! tcvime#InputConvertKatakanaShrink(n)
  if s:prev_str == ''
    return ''
  endif
  " ƒJ[ƒ\ƒ‹ˆÊ’u‘O‚ªA’¼‘O‚É•ÏŠ·‚µ‚½ƒJƒ^ƒJƒi•¶š—ñ‚Å‚È‚¢ê‡‚ÍA‰½‚à‚µ‚È‚¢B
  " ƒJƒ^ƒJƒi•ÏŠ·Œã‚É•Ê‚Ì•¶š‚ğ“ü—Í‚µ‚½Œã‚ÅŠÔˆá‚Á‚Ä‚±‚ÌŠÖ”‚ªŒÄ‚Î‚ê‚ÄA
  " ŒÃ‚¢ƒJƒ^ƒJƒi•ÏŠ·‚Ì“à—e‚ğ‚à‚Æ‚Éã‘‚«‚·‚é‚Æ¢‚é‚Ì‚ÅB
  let cnt = strlen(substitute(s:commit_str, '.', 'x', 'g'))
  let chars = matchstr(getline('.'), '.\{,' . cnt . '}\%' . col('.') . 'c')
  if chars != s:commit_str
    let s:prev_str = ''
    return ''
  endif
  let cnt = a:n
  if cnt == 0
    let cnt = 1
  endif
  let str = s:prev_str
  let strlist = matchlist(str, '\(.\{,' . cnt . '}\)\(.*\)')
  let kata = tcvime#hira2kata(strlist[2])
  let newstr = tcvime#kata2hira(strlist[1]) . kata
  " Shrink‚ğŒJ‚è•Ô‚µŒÄ‚ñ‚¾Û‚É1•¶š‚¸‚ÂƒJƒ^ƒJƒi‚ğk‚ß‚é‚½‚ßAprev_str‚ğk‚ß‚é
  let s:prev_str = strlist[2]
  " undo—p‚Éprev_str‚É‘Î‰‚·‚écommit_str‚ğƒZƒbƒg
  let s:commit_str = kata
  return substitute(str, '.', "\<BS>", 'g') . newstr
endfunction

" ’¼‘O‚Ì•ÏŠ·‚ğæ‚èÁ‚·
function! tcvime#InputConvertUndo()
  if s:prev_str == ''
    return ''
  endif
  " ƒJ[ƒ\ƒ‹ˆÊ’u‘O‚ªA’¼‘O‚É•ÏŠ·Šm’è‚µ‚½•¶š—ñ‚Å‚È‚¢ê‡‚ÍA‰½‚à‚µ‚È‚¢B
  " •ÏŠ·Šm’èŒã‚É•Ê‚Ì•¶š‚ğ“ü—Í‚µ‚½Œã‚ÅŠÔˆá‚Á‚Ä‚±‚ÌŠÖ”‚ªŒÄ‚Î‚ê‚ÄA
  " ŒÃ‚¢•ÏŠ·‚Ì“à—e‚ğ‚à‚Æ‚Éã‘‚«‚·‚é‚Æ¢‚é‚Ì‚ÅB
  let cnt = strlen(substitute(s:commit_str, '.', 'x', 'g'))
  let chars = matchstr(getline('.'), '.\{' . cnt . '}\%' . col('.') . 'c')
  if chars != s:commit_str
    let s:prev_str = ''
    return ''
  endif
  let str = s:commit_str
  let prev = s:prev_str
  " XXX: ‘½’iundo‚Í–¢‘Î‰
  let s:prev_str = ''
  let s:commit_str = prev
  return substitute(str, '.', "\<BS>", 'g') . prev
endfunction

" insert mode‚ÉAw’èˆÊ’u‚©‚çw’è‚³‚ê‚½•¶š”‚Ì•¶š—ñ‚ğæ“¾‚µ‚ÄA
" ‚Ğ‚ç‚ª‚È¨ƒJƒ^ƒJƒi•ÏŠ·‚ğs‚¤‚½‚ß‚Ì•¶š—ñ‚ğ•Ô‚·B
function! tcvime#InputConvertKatakanaPos(col, n)
  let chars = s:AcquireYomi(g:tcvime#hira2kata_pat, a:col, a:n)
  if strlen(chars) == 0
    return ''
  endif
  let s:prev_str = chars
  let s:commit_str = tcvime#hira2kata(chars)
  if exists('g:tcvime#yomimarkchar')
    let s:prev_str = substitute(s:prev_str, '^' . g:tcvime#yomimarkchar . '\=', '', '')
    let s:commit_str = substitute(s:commit_str, '^' . g:tcvime#yomimarkchar . '\=', '', '')
  endif
  return substitute(chars, '.', "\<BS>", 'g') . s:commit_str
endfunction

" insert mode‚ÉAw’èˆÊ’u‚©‚çw’è‚³‚ê‚½•¶š”‚Ì•¶š—ñ‚ğæ“¾‚·‚é
function! s:AcquireYomi(pat, col, n)
  if a:n > 0
    return matchstr(getline('.'), '.\{,' . a:n . '}\%' . a:col . 'c')
  endif
  let col = a:col
  if a:n == 0
    " ‘O’uŒ^Œğ‚º‘‚«•ÏŠ·‚Ì“Ç‚İ‚Æ‚µ‚Äw’è‚³‚ê‚½•¶š—ñ‚ª‚ ‚ê‚ÎA•ÏŠ·‘ÎÛ‚Æ‚·‚é
    let yomi = s:StatusGet('.', col)
    if yomi != ''
      return yomi
    endif
  endif
  let line = getline('.')
  if s:insert_line == line('.') && s:insert_col < a:col
    " Insert modeŠJnˆÊ’uˆÈ~‚ğ•ÏŠ·‘ÎÛ‚Æ‚·‚é
    " XXX: CTRL-D‚ÅƒCƒ“ƒfƒ“ƒg‚ğŒ¸‚ç‚µ‚½ê‡‚É‚Í–¢‘Î‰
    let line = strpart(line, s:insert_col - 1)
    let col = a:col - s:insert_col + 1
  endif
  " pat‚Éƒ}ƒbƒ`‚·‚é•¶š‚ğæ“¾
  let chars = matchstr(line, a:pat . '\%' . col . 'c')
  if a:n < 0 " œŠO‚·‚é•¶š”
    let excnt = -a:n
    let chars = matchstr(chars, '.\{' . excnt . '}\zs.*$')
  endif
  return chars
endfunction

" •¶š—ñ‚ğƒJƒ^ƒJƒi‚É•ÏŠ·‚·‚é
function! tcvime#hira2kata(str)
  return tr(a:str, g:tcvime#hiragana, g:tcvime#katakana)
endfunction

" •¶š—ñ‚ğ‚Ğ‚ç‚ª‚È‚É•ÏŠ·‚·‚é
function! tcvime#kata2hira(str)
  return tr(a:str, g:tcvime#katakana, g:tcvime#hiragana)
endfunction

" “ü—ÍƒV[ƒPƒ“ƒX‚ğŠ¿š‚É•ÏŠ·‚·‚éB
" lmap–³Œø‚Ì‚Ü‚Ü“ü—Í‚µ‚½•¶š—ñ‚ğAlmap—LŒø‚É‚µ‚½’¼Œã‚ÉŠ¿š‚É•ÏŠ·‚·‚é‚½‚ßB
"   lmap t0 <C-R>=tcvime#InputConvertSeq2Kanji(0)<CR>
" “ü—ÍƒV[ƒPƒ“ƒX’†‚ÉŒã’uŒ^•”ñ‡¬•ÏŠ·“™‚ª‚ ‚Á‚Ä‚àOKB
function! tcvime#InputConvertSeq2Kanji(n)
  let chars = s:AcquireYomi(g:tcvime#seq2kanji_pat, col('.'), a:n)
  if chars == ''
    return ''
  endif
  call feedkeys(chars, 't')
  return substitute(chars, '.', "\<BS>", 'g')
endfunction

" “ü—ÍƒV[ƒPƒ“ƒX‚ğŠ¿š‚É•ÏŠ·‚·‚éB
" “ü—ÍƒV[ƒPƒ“ƒX’†‚ÌŒã’uŒ^•”ñ‡¬•ÏŠ·“™‚É‚Í–¢‘Î‰B
" tcvime#InputConvertSeq2KanjiShrink()‚É‚æ‚èAŒã‚©‚ç•ÏŠ·‚ğk‚ß‚é‘€ì‚É‘Î‰B
function! tcvime#InputConvertSeq2KanjiWithShrink(n)
  let chars = s:AcquireYomi(g:tcvime#seq2kanji_pat, col('.'), a:n)
  if chars == ''
    return ''
  endif
  let kanji = s:Seq2Kanji(chars)
  let s:prev_str = chars
  let s:commit_str = kanji
  return substitute(chars, '.', "\<BS>", 'g') . s:commit_str
endfunction

" ’¼‘O‚Ì“ü—ÍƒV[ƒPƒ“ƒX¨Š¿š•ÏŠ·‚ğk‚ß‚é
" @param drop k‚ß‚½•¶š‚ğíœ‚·‚é‚©‚Ç‚¤‚©
function! tcvime#InputConvertSeq2KanjiShrink(drop)
  if s:prev_str == ''
    return ''
  endif
  " ƒJ[ƒ\ƒ‹ˆÊ’u‘O‚ªA’¼‘O‚É•ÏŠ·‚µ‚½•¶š—ñ‚Å‚È‚¢ê‡‚ÍA‰½‚à‚µ‚È‚¢
  let cnt = strlen(substitute(s:commit_str, '.', 'x', 'g'))
  let chars = matchstr(getline('.'), '.\{,' . cnt . '}\%' . col('.') . 'c')
  if chars != s:commit_str
    let s:prev_str = ''
    return ''
  endif
  let str = s:prev_str
  let strlist = matchlist(str, '\(.\)\(.*\)')
  " k‚ß‚½1•¶š‚ÍíœBCTRL-J‚ÅƒIƒ“‚É‚µ‚»‚±‚Ë‚Äj‚¾‚¯“ü‚Á‚½ê‡‚Éíœ‚µ‚½‚¢B
  let kanji = s:Seq2Kanji(strlist[2])
  let newstr = kanji
  if !a:drop
    let newstr = strlist[1] . kanji
  endif
  " Shrink‚ğŒJ‚è•Ô‚µŒÄ‚ñ‚¾Û‚É1•¶š‚¸‚Âk‚ß‚é‚½‚ßAprev_str‚ğk‚ß‚é
  let s:prev_str = strlist[2]
  " undo—p‚Éprev_str‚É‘Î‰‚·‚écommit_str‚ğƒZƒbƒg
  let commitprev = s:commit_str
  let s:commit_str = kanji
  return substitute(commitprev, '.', "\<BS>", 'g') . newstr
endfunction

" “ü—ÍƒV[ƒPƒ“ƒX‚ğŠ¿š•¶š—ñ‚É’uŠ·‚·‚é‚½‚ß‚Ì•¶š—ñ‚ğ•Ô‚·B
function! s:Seq2Kanji(str)
  if a:str == ''
    return ''
  endif
  let hassetkeymap = 0
  let keymap = &keymap
  if empty(keymap)
    let keymap = g:tcvime_keymap_for_help
    if empty(keymap)
      echo 'tcvime“ü—ÍƒV[ƒPƒ“ƒX¨Š¿š•ÏŠ·‚É‚ÍAkeymapƒIƒvƒVƒ‡ƒ“‚©g:tcvime_keymap_for_help‚Ìİ’è—v'
      return ''
    endif
    call tcvime#SetKeymap(keymap)
    let hassetkeymap = 1
  endif

  let kstr = ''
  let s = a:str
  while !empty(s)
    let len = strlen(s)
    let kanji = ''
    let i = 1
    let seq = strpart(s, 0, i)
    while i <= len && !empty(mapcheck(seq, 'l'))
      let kanji = maparg(seq, 'l')
      if !empty(kanji)
	break
      endif
      let i += 1
      let seq = strpart(s, 0, i)
    endwhile
    if empty(kanji)
      let kstr .= seq
    else
      " XXX: <Plug>‚â<C-R>=“™‚É‚Í–¢‘Î‰
      let kstr .= kanji
    endif
    let s = strpart(s, i)
  endwhile
  if hassetkeymap
    set iminsert=0
  endif
  return kstr
endfunction

" Š¿š•¶š—ñ‚ğ“ü—ÍƒV[ƒPƒ“ƒX‚É•ÏŠ·‚·‚éB
" •¶š”‚ğw’è‚µ‚È‚¢ê‡A‰p’PŒê“ü—Í‘O‚ÉƒXƒy[ƒX‚ğ“ü—Í‚µ‚Ä‚¨‚­‚ÆA
" ƒXƒy[ƒXˆÈ~‚Ì•¶š‚ğ‰pš‚É•ÏŠ·‚µ‚ÄA‹æØ‚è—p‚É“ü—Í‚µ‚½ƒXƒy[ƒX‚ğíœB
" —á:" code "‚Æ‘ÅŒ®‚·‚é‚Æ" ‰‰Še "‚Æ•\¦‚³‚êAŠJnƒL[‚ÅA"code"‚É•ÏŠ·B
function! tcvime#InputConvertKanji2Seq(n)
  " "undo "¨"ïE"A"code "¨"‰‰Še "
  let chars = s:AcquireYomi(' \=[^ ]\+ \=', col('.'), a:n)
  let seq = s:Kanji2Seq(chars, 1)
  let s:commit_str = seq
  return substitute(chars, '.', "\<BS>", 'g') . s:commit_str
endfunction

" Š¿š•¶š—ñ‚ğ“ü—ÍƒV[ƒPƒ“ƒX‚É•ÏŠ·‚·‚éB
" ‘ÎÛ•¶š—ñ‚ÍAInsert modeŠJnˆÊ’uˆÈ~‚à‚µ‚­‚ÍŒ»İs‘S‚ÄB
" lmap—LŒø‚É‚È‚Á‚Ä‚¢‚é‚Ì‚ÉAURL“™‚ğƒy[ƒXƒg‚µ‚½ê‡‚ÉAŒ³‚É–ß‚·‚½‚ßB
function! tcvime#InputConvertKanji2SeqAll()
  let line = getline('.')
  let col = col('.')
  if s:insert_line == line('.') && s:insert_col < col
    " Insert modeŠJnˆÊ’uˆÈ~‚ğ•ÏŠ·‘ÎÛ‚Æ‚·‚é
    " XXX: CTRL-D‚ÅƒCƒ“ƒfƒ“ƒg‚ğŒ¸‚ç‚µ‚½ê‡‚É‚Í–¢‘Î‰
    let line = strpart(line, s:insert_col - 1)
    let col = col - s:insert_col + 1
  endif
  let chars = matchstr(line, '.*' . '\%' . col . 'c')
  let seq = s:Kanji2Seq(chars, 0)
  let s:commit_str = seq
  return substitute(chars, '.', "\<BS>", 'g') . s:commit_str
endfunction

" Š¿š•¶š—ñ‚ğ“ü—ÍƒV[ƒPƒ“ƒX‚É’uŠ·‚·‚é‚½‚ß‚Ì•¶š—ñ‚ğ•Ô‚·B
function! s:Kanji2Seq(str, trim)
  if a:str == ''
    return ''
  endif
  let arr = split(a:str, '\zs')
  call map(arr, 's:Kanji2SeqChar(v:val)')
  let s:prev_str = a:str
  let seq = join(arr, '')
  if a:trim
    let seq = substitute(seq, '^ \+', '', '')
    let seq = substitute(seq, ' \+$', '', '')
  endif
  return seq
endfunction

" Š¿š1•¶š‚ğ“ü—ÍƒV[ƒPƒ“ƒX‚É•ÏŠ·‚·‚éB
function! s:Kanji2SeqChar(ch)
  if char2nr(a:ch) < 0x80
    return a:ch
  endif
  let seq = s:SearchKeymap(a:ch)
  if seq == ''
    return a:ch
  endif
  return seq
endfunction

" İ’è
let s:candidate_file = globpath($VIM.','.&runtimepath, 'mazegaki.dic')
let s:bushu_file = globpath($VIM.','.&runtimepath, 'bushu.rev')
let s:bushuhelp_file = globpath($VIM.','.&runtimepath, 'bushu.help')
let s:kanjitable_file = globpath($VIM.','.&runtimepath, 'kanjitable.txt')
let s:helpbufname = fnamemodify(tempname(), ':p:h') . '/__TcvimeHelp__'
let s:helpbufname = substitute(s:helpbufname, '\\', '/', 'g')
let s:candbufname = fnamemodify(tempname(), ':p:h') . '/__TcvimeCand__'
let s:candbufname = substitute(s:candbufname, '\\', '/', 'g')

" keymap‚ğİ’è‚·‚é
function! tcvime#SetKeymap(keymapname)
  if &l:keymap !=# a:keymapname
    execute 'set keymap=' . a:keymapname
    if exists('*TcvimeCustomKeymap')
      call TcvimeCustomKeymap()
    endif
  else
    set iminsert=1
  endif
endfunction

"   ƒ}ƒbƒsƒ“ƒO‚ğ—LŒø‰»
function! tcvime#MappingOn()
  let set_mapleader = 0
  if !exists('g:mapleader')
    let g:mapleader = "\<C-K>"
    let set_mapleader = 1
  endif
  let s:mapleader = g:mapleader

  if !hasmapto('<Plug>TcvimeIStart')
    silent! imap <unique> <silent> <Leader>q <Plug>TcvimeIStart
  endif
  if !hasmapto('<Plug>TcvimeIConvOrStart')
    silent! imap <unique> <silent> <Leader><Space> <Plug>TcvimeIConvOrStart
  endif
  if !hasmapto('<Plug>TcvimeIKatuyo')
    silent! imap <unique> <silent> <Leader>o <Plug>TcvimeIKatuyo
  endif
  if !hasmapto('<Plug>TcvimeIBushu')
    silent! imap <unique> <silent> <Leader>b <Plug>TcvimeIBushu
  endif
  if !hasmapto('<Plug>TcvimeNConvert')
    silent! nmap <unique> <silent> <Leader><Space> <Plug>TcvimeNConvert
  endif
  if !hasmapto('<Plug>TcvimeNKatuyo')
    silent! nmap <unique> <silent> <Leader>o <Plug>TcvimeNKatuyo
  endif
  if !hasmapto('<Plug>TcvimeNBushu')
    silent! nmap <unique> <silent> <Leader>b <Plug>TcvimeNBushu
  endif
  if !hasmapto('<Plug>TcvimeNHelp')
    silent! nmap <unique> <silent> <Leader>? <Plug>TcvimeNHelp
  endif
  if !hasmapto('<Plug>TcvimeNKanjiTable')
    silent! nmap <unique> <silent> <Leader>t <Plug>TcvimeNKanjiTable
  endif
  if !hasmapto('<Plug>TcvimeVHelp')
    silent! vmap <unique> <silent> <Leader>? <Plug>TcvimeVHelp
  endif
  if !hasmapto('<Plug>TcvimeVConvert')
    silent! vmap <unique> <silent> <Leader><Space> <Plug>TcvimeVConvert
  endif
  if !hasmapto('<Plug>TcvimeVKatuyo')
    silent! vmap <unique> <silent> <Leader>o <Plug>TcvimeVKatuyo
  endif

  inoremap <script> <silent> <Plug>TcvimeIStart <C-R>=<SID>InputStart()<CR>
  inoremap <script> <silent> <Plug>TcvimeIConvOrStart <C-R>=<SID>InputConvertOrStart(0)<CR>
  inoremap <script> <silent> <Plug>TcvimeIConvOrSpace <C-R>=<SID>InputConvertOrSpace()<CR>
  inoremap <script> <silent> <Plug>TcvimeIKatuyo <C-R>=<SID>InputConvertOrStart(1)<CR>
  inoremap <script> <silent> <Plug>TcvimeIBushu <C-R>=<SID>InputConvertBushu(col('.'))<CR>
  inoremap <script> <silent> <Plug>TcvimeIShrink <C-R>=tcvime#InputConvertUndo()<CR><C-R>=<SID>InputConvertShrinkLatest()<CR>
  nnoremap <script> <silent> <Plug>TcvimeNConvert :<C-U>call <SID>ConvertCount(v:count, 0)<CR>
  nnoremap <script> <silent> <Plug>TcvimeNKatuyo :<C-U>call <SID>ConvertCount(v:count, 1)<CR>
  nnoremap <script> <silent> <Plug>TcvimeNKatakana :<C-U>call <SID>ConvertKatakana(v:count)<CR>
  nnoremap <script> <silent> <Plug>TcvimeNKataHira :<C-U>call <SID>ConvertKatakana(-v:count)<CR>
  nnoremap <script> <silent> <Plug>TcvimeNBushu :<C-U>call <SID>ConvertBushu()<CR>
  nnoremap <script> <silent> <Plug>TcvimeNHelp :<C-U>call <SID>ShowStrokeHelp()<CR>
  nnoremap <script> <silent> <Plug>TcvimeNKanjiTable :<C-U>call tcvime#KanjiTable_FileOpen()<CR>
  nnoremap <script> <silent> <Plug>TcvimeNOpConvert :set opfunc=tcvime#ConvertOp<CR>g@
  nnoremap <script> <silent> <Plug>TcvimeNOpKatuyo :set opfunc=tcvime#ConvertOpKatuyo<CR>g@
  nnoremap <script> <silent> <Plug>TcvimeNOpKatakana :set opfunc=tcvime#ConvertOpKatakana<CR>g@
  vnoremap <script> <silent> <Plug>TcvimeVHelp :<C-U>call <SID>ShowHelpVisual()<CR>
  vnoremap <script> <silent> <Plug>TcvimeVConvert :<C-U>call tcvime#ConvertOp(visualmode(), 1)<CR>
  vnoremap <script> <silent> <Plug>TcvimeVKatuyo :<C-U>call tcvime#ConvertOpKatuyo(visualmode(), 1)<CR>
  vnoremap <script> <silent> <Plug>TcvimeVKatakana :<C-U>call tcvime#ConvertOpKatakana(visualmode(), 1)<CR>
  vnoremap <script> <silent> <Plug>TcvimeVKanji2Seq :<C-U>call tcvime#ConvertOpKanji2Seq(visualmode(), 1)<CR>
  vnoremap <script> <silent> <Plug>TcvimeVSeq2Kanji :<C-U>call tcvime#ConvertOpSeq2Kanji(visualmode(), 1)<CR>
  vnoremap <script> <silent> <Plug>TcvimeVShiftSeq :<C-U>call tcvime#ConvertOpShiftSeq(visualmode(), 1)<CR>

  if set_mapleader
    unlet g:mapleader
  endif

  augroup Tcvime
  autocmd!
  autocmd InsertEnter * call <SID>OnInsertEnter()
  augroup END
endfunction

"   ƒ}ƒbƒsƒ“ƒO‚ğ–³Œø‰»
function! tcvime#MappingOff()
  let set_mapleader = 0
  if !exists('g:mapleader')
    let g:mapleader = "\<C-K>"
    let set_mapleader = 1
  else
    let save_mapleader = g:mapleader
  endif
  let g:mapleader = s:mapleader
  " TODO: tcvimeˆÈŠO‚Åmap‚³‚ê‚½‚à‚Ì‚ğunmap‚µ‚È‚¢‚æ‚¤‚É‚·‚é
  silent! iunmap <Leader>q
  silent! iunmap <Leader><Space>
  silent! iunmap <Leader>o
  silent! iunmap <Leader>b
  silent! nunmap <Leader><Space>
  silent! nunmap <Leader>o
  silent! nunmap <Leader>b
  silent! nunmap <Leader>?
  silent! nunmap <Leader>t
  silent! vunmap <Leader>?
  silent! vunmap <Leader><Space>
  silent! vunmap <Leader>o
  if set_mapleader
    unlet g:mapleader
  else
    let g:mapleader = save_mapleader
  endif

  augroup Tcvime
  autocmd!
  augroup END
endfunction

let s:insert_line = 0
let s:insert_col = 1

" Œã’uŒ^•ÏŠ·—p‚ÉA‘}“üŠJnˆÊ’u‚ğ‹L˜^
function! s:OnInsertEnter()
  let s:insert_line = line('.')
  let s:insert_col = col('.')
endfunction

"==============================================================================
"				    “ü—Í§Œä

" “Ç‚İ‚Ì“ü—Í‚ğŠJn
function! s:InputStart()
  call s:StatusSet()
  return ''
endfunction

let s:completeyomi = ''
let s:completeop = 0

" Insert mode‚ÅŒã’uŒ^Œğ‚º‘‚«•ÏŠ·‚ğs‚¤B
" Šˆ—p‚·‚éŒê‚Ì•ÏŠ·‚Ìê‡‚ÍA
" •ÏŠ·‘ÎÛ•¶š—ñ‚Ì––”ö‚Éu\v‚ğ’Ç‰Á‚µ‚ÄŒğ‚º‘‚««‘‚ğŒŸõ‚·‚éB
"
" tc2“¯—l‚ÌŒã’uŒ^Œğ‚º‘‚«•ÏŠ·‚ğs‚¤‚½‚ß‚Ìİ’è—á:
"     " Šˆ—p‚µ‚È‚¢Œê
"     lmap <silent> 18 <C-R>=tcvime#InputPostConvert(1, 0)<CR>
"     lmap <silent> 28 <C-R>=tcvime#InputPostConvert(2, 0)<CR>
"     lmap <silent> 38 <C-R>=tcvime#InputPostConvert(3, 0)<CR>
"     lmap <silent> 48 <C-R>=tcvime#InputPostConvert(4, 0)<CR>
"     " Šˆ—p‚·‚éŒê(‚½‚¾‚µtc2‚Æˆá‚Á‚ÄA“Ç‚İ‚Ì•¶š”‚É‚ÍŠˆ—pŒê”ö‚ÍŠÜ‚Ü‚È‚¢)
"     lmap <silent> 29 <C-R>=tcvime#InputPostConvert(2, 1)<CR>
"     lmap <silent> 39 <C-R>=tcvime#InputPostConvert(3, 1)<CR>
"     lmap <silent> 49 <C-R>=tcvime#InputPostConvert(4, 1)<CR>
"     lmap <silent> 59 <C-R>=tcvime#InputPostConvert(5, 1)<CR>
" @param count Œğ‚º‘‚«•ÏŠ·‚Ì‘ÎÛ‚É‚·‚é“Ç‚İ‚Ì•¶š”
" @param katuyo Šˆ—p‚·‚éŒê‚Ì•ÏŠ·‚©‚Ç‚¤‚©B0:Šˆ—p‚µ‚È‚¢, 1:Šˆ—p‚·‚é
function! tcvime#InputPostConvert(count, katuyo)
  let s:status_line = line(".")
  let yomi = matchstr(getline('.'), '.\{' . a:count . '}\%' . col('.') . 'c')
  let len = strlen(yomi)
  if len == 0
    let s:last_keyword = ''
    let s:last_count = 0
    call s:StatusReset()
    return ''
  endif
  let s:status_column = col('.') - len
  return s:InputConvertSub(yomi, a:katuyo, 1)
endfunction

" Œã’uŒ^Œğ‚º‘‚«•ÏŠ·‚ÅA•¶š”‚ªw’è‚³‚ê‚Ä‚¢‚È‚¢Û‚ÉA
" ‚±‚Ìƒpƒ^[ƒ“‚Éƒ}ƒbƒ`‚·‚é•¶š‚ğ“Ç‚İ‚Æ‚µ‚Äæ“¾‚·‚éB
let g:tcvime#yomi_pat = '[^	-~ABCDEuvij]'
let s:mazegaki_yomi_max = 10

" Insert mode‚ÅŒã’uŒ^Œğ‚º‘‚«•ÏŠ·‚ğŠJn‚·‚éB“Ç‚İ•¶š”w’è–³‚µB
function! tcvime#InputPostConvertStart(katuyo)
  let col = col('.')
  " ‘O’uŒ^Œğ‚º‘‚«•ÏŠ·‚Ì“Ç‚İ‚Æ‚µ‚Äw’è‚³‚ê‚½•¶š—ñ‚ª‚ ‚ê‚ÎA•ÏŠ·‘ÎÛ‚Æ‚·‚é
  let yomi = s:StatusGet('.', col)
  if yomi == ''
    let line = getline('.')
    let c = col
    if s:insert_line == line('.') && s:insert_col < col
      " Insert modeŠJnˆÊ’uˆÈ~‚ğ•ÏŠ·‘ÎÛ‚Æ‚·‚é
      " XXX: CTRL-D‚ÅƒCƒ“ƒfƒ“ƒg‚ğŒ¸‚ç‚µ‚½ê‡‚É‚Í–¢‘Î‰
      let line = strpart(line, s:insert_col - 1)
      let c = col - s:insert_col + 1
    endif
    let yomi = matchstr(line, g:tcvime#yomi_pat . '\{,' . s:mazegaki_yomi_max . '}\%' . c . 'c')
    let s:status_line = line('.')
  endif
  while yomi != ''
    let len = strlen(yomi)
    let s:status_column = col - len
    let ret = s:InputConvertSub(yomi, a:katuyo, 0)
    " Œó•â‚ªŒ©‚Â‚©‚Á‚½ê‡‚ÍI—¹
    if ret != '' || s:completeyomi != ''
      return ret
    endif
    " Œó•â‚ªŒ©‚Â‚©‚ç‚È‚©‚Á‚½‚çA“Ç‚İ‚ğ1•¶šŒ¸‚ç‚µ‚ÄŒŸõ
    let strlist = matchlist(yomi, '.\(.*\)')
    let yomi = strlist[1]
  endwhile
  let s:last_keyword = ''
  let s:last_count = 0
  call s:StatusReset()
  return ''
endfunction

" Œğ‚º‘‚«•ÏŠ·‚Ì“Ç‚İ‚ğk‚ß‚é
function! tcvime#InputConvertShrink()
  if !pumvisible()
    return '>'
  endif
  return s:InputConvertShrinkPum()
endfunction

" Œğ‚º‘‚«•ÏŠ·‚Ì“Ç‚İ‚ğk‚ß‚éBpopup menu‚ª•\¦‚³‚ê‚Ä‚¢‚éê‡‚Ìˆ—B
function! s:InputConvertShrinkPum()
  let ret = s:InputConvertShrink()
  " Œó•â•¡”‚Ìê‡A<C-E>‚ğreturn‚µ‚Äpopup‚ğ•Â‚¶‚½ŒãOnCursorMovedI()‚©‚çÄpopup
  if ret == ''
    let s:completeop = 1
  endif
  return "\<C-E>" . ret
endfunction

" Œğ‚º‘‚«•ÏŠ·‚Ì“Ç‚İ‚ğk‚ß‚éB
function! s:InputConvertShrink()
  let yomi = s:completeyomi
  let oldlen = strlen(yomi)
  " “Ç‚İ‚ğ1•¶šŒ¸‚ç‚µ‚ÄŒŸõ
  let strlist = matchlist(yomi, '.\(.*\)')
  let yomi = strlist[1]
  while yomi != ''
    let len = strlen(yomi)
    let s:status_column += oldlen - len
    let ret = s:InputConvertSub(yomi, s:is_katuyo, 0)
    " Œó•â‚ªŒ©‚Â‚©‚Á‚½ê‡‚ÍI—¹
    if s:last_candidate != ''
      return ret
    endif
    " Œó•â‚ªŒ©‚Â‚©‚ç‚È‚©‚Á‚½‚çA“Ç‚İ‚ğ1•¶šŒ¸‚ç‚µ‚ÄŒŸõ
    let oldlen = strlen(yomi)
    let strlist = matchlist(yomi, '.\(.*\)')
    let yomi = strlist[1]
  endwhile
  let s:last_keyword = ''
  let s:last_count = 0
  call s:StatusReset()
  return ''
endfunction

" ’¼‘O‚ÌŒã’uŒ^Œğ‚º‘‚«•ÏŠ·‚ğk‚ß‚éB
" Œó•â1ŒÂ‚Ì‚½‚ß©“®Šm’è‚³‚ê‚½ê‡—pB
function! s:InputConvertShrinkLatest()
  if pumvisible()
    return s:InputConvertShrinkPum()
  endif
  " ƒJ[ƒ\ƒ‹ˆÊ’u‘O‚ªA’¼‘O‚É•ÏŠ·‚µ‚½•¶š—ñ‚Å‚È‚¢ê‡‚ÍA‰½‚à‚µ‚È‚¢B
  " •ÏŠ·Œã‚É•Ê‚Ì•¶š‚ğ“ü—Í‚µ‚½Œã‚ÅŠÔˆá‚Á‚Ä‚±‚ÌŠÖ”‚ªŒÄ‚Î‚ê‚ÄA
  " ŒÃ‚¢•ÏŠ·‚Ì“à—e‚ğ‚à‚Æ‚Éã‘‚«‚·‚é‚Æ¢‚é‚Ì‚ÅB
  let cnt = strlen(substitute(s:commit_str, '.', 'x', 'g'))
  let chars = matchstr(getline('.'), '.\{,' . cnt . '}\%' . col('.') . 'c')
  if chars != s:commit_str
    return ''
  endif
  let strlist = matchlist(chars, '.\(.*\)')
  if len(strlist) < 1
    return ''
  endif
  let yomi = strlist[1]
  let s:status_line = line('.')
  while yomi != ''
    let len = strlen(yomi)
    let s:status_column = col('.') - len
    let ret = s:InputConvertSub(yomi, s:is_katuyo, 0)
    " Œó•â‚ªŒ©‚Â‚©‚Á‚½ê‡‚ÍI—¹
    if ret != '' || s:completeyomi != ''
      return ret
    endif
    " Œó•â‚ªŒ©‚Â‚©‚ç‚È‚©‚Á‚½‚çA“Ç‚İ‚ğ1•¶šŒ¸‚ç‚µ‚ÄŒŸõ
    let strlist = matchlist(yomi, '.\(.*\)')
    let yomi = strlist[1]
  endwhile
  let s:last_keyword = ''
  let s:last_count = 0
  call s:StatusReset()
  return ''
endfunction

" Insert mode‚ÅA“Ç‚İ‚ª‚ ‚ê‚ÎŒğ‚º‘‚«•ÏŠ·‚ğŠJn‚µA–³‚¯‚ê‚Î' '‚ğ•Ô‚·B
function! s:InputConvertOrSpace()
  let status = s:StatusGet('.', col('.'))
  if status == ''
    let s:last_keyword = ''
    return ' '
  endif
  let lastyomi = s:last_keyword
  let ret = s:InputConvertSub(status, 0, 1)
  " Œó•â–³‚µ && ‘O‰ñ‚Æ“¯‚¶“Ç‚İ¨‘O‰ñ‚à•ÏŠ·•s‰ÂBÄ“x<Space>‚È‚Ì‚Å' '‚ğ•Ô‚·B
  " ‚Å‚È‚¢‚ÆA' '‚ğ‘}“ü‚Å‚«‚È‚­‚È‚Á‚½‚æ‚¤‚ÉŒ©‚¦‚é‚Ì‚ÅB
  " <Plug>TcvimeIStartƒL[‚ğ‰Ÿ‚µ‚Ä“Ç‚İŠJnˆÊ’uƒŠƒZƒbƒg‚·‚ê‚Î‘}“ü‚Å‚«‚é‚¯‚ÇB
  " XXX: ÄŒŸõ–³‚µ‚ÉA‘O‰ñ‚Æ“¯‚¶“Ç‚İ‚ÆˆÊ’us:status_column‚©‚ğŠm”F‚µ‚½•û‚ª—Ç‚¢?
  if ret == '' && s:completeyomi == '' && lastyomi == status
    call s:StatusReset()
    return ' '
  endif
  return ret
endfunction

" Insert mode‚ÅŒğ‚º‘‚«•ÏŠ·‚ğs‚¤B“Ç‚İ‚ª–³‚¢ê‡‚Í“Ç‚İŠJnƒ}[ƒN‚ğ•t‚¯‚éB
" @param katuyo Šˆ—p‚·‚éŒê‚Ì•ÏŠ·‚©‚Ç‚¤‚©B0:Šˆ—p‚µ‚È‚¢, 1:Šˆ—p‚·‚é
function! s:InputConvertOrStart(katuyo)
  let status = s:StatusGet('.', col('.'))
  if status == ''
    let s:last_keyword = ''
    return s:InputStart()
  endif
  return s:InputConvertSub(status, a:katuyo, 1)
endfunction

" Insert mode‚ÅŒğ‚º‘‚«•ÏŠ·‚ğs‚¤B
" Šˆ—p‚·‚éŒê‚Ì•ÏŠ·‚Ìê‡‚ÍA
" •ÏŠ·‘ÎÛ•¶š—ñ‚Ì––”ö‚Éu\v‚ğ’Ç‰Á‚µ‚ÄŒğ‚º‘‚««‘‚ğŒŸõ‚·‚éB
" @param katuyo Šˆ—p‚·‚éŒê‚Ì•ÏŠ·‚©‚Ç‚¤‚©B0:Šˆ—p‚µ‚È‚¢, 1:Šˆ—p‚·‚é
" @param finish Œó•â‚ªŒ©‚Â‚©‚ç‚È‚©‚Á‚½‚Éecho‚·‚é‚©‚Ç‚¤‚©B
function! s:InputConvertSub(yomi, katuyo, finish)
  let s:completeyomi = ''
  let inschars = ''
  let s:is_katuyo = a:katuyo
  if s:is_katuyo
    let key = a:yomi . '\'
  else
    let key = a:yomi
  endif
  let ncands = s:CandidateSearch(key, a:finish)
  if ncands == 1
    if !pumvisible()
      let inschars = s:InputFix(col('.'))
    else
      " InputConvertShrink()‚©‚çŒÄ‚Ño‚³‚ê‚½ê‡B
      " ‚³‚ç‚ÉShrink‚·‚é‚½‚ß‚Ìs:commit_strXV‚â©“®ƒwƒ‹ƒv•\¦‚ğ
      " OnCursorMovedI()“à‚Å‚â‚é‚½‚ßAs:completeyomi‚ğXV
      let s:completeyomi = a:yomi
      let inschars = substitute(a:yomi, '.', "\<BS>", 'g') . s:last_candidate
    endif
  elseif ncands > 0
    if !pumvisible()
      call s:InputConvertShowPopup(a:yomi)
    endif
  elseif ncands == 0
    if a:finish
      echo 'Œğ‚º‘‚««‘’†‚É‚ÍŒ©‚Â‚©‚è‚Ü‚¹‚ñ: <' . a:yomi . '>'
    endif
  else
    echo 'Œğ‚º‘‚«•ÏŠ·«‘ƒtƒ@ƒCƒ‹‚ÌƒI[ƒvƒ“‚É¸”s‚µ‚Ü‚µ‚½: ' . s:candidate_file
  endif
  return inschars
endfunction

" Œó•â‘I‘ğ—pƒ|ƒbƒvƒAƒbƒvƒƒjƒ…[‚ğ•\¦‚·‚é
function! s:InputConvertShowPopup(yomi)
  let s:completeyomi = a:yomi
  inoremap > <C-R>=tcvime#InputConvertShrink()<CR>
  autocmd Tcvime CursorMovedI * call <SID>OnCursorMovedI()
  " Œó•â‘I‘ğ—pmenuƒL[’Ç‰Á
  let items = []
  let i = 0
  let len = len(s:last_candidate_list)
  while i < len
    let menu = ''
    if i < len(g:tcvime#selectkeys)
      let menu = g:tcvime#selectkeys[i]
      execute 'inoremap ' . g:tcvime#selectkeys[i] . ' <C-R>=tcvime#InputConvertSelectCand(' . i . ')<CR>'
    endif
    call add(items, {'word': s:last_candidate_list[i], 'menu': menu})
    let i += 1
  endwhile
  call complete(s:status_column, items)
endfunction

" complete()‚Å‘I‘ğ‚³‚ê‚½Œó•â‚ğæ“¾‚µ‚ÄA©“®ƒwƒ‹ƒv‚ğ•\¦‚·‚é
function! s:OnCursorMovedI()
  if s:completeyomi == ''
    return
  endif
  autocmd! Tcvime CursorMovedI *

  " ƒ|ƒbƒvƒAƒbƒvƒƒjƒ…[‘€ì—p‚Ìˆêmap‚ğíœ
  silent! iunmap >
  let i = 0
  let len = len(s:last_candidate_list)
  while i < len
    if i < len(g:tcvime#selectkeys)
      silent! execute 'iunmap ' . g:tcvime#selectkeys[i]
    endif
    let i += 1
  endwhile

  " “Ç‚İ‚ÌLk‘€ì‚É‚æ‚éÄŒŸõ‚Å•¡”Œó•â‚ªŒ©‚Â‚©‚Á‚½ê‡AÄ“xpopup menu‚ğ•\¦
  if s:completeop == 1
    let s:completeop = 0
    call s:InputConvertShowPopup(s:StatusGet('.', col('.')))
    return
  endif

  let col = col('.')
  if col == 1
    " <CR>‚ÅŠm’è‚µ‚Ä‰üs‚ª‘}“ü‚³‚ê‚Äs“ª‚É‚È‚Á‚½ê‡BTODO: autoindent‘Î‰
    let lnum = line('.') - 1
    let col = col([lnum, '$'])
    let status = s:StatusGet(lnum, col)
  else
    let status = s:StatusGet('.', col)
  endif
  if status != s:completeyomi
    if g:tcvime_movecandto >= 0
      call s:LearnCand(status)
    endif
    " XXX: ƒ|ƒbƒvƒAƒbƒvƒƒjƒ…[–³Œø‚Ìê‡A©“®ƒwƒ‹ƒv•\¦‚Å‚«‚È‚¢
    call s:ShowAutoHelp(s:completeyomi, status)
  endif
  let s:completeyomi = ''
  call s:StatusReset()
endfunction

" ƒ|ƒbƒvƒAƒbƒvƒƒjƒ…[•\¦‚ÉAw’è‚³‚ê‚½”Ô†‚ÌŒó•â‚ğŠm’è‚·‚é
function! tcvime#InputConvertSelectCand(idx)
  if !pumvisible()
    return g:tcvime#selectkeys[a:idx]
  endif
  let s:last_candidate = s:last_candidate_list[a:idx]
  let bs = substitute(s:completeyomi, '.', "\<BS>", 'g')
  return "\<C-E>" . bs . s:last_candidate
endfunction

" Šm’è‚µ‚æ‚¤‚Æ‚µ‚Ä‚¢‚éŒó•â‚ª–â‘è‚È‚¢‚©‚Ç‚¤‚©ƒ`ƒFƒbƒN
function! s:IsCandidateOK(str)
  if strlen(a:str) > 0 && strlen(s:last_candidate) > 0
    if s:is_katuyo && s:last_keyword ==# (a:str . '\') || s:last_keyword ==# a:str
      return 1
    endif
  endif
  return 0
endfunction

" Œó•â‚ğŠm’è‚µ‚ÄAŠm’è‚µ‚½•¶š—ñ‚ğ•Ô‚·
function! s:InputFix(col)
  let inschars = ''
  let str = s:StatusGet('.', a:col)
  if s:IsCandidateOK(str)
    let inschars = s:last_candidate
    if strlen(inschars) > 0
      if g:tcvime_movecandto >= 0
	call s:LearnCand(inschars)
      endif
      call s:ShowAutoHelp(str, inschars)
      let bs = substitute(str, '.', "\<BS>", "g")
      let inschars = bs . inschars
    endif
  else
    " echom str s:last_candidate s:is_katuyo s:last_keyword " DEBUG
  endif
  call s:StatusReset()
  return inschars
endfunction

" ’¼‘O‚Ì2•¶š‚Ì•”ñ‡¬•ÏŠ·‚ğs‚¤
function! s:InputConvertBushu(col)
  if a:col <= 2
    return ''
  endif
  let chars = matchlist(getline('.'), '\(.\)\(.\)\%' . a:col . 'c')
  if empty(chars)
    return ''
  endif
  let char1 = chars[1]
  let char2 = chars[2]
  let retchar = s:BushuConvert(char1, char2)
  if retchar == ''
    echo '•”ñ‡¬•ÏŠ·‚ª‚Å‚«‚Ü‚¹‚ñ‚Å‚µ‚½: <' . char1 . '>, <' . char2 . '>'
    return ''
  endif
  call s:ShowAutoHelp(chars[0], retchar)
  let inschars = "\<BS>\<BS>" . retchar
  return inschars
endfunction

" operatorfunc‚Æ‚µ‚ÄA‘I‘ğ‚³‚ê‚½•¶š—ñ‚ğŒğ‚º‘‚«•ÏŠ·‚·‚é
function! tcvime#ConvertOp(type, ...)
  let visual = 0
  if a:0  " Invoked from Visual mode
    let visual = 1
  endif
  call s:ConvertOpSub(a:type, visual, 0)
endfunction

" operatorfunc‚Æ‚µ‚ÄA‘I‘ğ‚³‚ê‚½•¶š—ñ‚ğŠˆ—p‚·‚éŒê‚Æ‚µ‚ÄŒğ‚º‘‚«•ÏŠ·‚·‚é
function! tcvime#ConvertOpKatuyo(type, ...)
  let visual = 0
  if a:0  " Invoked from Visual mode
    let visual = 1
  endif
  call s:ConvertOpSub(a:type, visual, 1)
endfunction

function! s:ConvertOpSub(type, visual, katuyo)
  let sel_save = &selection
  let &selection = "inclusive"
  let reg_save = @@

  if a:visual  " Invoked from Visual mode, use '< and '> marks.
    let s:status_line = line("'<")
    let s:status_column = col("'<")
    let s:status_colend = col("'>")
    silent exe "normal! `<" . a:type . "`>y"
  elseif a:type == 'char'
    let s:status_line = line("'[")
    let s:status_column = col("'[")
    let s:status_colend = col("']")
    silent exe "normal! `[v`]y"
  elseif a:type == 'block'
    let s:status_line = line("'[")
    let s:status_column = col("'[")
    let s:status_colend = col("']")
    silent exe "normal! `[\<C-V>`]y"
  else
    let @@ = ''
    call s:StatusReset()
  endif

  if @@ != ''
    call s:ConvertSub(@@, a:katuyo)
  endif

  let &selection = sel_save
  let @@ = reg_save
endfunction

" operatorfunc‚Æ‚µ‚ÄA‘I‘ğ‚³‚ê‚½•¶š—ñ‚ğƒJƒ^ƒJƒi‚É•ÏŠ·‚·‚é
function! tcvime#ConvertOpKatakana(type, ...)
  let sel_save = &selection
  let &selection = "inclusive"

  if a:0  " Invoked from Visual mode, use '< and '> marks.
    call s:ConvertOpKatakanaSub(col("'<"), col("'>"))
  elseif a:type == 'char'
    call s:ConvertOpKatakanaSub(col("'["), col("']"))
  endif

  let &selection = sel_save
endfunction

function! s:ConvertOpKatakanaSub(beg, end)
  let col = col('.')
  call cursor(0, a:end)
  execute "normal! a\<ESC>"
  let chars = matchstr(getline('.'), '\%' . a:beg . 'c.*\%' . col("'^") . 'c')
  let inschars = substitute(chars, '.', "\<BS>", 'g') . tcvime#hira2kata(chars)
  call s:InsertString(inschars)
  " XXX: undo‚·‚é‚Æs“ª‚ÉˆÚ“®‚·‚é‚Ì‚Å‚¢‚Ü‚¢‚¿
  "execute 's/\%' . a:beg . 'c.*\%' . col("'^") . 'c/\=tcvime#hira2kata(submatch(0))/'
  " XXX: ÅŒã‚Ì•¶š‚ª•ÏŠ·‚ÉŠÜ‚Ü‚ê‚È‚¢B\%>'>‚É‚·‚é‚Æs––‚Ü‚Å•ÏŠ·‚³‚ê‚é
  "s/\%'<.*\%'>/\=tcvime#hira2kata(submatch(0))/
  call cursor(0, col)
endfunction

" operatorfunc‚Æ‚µ‚ÄA‘I‘ğ‚³‚ê‚½•¶š—ñ‚ğ“ü—ÍƒV[ƒPƒ“ƒX‚É•ÏŠ·‚·‚é
function! tcvime#ConvertOpKanji2Seq(type, ...)
  let sel_save = &selection
  let &selection = "inclusive"

  if a:0  " Invoked from Visual mode, use '< and '> marks.
    call s:ConvertOpKanji2SeqSub(col("'<"), col("'>"))
  elseif a:type == 'char'
    call s:ConvertOpKanji2SeqSub(col("'["), col("']"))
  endif

  let &selection = sel_save
endfunction

function! s:ConvertOpKanji2SeqSub(beg, end)
  let col = col('.')
  call cursor(0, a:end)
  execute "normal! a\<ESC>"
  let chars = matchstr(getline('.'), '\%' . a:beg . 'c.*\%' . col("'^") . 'c')
  let seq = s:Kanji2Seq(chars, 0)
  let inschars = substitute(chars, '.', "\<BS>", 'g') . seq
  call s:InsertString(inschars)
  call cursor(0, col)
endfunction

" operatorfunc‚Æ‚µ‚ÄA‘I‘ğ‚³‚ê‚½•¶š—ñ‚ğ“ü—ÍƒV[ƒPƒ“ƒX‚Æ‚İ‚È‚µ‚ÄŠ¿š‚É•ÏŠ·‚·‚é
function! tcvime#ConvertOpSeq2Kanji(type, ...)
  let sel_save = &selection
  let &selection = "inclusive"

  if a:0  " Invoked from Visual mode, use '< and '> marks.
    call s:ConvertOpSeq2KanjiSub(col("'<"), col("'>"))
  elseif a:type == 'char'
    call s:ConvertOpSeq2KanjiSub(col("'["), col("']"))
  endif

  let &selection = sel_save
endfunction

function! s:ConvertOpSeq2KanjiSub(beg, end)
  let col = col('.')
  call cursor(0, a:end)
  execute "normal! a\<ESC>"
  let chars = matchstr(getline('.'), '\%' . a:beg . 'c.*\%' . col("'^") . 'c')
  let kstr = s:Seq2Kanji(chars)
  let inschars = substitute(chars, '.', "\<BS>", 'g') . kstr
  call s:InsertString(inschars)
  call cursor(0, col)
endfunction

" operatorfunc‚Æ‚µ‚ÄA‘I‘ğ‚³‚ê‚½•¶š—ñ‚Ì“ü—ÍƒV[ƒPƒ“ƒX‚ğ‚¸‚ç‚µ‚ÄŠ¿š‚É•ÏŠ·B
" ƒV[ƒPƒ“ƒX‚ª‚¸‚ê‚ÄˆÓ–¡•s–¾‚ÈŠ¿š•¶š—ñ‚É‚È‚Á‚½‚à‚Ì‚ğC•œ‚·‚é‚½‚ßB
" —á: u“d’n‹‹Œ•ª“®“cV“¯ v¨u‚¤‚©‚à‚µ‚ê‚Ü‚¹‚ñBv
function! tcvime#ConvertOpShiftSeq(type, ...)
  let sel_save = &selection
  let &selection = "inclusive"

  if a:0  " Invoked from Visual mode, use '< and '> marks.
    call s:ConvertOpShiftSeqSub(col("'<"), col("'>"))
  elseif a:type == 'char'
    call s:ConvertOpShiftSeqSub(col("'["), col("']"))
  endif

  let &selection = sel_save
endfunction

function! s:ConvertOpShiftSeqSub(beg, end)
  let col = col('.')
  call cursor(0, a:end)
  execute "normal! a\<ESC>"
  let chars = matchstr(getline('.'), '\%' . a:beg . 'c.*\%' . col("'^") . 'c')
  let seq = s:Kanji2Seq(chars, 0)
  let m = matchlist(seq, '.\(.*\)')
  if !empty(m)
    let kstr = s:Seq2Kanji(m[1])
    let inschars = substitute(chars, '.', "\<BS>", 'g') . kstr
    call s:InsertString(inschars)
  endif
  call cursor(0, col)
endfunction

" ˆÈ‘O‚ÌConvertCount()‚É“n‚³‚ê‚½countˆø”‚Ì’lB
" count‚ª0‚ÅÀs‚³‚ê‚½ê‡‚ÉˆÈ‘O‚Ìcount’l‚ğg‚¤‚æ‚¤‚É‚·‚é‚½‚ßB
let s:last_count = 0

" ¡‚ÌˆÊ’uˆÈ‘O‚Ìcount•¶š‚ğ•ÏŠ·‚·‚é
" @param count •ÏŠ·‚·‚é•¶š—ñ‚Ì’·‚³
" @param katuyo Šˆ—p‚·‚éŒê‚Ì•ÏŠ·‚©‚Ç‚¤‚©B0:Šˆ—p‚µ‚È‚¢, 1:Šˆ—p‚·‚é
function! s:ConvertCount(count, katuyo)
  let cnt = a:count
  if cnt == 0
    let cnt = s:last_count
    if cnt == 0
      let cnt = 1
    endif
  endif
  let s:last_count = cnt

  let s:is_katuyo = 0
  let s:status_line = line(".")
  let s:status_colend = col(".")
  execute "normal! a\<ESC>"
  let chars = matchstr(getline('.'), '.\{' . cnt . '}\%' . col("'^") . 'c')
  let s:status_column = col("'^") - strlen(chars)
  call s:ConvertSub(chars, a:katuyo)
endfunction

function! s:ConvertSub(yomi, katuyo)
  let chars = a:yomi
  if chars != ''
    let s:is_katuyo = a:katuyo
    if s:is_katuyo
      let chars = chars . '\'
    endif
    let ncands = s:CandidateSearch(chars, 1)
    if ncands > 1
      call s:Candwin_SetCands(s:last_candidate_list)
      call s:SelectWindowByName(s:candbufname)
    elseif ncands == 1
      call s:FixCandidate()
    elseif ncands == 0
      echo 'Œğ‚º‘‚««‘’†‚É‚ÍŒ©‚Â‚©‚è‚Ü‚¹‚ñ: <' . chars . '>'
    else
      echo 'Œğ‚º‘‚«•ÏŠ·«‘ƒtƒ@ƒCƒ‹‚ÌƒI[ƒvƒ“‚É¸”s‚µ‚Ü‚µ‚½: ' . s:candidate_file
    endif
  else
    let s:last_keyword = ''
    let s:last_count = 0
    call s:StatusReset()
  endif
endfunction

" ConvertCount()‚Å•ÏŠ·‚ğŠJn‚µ‚½Œó•â‚ğŠm’è‚·‚é
function! s:FixCandidate()
  call cursor(s:status_line, s:status_colend)
  execute "normal! a\<ESC>"
  let inschars = s:InputFix(col("'^"))
  let s:last_count = 0
  call s:InsertString(inschars)
endfunction

" ¡‚ÌˆÊ’uˆÈ‘O‚Ìcount•¶š‚ğƒJƒ^ƒJƒi‚É•ÏŠ·‚·‚é
" @param count •ÏŠ·‚·‚é•¶š—ñ‚Ì’·‚³
function! s:ConvertKatakana(count)
  execute "normal! a\<ESC>"
  let inschars = tcvime#InputConvertKatakanaPos(col("'^"), a:count)
  call s:InsertString(inschars)
endfunction

" ¡‚ÌˆÊ’uˆÈ‘O‚Ì2•¶š‚ğ•”ñ‡¬•ÏŠ·‚·‚é
function! s:ConvertBushu()
  execute "normal! a\<ESC>"
  let inschars = s:InputConvertBushu(col("'^"))
  call s:InsertString(inschars)
endfunction

" w’è‚³‚ê‚½•¶š—ñ‚ğƒoƒbƒtƒ@‚Éappend‚·‚é
function! s:InsertString(inschars)
  if strlen(a:inschars) > 0
    let save_bs = &backspace
    set backspace=2
    execute "normal! a" . a:inschars . "\<ESC>"
    let &backspace = save_bs
  endif
endfunction

"==============================================================================
"			     –¢Šm’è•¶šŠÇ——pŠÖ”ŒQ

"   –¢Šm’è•¶š—ñ‚ª‘¶İ‚·‚é‚©ƒ`ƒFƒbƒN‚·‚é
function! s:StatusIsEnable(lnum, col)
  let ln = a:lnum
  if ln == '.'
    let ln = line(ln)
  endif
  if s:status_line != ln || s:status_column <= 0 || s:status_column >= a:col
    return 0
  endif
  return 1
endfunction

"   –¢Šm’è•¶š—ñ‚ğŠJn‚·‚é
function! s:StatusSet()
  let s:status_line = line('.')
  let s:status_column = col('.')
  call s:StatusEcho()
endfunction

"   –¢Šm’è•¶š—ñ‚ğƒŠƒZƒbƒg‚·‚é
function! s:StatusReset()
  let s:status_line = 0
  let s:status_column = 0
  let s:status_colend = 0
endfunction

"   –¢Šm’è•¶š—ñ‚ğuó‘Ôv‚Æ‚µ‚Äæ“¾‚·‚é
function! s:StatusGet(lnum, col)
  if !s:StatusIsEnable(a:lnum, a:col)
    return ''
  endif

  " •K—v‚Èƒpƒ‰ƒ[ƒ^‚ğûW
  let stpos = s:status_column - 1
  let len = a:col - s:status_column
  let str = getline(a:lnum)

  return strpart(str, stpos, len)
endfunction

"   –¢Šm’è•¶š—ñ‚ÌŠJnˆÊ’u‚ÆI—¹ˆÊ’u‚ğ•\¦(ƒfƒoƒbƒO—p)
function! s:StatusEcho(...)
  echo '“Ç‚İ“ü—ÍŠJn;<Leader><Space>:•ÏŠ·,<Leader>o:Šˆ—p‚·‚éŒê‚Ì•ÏŠ·'
  "echo "New conversion (line=".s:status_line." column=".s:status_column.")"
endfunction

" ó‘ÔƒŠƒZƒbƒg
call s:StatusReset()

"==============================================================================
" ƒwƒ‹ƒv•\¦

" ƒwƒ‹ƒv—pƒoƒbƒtƒ@‚ğŠJ‚­
function! s:OpenHelpBuffer()
  if s:SelectWindowByName(s:helpbufname) < 0
    silent execute 'sp ' . s:helpbufname
    set buftype=nofile
    set bufhidden=delete
    set noswapfile
    set winfixheight
    set nobuflisted
    nnoremap <buffer> <silent> q :<C-U>quit<CR>
  endif
  %d _
  5wincmd _
endfunction

" ƒwƒ‹ƒv—pƒoƒbƒtƒ@‚ğ•Â‚¶‚é
function! tcvime#CloseHelpBuffer()
  if s:SelectWindowByName(s:helpbufname) > 0
    bwipeout!
  endif
endfunction

" ƒJ[ƒ\ƒ‹ˆÊ’u‚Ì•¶š‚Ìƒwƒ‹ƒv•\‚ğ•\¦‚·‚é
function! s:ShowStrokeHelp()
  let ch = matchstr(getline('.'), '\%' . col('.') . 'c.')
  call s:ShowHelp([ch], 0)
endfunction

" Visual mode‚Å‘I‘ğ‚³‚ê‚Ä‚¢‚é•¶š—ñ‚Ìƒwƒ‹ƒv•\‚ğ•\¦‚·‚é
function! s:ShowHelpVisual()
  let save_reg = @@
  silent execute 'normal! `<' . visualmode() . '`>y'
  call tcvime#ShowHelpForStr(substitute(@@, '\n', '', 'g'), 0)
  let @@ = save_reg
endfunction

" •ÏŠ·‚ÅŠm’è‚µ‚½•¶š—ñ‚Ìƒwƒ‹ƒv•\‚ğ•\¦‚·‚é
function! s:ShowAutoHelp(yomi, str)
  let s:prev_str = a:yomi
  let s:commit_str = a:str
  let yomichars = split(a:yomi, '\zs')
  let chars = split(a:str, '\zs')
  " “Ç‚İ‚Å“ü—Í‚µ‚½Š¿š‚Íƒwƒ‹ƒv•\¦•s—v‚È‚Ì‚Åæ‚èœ‚­
  call filter(chars, 'index(yomichars, v:val) == -1')
  call s:ShowHelp(chars, 0)
endfunction

" w’è‚³‚ê‚½•¶š—ñ‚ÌŠe•¶š‚Ìƒwƒ‹ƒv•\‚ğ•\¦‚·‚é
function! tcvime#ShowHelpForStr(str, forcebushu)
  let ar = split(a:str, '\zs')
  call s:ShowHelp(ar, a:forcebushu)
endfunction

" w’è‚³‚ê‚½•¶š”z—ñ‚Ìƒwƒ‹ƒv•\‚ğ•\¦‚·‚é
function! s:ShowHelp(ar, forcebushu)
  let curbuf = bufnr('')
  call s:OpenHelpBuffer()
  let winwidth = winwidth(0)
  let lastcol = 0
  let lastfrom = 1
  let width = 0
  let numch = 0
  let skipchars = []
  for ch in a:ar
    if strlen(ch) == 0 || ch == "\<CR>"
      " echo '•¶šƒwƒ‹ƒv•\•\¦‚Éw’è‚³‚ê‚½•¶š‚ª‹ó‚Å‚·B–³‹‚µ‚Ü‚·'
      continue
    endif
    call cursor(line('$'), 1)
    if a:forcebushu == 1
      let ret = s:ShowHelpBushuDic(ch)
    else
      let ret = s:ShowHelpChar(ch)
    endif
    if ret == -1 " ƒXƒgƒ[ƒN•\‚à•”ñ‡¬«‘‚à•\¦‚Å‚«‚È‚©‚Á‚½ê‡
      call add(skipchars, ch)
      continue
    endif
    let numch += 1
    if ret == 0 " ShowHelpBushuDic
      continue
    endif
    " •\‚ğ‰¡‚É•À‚×‚é
    if lastcol == 0 " Å‰‚Ì•\‚Ìê‡‚Í•Ï”‰Šú‰»‚¾‚¯
      let lastcol = col('$')
      let lastfrom = line('.')
      let width = lastcol + 2
      continue
    endif
    if lastcol + width >= winwidth " ‚³‚ç‚É•À‚×‚é‚Æ‚Í‚İo‚·ê‡‚Í‚»‚Ì‚Ü‚Ü‚É
      let lastcol = col('$')
      let lastfrom = line('.')
      continue
    endif
    let ln = line('.')
    .,$-1g/^/s//  /
    call cursor(ln, 1)
    let save_reg = @@
    silent! execute "normal! \<C-V>Gk$x" . lastfrom . "G$p"
    let @@ = save_reg
    let lastcol = col('$')
    silent! execute ln . ',$-1g/^$/d _'
  endfor
  if numch == 0
    call tcvime#CloseHelpBuffer()
  else
    silent! $g/^$/d _ " ––”ö‚Ì—]•ª‚È‹ós‚ğíœ
    normal 1G
    " wincmd p
    execute bufwinnr(curbuf) . 'wincmd w'
  endif
  if len(skipchars) > 0
    redraw
    echo '•¶šƒwƒ‹ƒv‚Å•\¦‚Å‚«‚éî•ñ‚ª‚ ‚è‚Ü‚¹‚ñ: <' . join(skipchars, ',') . '>'
  endif
endfunction

" w’è‚³‚ê‚½•¶š‚Ìƒwƒ‹ƒv•\‚ğ•\¦‚·‚é
function! s:ShowHelpChar(ch)
  let keyseq = s:SearchKeymap(a:ch)
  if strlen(keyseq) > 0
    call s:SelectWindowByName(s:helpbufname)
    return s:ShowHelpSequence(a:ch, keyseq)
  else
    return s:ShowHelpBushuDic(a:ch)
  endif
endfunction

" w’è‚³‚ê‚½•¶š‚Æ‚»‚ÌƒXƒgƒ[ƒN‚ğ•\‚É‚µ‚Ä•\¦‚·‚é
function! s:ShowHelpSequence(ch, keyseq)
  let from = line('$')
  call append(line('.') - 1, split(g:tcvime_keyboard, "\<CR>"))
  let to = line('$')
  let range = from . ',' . to
  let keyseq = a:keyseq
  let i = 0
  while strlen(keyseq) > 0
    let i = i + 1
    let key = strpart(keyseq, 0, 1)
    let keyseq = strpart(keyseq, 1)
    silent! execute range . 's@\V' . key . ' @' . i . '@'
  endwhile
  silent! execute range . 's@^\(....................\). . @\1@e'
  silent! execute range . 's@^\(................\). . @\1@e'
  silent! execute range . 's@\(.\)\(.\)@\1\2@ge'
  silent! execute range . 's@\(.\). @\1@ge'
  silent! execute range . 's@. . @E@g'
  silent! execute range . 's@@ @ge'
  call append(to - 1, '    ' . a:ch)
  call cursor(from, 1)
  return 1
endfunction

" •”ñ‡¬«‘‚©‚çAw’è‚³‚ê‚½•¶š‚ğŠÜ‚Şs‚ğŒŸõ‚µ‚Ä•\¦‚·‚é
function! s:ShowHelpBushuDic(ch)
  let lines = s:ListBushuHelp(a:ch)
  call s:SelectWindowByName(s:helpbufname)
  if empty(lines)
    return -1
  endif
  let lnum = line('.')
  if lnum == 1
    let lnum = 0
  else
    " ƒoƒbƒtƒ@“ª‚Å‚È‚¯‚ê‚Î‹æØ‚è‚Ì‹ós‘}“üB’¼‘O‚ª•¡”s‚Ì•”ñ«‘“à—e‚Ì•K—v
    call add(lines, '')
  endif
  let failed = append(lnum, lines)
  if failed
    return -2
  endif
  return 0
endfunction

" •”ñ‡¬•ÏŠ·ƒwƒ‹ƒv‚É•\¦‚·‚és‚Ì”z—ñ‚ğ•Ô‚·
function! s:ListBushuHelp(ch)
  let lines = s:SearchBushuHelp(a:ch)
  if !empty(lines)
    return lines
  endif
  return s:SearchBushuDic(a:ch)
endfunction

" bushu.helpƒtƒ@ƒCƒ‹‚©‚çAw’è‚³‚ê‚½•¶š‚ğŠÜ‚Şs‚ğŒŸõ‚·‚é
function! s:SearchBushuHelp(ch)
  let lines = []
  if !s:BushuHelp_FileOpen()
    return lines
  endif
  silent! normal! G$
  if search('^' . a:ch, 'w') != 0
    call add(lines, getline('.'))
    while search('^' . a:ch, 'W') != 0
      call add(lines, getline('.'))
    endwhile
  endif
  quit!
  return lines
endfunction

" •”ñ‡¬«‘‚©‚çAw’è‚³‚ê‚½•¶š‚ğŠÜ‚Şs‚ğŒŸõ‚·‚é
function! s:SearchBushuDic(ch)
  let lines = []
  if !s:Bushu_FileOpen()
    return lines
  endif
  silent! normal! G$
  if search(a:ch, 'w') != 0
    call add(lines, getline('.'))
    while search(a:ch, 'W') != 0
      call add(lines, getline('.'))
    endwhile
  endif
  quit!
  return lines
endfunction

function! s:KeymapFile_GetName()
  let keymap = &keymap
  if strlen(keymap) == 0
    let keymap = g:tcvime_keymap_for_help
    if strlen(keymap) == 0
      echo 'tcvime•¶šƒwƒ‹ƒv•\¦‚É‚ÍAkeymapƒIƒvƒVƒ‡ƒ“‚©g:tcvime_keymap_for_help‚Ìİ’è—v'
      return ''
    endif
  endif

  let kmfile = globpath(&rtp, "keymap/" . keymap . "_" . &encoding . ".vim")
  if filereadable(kmfile) != 1
    let kmfile = globpath(&rtp, "keymap/" . keymap . ".vim")
    if filereadable(kmfile) != 1
      return ''
    endif
  endif
  return kmfile
endfunction

" w’è‚³‚ê‚½•¶š‚ğ“ü—Í‚·‚é‚½‚ß‚ÌƒXƒgƒ[ƒN‚ğkeymapƒtƒ@ƒCƒ‹‚©‚çŒŸõ‚·‚é
function! s:SearchKeymap(ch)
  if exists('s:kanji2seqdict')
    return get(s:kanji2seqdict, a:ch, '')
  endif
  let s:kanji2seqdict = {}

  let kmfile = s:KeymapFile_GetName()
  if kmfile == ''
    return ''
  endif
  silent execute 'sv ' . kmfile
  if search('loadkeymap', 'w') == 0
    quit!
    return ''
  endif
  let lines = getline(line('.') + 1, '$')
  quit!

  call filter(lines, 'v:val !~ "^\""')
  call filter(lines, 'v:val !~ "^$"')
  for line in lines
    let m = matchlist(line, '\([^ 	]\+\)[ 	]\+\([^ 	]\+\)')
    if !empty(m)
      let s:kanji2seqdict[m[2]] = substitute(m[1], '<Space>', ' ', 'g')
    endif
  endfor
  return get(s:kanji2seqdict, a:ch, '')
endfunction

"==============================================================================
"				    «‘ŒŸõ

" SelectWindowByName(name)
"   Acitvate selected window by a:name.
function! s:SelectWindowByName(name)
  let num = bufwinnr('^' . a:name . '$')
  if num > 0 && num != winnr()
    execute num . 'wincmd w'
  endif
  return num
endfunction

" Œğ‚º‘‚«•ÏŠ·«‘ƒf[ƒ^ƒtƒ@ƒCƒ‹‚ğƒI[ƒvƒ“
function! s:Candidate_FileOpen(foredit)
  if s:SelectWindowByName(s:candidate_file) > 0
    if a:foredit
      set noreadonly
      set buflisted
    endif
    return 1
  endif
  if filereadable(s:candidate_file) != 1
    return 0
  endif
  let cmd = 'sv '
  if a:foredit
    let cmd = 'sp '
  endif
  silent execute cmd . s:candidate_file
  nnoremap <buffer> <silent> <C-Y> :<C-U>call <SID>MazegakiDic_CandSelect()<CR>
  " Œó•â–³‚µA©“®ŠJn‚³‚ê‚½«‘•ÒW‚ğƒLƒƒƒ“ƒZƒ‹‚µ‚½‚¢ê‡—pB
  nnoremap <buffer> <silent> <C-E> :<C-U>call <SID>MazegakiDic_Cancel()<CR>
  if !a:foredit
    set nobuflisted
  endif
  return 1
endfunction

" ŒŸõ‚Ég—p‚·‚éó‘Ô•Ï”
let s:last_keyword = ''
let s:last_candidate = ''
let s:last_candidate_list = []
let s:is_katuyo = 0

" «‘‚©‚ç–¢Šm’è•¶š—ñ‚ğŒŸõ
" @return -1:«‘‚ªŠJ‚¯‚È‚¢ê‡, 0:•¶š—ñ‚ªŒ©‚Â‚©‚ç‚È‚¢ê‡,
"   1:Œó•â‚ª1‚Â‚¾‚¯Œ©‚Â‚©‚Á‚½ê‡, 2:Œó•â‚ª2‚ÂˆÈãŒ©‚Â‚©‚Á‚½ê‡
function! s:CandidateSearch(keyword, finish)
  let s:last_keyword = a:keyword
  let s:last_candidate = ''
  let altbufnr = bufnr('')
  if !s:Candidate_FileOpen(0)
    return -1
  endif

  let origpos = getpos('.')
  if search('^' . a:keyword . ' ', 'cw') == 0
    let s:last_candidate_list = []
    let ret = 0
  else
    let candstr = substitute(getline('.'), '^' . a:keyword . ' ', '', '')
    let s:last_candidate_list = split(candstr, '/')
    let ret = len(s:last_candidate_list)
    if ret > 0
      let s:last_candidate = s:last_candidate_list[0]
    endif
  endif
  " Œó•â–³‚µ¨Œğ‚º‘‚««‘•ÒW¨Œğ‚º‘‚«•ÏŠ·‚Ìê‡‚ÉA•ÒW’†‚ÌˆÊ’u‚É–ß‚·‚½‚ß
  call setpos('.', origpos)
  if ret > 0
    if !&modified
      quit
    endif
    return ret
  endif
  " Œó•â–³‚µ
  " Œğ‚º‘‚«•ÏŠ·«‘•ÒW‚ğ©“®ŠJn
  if a:finish && g:tcvime_mazegaki_edit_nocand
    if bufnr('') != altbufnr
      " Šm’è‘€ì‚ÅŒ³‚Ìƒoƒbƒtƒ@‚É–ß‚ê‚é‚æ‚¤‚ÉA’¼‘O‚É‚¢‚½ƒoƒbƒtƒ@”Ô†‚ğæ‚Á‚Ä‚¨‚­
      let b:altbufnr = altbufnr
    " else Œğ‚º‘‚««‘•ÒW’†‚É‚³‚ç‚ÉŒğ‚º‘‚«•ÏŠ·‚µ‚½ê‡‚Í‚»‚Ì‚Ü‚Ü
    endif
    call tcvime#MazegakiDic_Edit(1)
  elseif !&modified
    quit
  endif
  return ret
endfunction

" Œğ‚º‘‚««‘‚Ì•ÒW‚ğŠ®—¹‚µAŒğ‚º‘‚««‘ã‚ÌƒJ[ƒ\ƒ‹ˆÊ’u‚ÌŒó•â‚ğŠm’è‚·‚é
function! s:MazegakiDic_CandSelect()
  let [lnum, beg] = searchpos('/\zs', 'bc', line('.'))
  if beg == 0
    let [lnum, beg] = searchpos('/\zs', '', line('.'))
  endif
  let [lnum, end] = searchpos('\ze/', '', line('.'))
  let chars = matchstr(getline('.'), '\%' . beg . 'c' . '.*\%' . end . 'c')
  let s:last_candidate = chars
  let s:last_keyword = matchstr(getline('.'), '^[^ ]*')
  let bufnr = b:altbufnr
  xit

  execute bufwinnr(bufnr) . 'wincmd w'
  let s:status_line = line('.')
  execute "normal! a\<ESC>"
  let s:status_colend = col("'^.")
  let s:status_column = s:status_colend - strlen(s:last_keyword)
  let inschars = s:InputFix(col("'^"))
  let s:last_count = 0
  call s:InsertString(inschars)
endfunction

" Œğ‚º‘‚««‘‚ğ•ÒW—p‚ÉŠJ‚¢‚ÄA’¼‘O‚É•ÏŠ·‚µ‚½“Ç‚İ‚ğŒŸõ‚·‚é
function! tcvime#MazegakiDic_Edit(addnew)
  let altbufnr = bufnr('')
  if !s:Candidate_FileOpen(1)
    return -2
  endif
  " :TcvimeEditMazegakiƒRƒ}ƒ“ƒhÀs—p
  if !exists('b:altbufnr')
    let b:altbufnr = altbufnr
  endif
  " ’¼‘O‚ªŒğ‚º‘‚«•ÏŠ·‚Å‚È‚¢ê‡‚àA«‘ƒtƒ@ƒCƒ‹‚ÍŠJ‚­
  if s:last_keyword == ''
    return -1
  endif
  let ret = search('^' . s:last_keyword . ' ', 'cw')
  if ret
    call search(' /', 'e')
    return ret
  endif
  " “Ç‚İ‚ª–³‚¯‚ê‚ÎV‚½‚É‘}“ü
  if a:addnew
    execute 'normal! ggO' . s:last_keyword . ' /' . s:last_keyword . "/\<ESC>"
  endif
  return 0
endfunction

" Œó•â–³‚µA©“®ŠJn‚³‚ê‚½«‘•ÒW‚ğƒLƒƒƒ“ƒZƒ‹‚µ‚½‚¢ê‡—pB
function! s:MazegakiDic_Cancel()
  " (VƒGƒ“ƒgƒŠ—p‚Ìs‘}“ü‚ğundo‚µ‚ÄquitB
  " :quit!‚¾‚ÆA«‘‚ğ–{“–‚É•ÒW’†‚Ìê‡‚ÉAŒë‚Á‚Ä<C-E>‚ğ‰Ÿ‚·‚Æì‹Æ‚ª¸‚í‚ê‚é)
  if &modified
    undo
  endif
  quit
endfunction

" Œğ‚º‘‚«•ÏŠ·‚ÅŠm’è‚µ‚½Œó•â‚ğŠwK‚µ‚ÄAŒó•âƒŠƒXƒg“àˆÊ’u‚ğˆÚ“®‚µ‚ÄA«‘•Û‘¶
function! s:LearnCand(str)
  let origpos = getpos('.')
  let ret = tcvime#MazegakiDic_Edit(0)
  if ret == -2
    return
  elseif ret <= 0
    quit
    return
  endif
  let editing = &modified " «‘•ÒW’†‚ÌŒğ‚º‘‚«•ÏŠ·‚ÌŠm’è‚©‚Ç‚¤‚©
  let candstr = strpart(getline('.'), col('.') - 1)
  let candlist = split(candstr, '/', 1)
  " ['', 'Œó•â1', 'Œó•â2', 'Œó•â3', ...., '']
  let i = index(candlist, a:str)
  let moveto = g:tcvime_movecandto + 1
  if i <= moveto " ŠwK‘ÎÛŠO‚ÌˆÊ’u‚É‚ ‚é‚©AŠù‚ÉŠwKÏ‚İ‚ÌˆÊ’u‚Ìê‡‚Í•ÏX•s—v
    if !editing
      quit
    else
      call setpos('.', origpos)
    endif
    return
  endif
  call remove(candlist, i)
  call insert(candlist, a:str, moveto)
  call setline('.', s:last_keyword . ' ' . join(candlist, '/'))
  if !editing
    wq
  else
    call setpos('.', origpos)
  endif
endfunction

" •”ñƒwƒ‹ƒvƒtƒ@ƒCƒ‹‚ğƒI[ƒvƒ“
function! s:BushuHelp_FileOpen()
  if filereadable(s:bushuhelp_file) != 1
    return 0
  endif
  if s:SelectWindowByName(s:bushuhelp_file) < 0
    silent execute 'sv '.s:bushuhelp_file
    set nobuflisted
  endif
  return 1
endfunction

" •”ñ‡¬«‘ƒf[ƒ^ƒtƒ@ƒCƒ‹‚ğƒI[ƒvƒ“
function! s:Bushu_FileOpen()
  if filereadable(s:bushu_file) != 1
    return 0
  endif
  if s:SelectWindowByName(s:bushu_file) < 0
    silent execute 'sv '.s:bushu_file
    set nobuflisted
  endif
  return 1
endfunction

" •”ñ‡¬•ÏŠ·
function! s:BushuConvert(char1, char2)
  let retchar = s:BushuHelpSearch(a:char1, a:char2)
  if s:BushuCharOK(retchar, a:char1, a:char2)
    return retchar
  endif
  return s:BushuSearch(a:char1, a:char2)
endfunction

" •”ñƒwƒ‹ƒvƒtƒ@ƒCƒ‹‚ğŒŸõ‚µ‚Ä•”ñ‡¬•ÏŠ·
function! s:BushuHelpSearch(char1, char2)
  if !s:BushuHelp_FileOpen()
    return ''
  endif
  " —á: "™BƒCê* “`E" (*‚ªŒã’u‚³‚ê‚Ä‚¢‚ê‚Î‹t‡‚Å‚àOK)
  if search('\%(^.\| \)\%(' . a:char1 . a:char2 . '\*\?\|' . a:char2 . a:char1 . '\*\)\%( \|$\)', 'cw') != 0
    let retchar = matchstr(getline('.'), '^.')
  else
    let retchar = ''
  endif
  quit!
  return retchar
endfunction

" “™‰¿•¶š‚ğŒŸõ‚µ‚Ä•Ô‚·B“™‰¿•¶š‚ª‚È‚¢ê‡‚Í‚à‚Æ‚Ì•¶š‚»‚Ì‚à‚Ì‚ğ•Ô‚·
function! s:BushuAlternative(ch)
  if !s:Bushu_FileOpen()
    return a:ch
  endif
  if search('^.' . a:ch . '$', 'w') != 0
    let retchar = matchstr(getline('.'), '^.')
  else
    let retchar = a:ch
  endif
  quit!
  return retchar
endfunction

" char1‚Æchar2‚ğ‚±‚Ì‡”Ô‚Å‡¬‚µ‚Ä‚Å‚«‚é•¶š‚ğŒŸõ‚µ‚Ä•Ô‚·B
" Œ©‚Â‚©‚ç‚È‚¢ê‡‚Í''‚ğ•Ô‚·
function! s:BushuSearchCompose(char1, char2)
  if !s:Bushu_FileOpen()
    return ''
  endif
  if search('^.' . a:char1 . a:char2, 'w') != 0
    let retchar = matchstr(getline('.'), '^.')
  else
    let retchar = ''
  endif
  quit!
  return retchar
endfunction

" w’è‚³‚ê‚½•¶š‚ğ2‚Â‚Ì•”ñ‚É•ª‰ğ‚·‚éB
" •ª‰ğ‚µ‚½•”ñ‚ğs:decomp1, s:decomp2‚ÉƒZƒbƒg‚·‚éB
" @return 1: •ª‰ğ‚É¬Œ÷‚µ‚½ê‡A0: •ª‰ğ‚Å‚«‚È‚©‚Á‚½ê‡
function! s:BushuDecompose(ch)
  if !s:Bushu_FileOpen()
    return 0
  endif
  if search('^' . a:ch . '..', 'w') != 0
    let chars = matchstr(getline('.'), '^...')
    let s:decomp1 = substitute(chars, '^.\(.\).', '\1', '')
    let s:decomp2 = matchstr(chars, '.$')
    let ret = 1
  else
    let ret = 0
  endif
  quit!
  return ret
endfunction

" ‡¬Œã‚Ì•¶š‚ª‹ó‚Å‚È‚­AŒ³‚Ì•¶š‚Å‚à‚È‚¢‚±‚Æ‚ğŠm”F
" @param ch ‡¬Œã‚Ì•¶š
" @param char1 Œ³‚Ì•¶š
" @param char2 Œ³‚Ì•¶š
" @return 1: ch‚ª‹ó‚Å‚àchar1‚Å‚àchar2‚Å‚à‚È‚¢ê‡B0: ‚»‚êˆÈŠO‚Ìê‡
function! s:BushuCharOK(ch, char1, char2)
  if strlen(a:ch) > 0 && a:ch !=# a:char1 && a:ch !=# a:char2
    return 1
  else
    return 0
  endif
endfunction

" •”ñ‡¬•ÏŠ·«‘‚ğŒŸõ
function! s:BushuSearch(char1, char2)
  let char1 = a:char1
  let char2 = a:char2
  let i = 0
  while i < 2
    " ‚»‚Ì‚Ü‚Ü‡¬‚Å‚«‚é?
    let retchar = s:BushuSearchCompose(char1, char2)
    if s:BushuCharOK(retchar, char1, char2)
      return retchar
    endif

    " “™‰¿•¶š‚Ç‚¤‚µ‚Å‡¬‚Å‚«‚é?
    if !exists("ch1alt")
      let ch1alt = s:BushuAlternative(char1)
    endif
    if !exists("ch2alt")
      let ch2alt = s:BushuAlternative(char2)
    endif
    let retchar = s:BushuSearchCompose(ch1alt, ch2alt)
    if s:BushuCharOK(retchar, char1, char2)
      return retchar
    endif

    " “™‰¿•¶š‚ğ•”ñ‚É•ª‰ğ
    if !exists("ch1a1")
      if s:BushuDecompose(ch1alt) == 1
	let ch1a1 = s:decomp1
	let ch1a2 = s:decomp2
	unlet s:decomp1
	unlet s:decomp2
      else
	let ch1a1 = ''
	let ch1a2 = ''
      endif
    endif
    if !exists("ch2a1")
      if s:BushuDecompose(ch2alt) == 1
	let ch2a1 = s:decomp1
	let ch2a2 = s:decomp2
	unlet s:decomp1
	unlet s:decomp2
      else
	let ch2a1 = ''
	let ch2a2 = ''
      endif
    endif

    let lench1a1 = strlen(ch1a1)
    let lench1a2 = strlen(ch1a2)
    let lench2a1 = strlen(ch2a1)
    let lench2a2 = strlen(ch2a2)
    let lench1alt = strlen(ch1alt)
    let lench2alt = strlen(ch2alt)

    " ˆø‚«Z
    if lench1a1 > 0 && lench1a2 > 0 && ch1a2 ==# ch2alt
      let retchar = ch1a1
      if s:BushuCharOK(retchar, char1, char2)
	return retchar
      endif
    endif
    if lench1a1 > 0 && lench1a2 > 0 && ch1a1 ==# ch2alt
      let retchar = ch1a2
      if s:BushuCharOK(retchar, char1, char2)
	return retchar
      endif
    endif

    " ˆê•û‚ª•”•i‚É‚æ‚é‘«‚µZ
    if lench1alt > 0 && lench2a1 > 0
      let retchar = s:BushuSearchCompose(ch1alt, ch2a1)
      if s:BushuCharOK(retchar, char1, char2)
	return retchar
      endif
    endif
    if lench1alt > 0 && lench2a2 > 0
      let retchar = s:BushuSearchCompose(ch1alt, ch2a2)
      if s:BushuCharOK(retchar, char1, char2)
	return retchar
      endif
    endif
    if lench1a1 > 0 && lench2alt > 0
      let retchar = s:BushuSearchCompose(ch1a1, ch2alt)
      if s:BushuCharOK(retchar, char1, char2)
	return retchar
      endif
    endif
    if lench1a2 > 0 && lench2alt > 0
      let retchar = s:BushuSearchCompose(ch1a2, ch2alt)
      if s:BushuCharOK(retchar, char1, char2)
	return retchar
      endif
    endif

    " —¼•û‚ª•”•i‚É‚æ‚é‘«‚µZ
    if lench1a1 > 0 && lench2a1 > 0
      let retchar = s:BushuSearchCompose(ch1a1, ch2a1)
      if s:BushuCharOK(retchar, char1, char2)
	return retchar
      endif
    endif
    if lench1a1 > 0 && lench2a2 > 0
      let retchar = s:BushuSearchCompose(ch1a1, ch2a2)
      if s:BushuCharOK(retchar, char1, char2)
	return retchar
      endif
    endif
    if lench1a2 > 0 && lench2a1 > 0
      let retchar = s:BushuSearchCompose(ch1a2, ch2a1)
      if s:BushuCharOK(retchar, char1, char2)
	return retchar
      endif
    endif
    if lench1a2 > 0 && lench2a2 > 0
      let retchar = s:BushuSearchCompose(ch1a2, ch2a2)
      if s:BushuCharOK(retchar, char1, char2)
	return retchar
      endif
    endif

    " •”•i‚É‚æ‚éˆø‚«Z
    if lench1a2 > 0 && lench2a1 > 0 && ch1a2 ==# ch2a1
      let retchar = ch1a1
      if s:BushuCharOK(retchar, char1, char2)
	return retchar
      endif
    endif
    if lench1a2 > 0 && lench2a2 > 0 && ch1a2 ==# ch2a2
      let retchar = ch1a1
      if s:BushuCharOK(retchar, char1, char2)
	return retchar
      endif
    endif
    if lench1a1 > 0 && lench2a1 > 0 && ch1a1 ==# ch2a1
      let retchar = ch1a2
      if s:BushuCharOK(retchar, char1, char2)
	return retchar
      endif
    endif
    if lench1a1 > 0 && lench2a2 > 0 && ch1a1 ==# ch2a2
      let retchar = ch1a2
      if s:BushuCharOK(retchar, char1, char2)
	return retchar
      endif
    endif

    " •¶š‚Ì‡‚ğ‹t‚É‚µ‚Ä‚â‚Á‚Ä‚İ‚é
    let t = char1  | let char1  = char2  | let char2 = t
    let t = ch1alt | let ch1alt = ch2alt | let ch2alt = t
    let t = ch1a1  | let ch1a1  = ch2a1  | let ch2a1 = t
    let t = ch1a2  | let ch1a2  = ch2a2  | let ch2a2 = t
    let i = i + 1
  endwhile

  " ‡¬‚Å‚«‚È‚©‚Á‚½
  return ''
endfunction

"==============================================================================
"				  Š¿šƒe[ƒuƒ‹

" Š¿šƒe[ƒuƒ‹ƒtƒ@ƒCƒ‹‚ğŠJ‚­
function! tcvime#KanjiTable_FileOpen()
  if filereadable(s:kanjitable_file) != 1
    echo 'Š¿šƒe[ƒuƒ‹ƒtƒ@ƒCƒ‹‚ª“Ç‚ß‚Ü‚¹‚ñ: <' . s:kanjitable_file . '>'
    return
  endif
  if s:SelectWindowByName(s:kanjitable_file) < 0
    silent execute 'sv '.s:kanjitable_file
  endif
  nnoremap <buffer> <silent> <CR> :<C-U>call <SID>KanjiTable_CopyChar()<CR>
  nnoremap <buffer> <silent> q :<C-U>quit<CR>
endfunction

" Š¿šƒe[ƒuƒ‹ƒoƒbƒtƒ@‚©‚ç’¼‹ß‚Ìƒoƒbƒtƒ@‚ÉŠ¿š‚ğƒRƒs[‚·‚é
function! s:KanjiTable_CopyChar()
  let ch = matchstr(getline('.'), '\%' . col('.') . 'c.')
  execute "normal! \<C-W>pa" . ch . "\<ESC>\<C-W>p"
endfunction

"==============================================================================
" Œó•â‘I‘ğƒoƒbƒtƒ@

" Œó•â‘I‘ğƒoƒbƒtƒ@‚ğŠJ‚­
function! s:Candwin_Open()
  if s:SelectWindowByName(s:candbufname) < 0
    execute "silent normal! :sp " . s:candbufname . "\<CR>"
    set buftype=nofile
    set bufhidden=delete
    set noswapfile
    set nobuflisted
  endif
  %d _
  nnoremap <buffer> <silent> <CR> :<C-U>call <SID>Candwin_Select()<CR>
  nnoremap <buffer> <silent> <C-Y> :<C-U>call <SID>Candwin_Select()<CR>
  nnoremap <buffer> <silent> q :<C-U>quit<CR>
  nnoremap <buffer> <silent> <C-E> :<C-U>quit<CR>
endfunction

" Œó•â‘I‘ğƒoƒbƒtƒ@‚ğ•Â‚¶‚é
function! s:Candwin_Close()
  if s:SelectWindowByName(s:candbufname) > 0
    bwipeout!
  endif
endfunction

" Œó•â‚ğƒZƒbƒg‚·‚é
function! s:Candwin_SetCands(candlist)
  call s:Candwin_Open()

  " Œó•â‘I‘ğ—pƒL[‚Ìƒ‰ƒxƒ‹‚ğ’Ç‰Á
  let lenlist = map(copy(a:candlist), 'strlen(v:val)')
  let maxlen = max(lenlist)
  let items = []
  let i = 0
  let len = len(a:candlist)
  while i < len
    let key = ''
    if i < len(g:tcvime#selectkeys)
      let key = repeat(' ', maxlen - lenlist[i] + 1) . g:tcvime#selectkeys[i]
      execute 'nnoremap <buffer> <silent> ' . key . ' :<C-U>call <SID>Candwin_SelectIndex(' . i . ')<CR>'
    endif
    call add(items, a:candlist[i] . key)
    let i += 1
  endwhile
  call append(0, items)
  silent! $g/^$/d _
  setlocal nomodifiable
  call cursor(1, 1)
  wincmd p
endfunction

" Œ»İs‚ÌŒó•â‚ğŠm’è‚·‚é
function! s:Candwin_Select()
  let s:last_candidate = s:last_candidate_list[line('.') - 1]
  bwipeout!
  call s:FixCandidate()
endfunction

" w’èindex‚ÌŒó•â‚ğŠm’è‚·‚é
function! s:Candwin_SelectIndex(index)
  call cursor(a:index + 1, 1)
  call s:Candwin_Select()
endfunction

let &cpo = s:save_cpo
