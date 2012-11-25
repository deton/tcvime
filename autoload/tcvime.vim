" vi:set ts=8 sts=2 sw=2 tw=0:
scriptencoding cp932

" autoload/tcvime.vim - utility functions for tcvime.
"
" Maintainer: KIHARA Hideto <deton@m1.interq.or.jp>
" Last Change: 2012-11-25

let s:save_cpo = &cpo
set cpo&vim

let g:tcvime#hira2kata_table = {
  \'あ':'ア','い':'イ','う':'ウ','え':'エ','お':'オ',
  \'か':'カ','き':'キ','く':'ク','け':'ケ','こ':'コ',
  \'さ':'サ','し':'シ','す':'ス','せ':'セ','そ':'ソ',
  \'た':'タ','ち':'チ','つ':'ツ','て':'テ','と':'ト',
  \'な':'ナ','に':'ニ','ぬ':'ヌ','ね':'ネ','の':'ノ',
  \'は':'ハ','ひ':'ヒ','ふ':'フ','へ':'ヘ','ほ':'ホ',
  \'ま':'マ','み':'ミ','む':'ム','め':'メ','も':'モ',
  \'や':'ヤ','ゆ':'ユ','よ':'ヨ',
  \'ら':'ラ','り':'リ','る':'ル','れ':'レ','ろ':'ロ',
  \'わ':'ワ','ゐ':'ヰ','ゑ':'ヱ','を':'ヲ',
  \'が':'ガ','ぎ':'ギ','ぐ':'グ','げ':'ゲ','ご':'ゴ',
  \'ざ':'ザ','じ':'ジ','ず':'ズ','ぜ':'ゼ','ぞ':'ゾ',
  \'だ':'ダ','ぢ':'ヂ','づ':'ヅ','で':'デ','ど':'ド',
  \'ば':'バ','び':'ビ','ぶ':'ブ','べ':'ベ','ぼ':'ボ',
  \'ぱ':'パ','ぴ':'ピ','ぷ':'プ','ぺ':'ペ','ぽ':'ポ',
  \'ぁ':'ァ','ぃ':'ィ','ぅ':'ゥ','ぇ':'ェ','ぉ':'ォ',
  \'ゃ':'ャ','ゅ':'ュ','ょ':'ョ',
  \'ん':'ン','っ':'ッ','ゎ':'ヮ',
\}

" insert mode時に、直前の指定された文字数のひらがな→カタカナ変換を行う
" ための文字列を返す。
" tutcode keymapで後置型カタカナ変換を行うための設定例:
"     lmap al1 <C-R>=tcvime#InputConvertKatakana(1)<CR>
"     lmap al2 <C-R>=tcvime#InputConvertKatakana(2)<CR>
"     lmap al3 <C-R>=tcvime#InputConvertKatakana(3)<CR>
"     lmap al4 <C-R>=tcvime#InputConvertKatakana(4)<CR>
"     lmap al5 <C-R>=tcvime#InputConvertKatakana(5)<CR>
"     lmap al6 <C-R>=tcvime#InputConvertKatakana(6)<CR>
"     lmap al7 <C-R>=tcvime#InputConvertKatakana(7)<CR>
"     lmap al8 <C-R>=tcvime#InputConvertKatakana(8)<CR>
"     lmap al9 <C-R>=tcvime#InputConvertKatakana(9)<CR>
function! tcvime#InputConvertKatakana(n)
  return tcvime#InputConvertKatakanaPos(col('.'), a:n)
endfunction

function! tcvime#InputConvertKatakanaPos(col, n)
  let inschars = ''
  if a:col > a:n
    " 指定された文字数の文字列を取得
    let pat = ''
    let i = 0
    while i < a:n
      let pat .= '.'
      let i += 1
    endwhile
    let chars = matchstr(getline('.'), pat . '\%' . a:col . 'c')
    let subst = substitute(chars, '.', '\=tcvime#hira2kata(submatch(0))', 'g')
    let inschars = substitute(pat, '\.', "\<BS>", 'g') . subst
  endif
  return inschars
endfunction

function! tcvime#hira2kata(s)
  return get(g:tcvime#hira2kata_table, a:s, a:s)
endfunction

let &cpo = s:save_cpo
