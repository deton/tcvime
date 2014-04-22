" vi:set ts=8 sts=2 sw=2 tw=0:
scriptencoding utf-8

" autoload/tcvime.vim - utility functions for tcvime.
"
" Maintainer: KIHARA Hideto <deton@m1.interq.or.jp>
" Last Change: 2014-04-22

let s:save_cpo = &cpo
set cpo&vim

if !exists("tcvime_mazegaki_edit_nocand")
  let tcvime_mazegaki_edit_nocand = 0
endif
if !exists("tcvime_keymap")
  let tcvime_keymap = get(g:, 'tcvime_keymap_for_help', &keymap)
endif
if !exists("tcvime_use_helptbl")
  let tcvime_use_helptbl = 1
endif
if !exists("tcvime_hide_helptbl_mark")
  let tcvime_hide_helptbl_mark = 0
endif

if !exists("tcvime_keyboard")
  let tcvime_keyboard = "1 1 2 2 3 3 4 4 5 5 6 6 7 7 8 8 9 9 0 0 \<CR>q q w w e e r r t t y y u u i i o o p p \<CR>a a s s d d f f g g h h j j k k l l ; ; \<CR>z z x x c c v v b b n n m m , , . . / / "
  " 数字キーの段を表示しない場合は次の文字列を使うようにする(qwerty)
"  let tcvime_keyboard = "q q w w e e r r t t y y u u i i o o p p \<CR>a a s s d d f f g g h h j j k k l l ; ; \<CR>z z x x c c v v b b n n m m , , . . / / "
endif

" 交ぜ書き変換で確定した候補の、候補リスト内の移動先位置(0が先頭。-1は移動無し)
if !exists("tcvime_movecandto")
  let tcvime_movecandto = -1
endif

" 交ぜ書き変換候補選択用キー。
"   let g:tcvime#selectkeys = ['1','2','3','4','5','6','7','8','9','0']
" 注: Insert modeでの候補選択の場合、
"     このキーで始まるlmapやimapがある場合は、|'timeoutlen'|待ちが発生。
if !exists('g:tcvime#selectkeys')
  let g:tcvime#selectkeys = []
endif

" 後置型シーケンス→漢字変換で、文字数が指定されていない際に、
" このパターンにマッチする文字が続く間は漢字に変換する。
if !exists("g:tcvime#seq2kanji_pat")
  let g:tcvime#seq2kanji_pat = "[0-9a-z ;,\\./']*"
endif

" 後置型カタカナ変換で、文字数が指定されていない際に、
" このパターンにマッチする文字が続く間はカタカナに変換する。
let g:tcvime#hira2kata_pat = '[ぁ-ん][ぁ-んー]*'
let g:tcvime#kata2hira_pat = '[ァ-ン][ァ-ンー]*'
" 読み開始位置マークを' '入力で代替する場合の設定例:
"   let g:tcvime#yomimarkchar = ' '
" '* アイテム'のように、*等の後の' 'は残したい場合の設定例:
"   let g:tcvime#yomimarkchar = '\%([[:graph:]] \zs\| \)'
if exists('g:tcvime#yomimarkchar')
  let g:tcvime#hira2kata_pat = g:tcvime#yomimarkchar . '\=' . tcvime#hira2kata_pat
  let g:tcvime#kata2hira_pat = g:tcvime#yomimarkchar . '\=' . tcvime#kata2hira_pat
endif

" 後置型英字変換の対象の読み文字列のパターン。' 'や日本語より後。
if !exists("g:tcvime#asciiconv_pat")
  let g:tcvime#asciiconv_pat = "[!-~]*"
endif

let g:tcvime#hiragana = 'ぁあぃいぅうぇえぉおかがきぎくぐけげこごさざしじすずせぜそぞただちぢっつづてでとどなにぬねのはばぱひびぴふぶぷへべぺほぼぽまみむめもゃやゅゆょよらりるれろゎわゐゑをん'
let g:tcvime#katakana = 'ァアィイゥウェエォオカガキギクグケゲコゴサザシジスズセゼソゾタダチヂッツヅテデトドナニヌネノハバパヒビピフブプヘベペホボポマミムメモャヤュユョヨラリルレロヮワヰヱヲン'

" 'imactivatefunc'用関数
function! tcvime#Activate(active)
  if a:active
    call tcvime#EnableKeymap()
  else
    call tcvime#DisableKeymap()
  endif
endfunction

" lmapをオンにする
function! tcvime#EnableKeymap()
  call tcvime#InputReset()
  " 既にオンの場合は何もしない
  if &iminsert !=# 0
    return ''
  endif
  call tcvime#SetKeymap(tcvime#getkeymap())
  if exists('*OnTcvimeEnableKeymap')
    call OnTcvimeEnableKeymap()
  endif
  return "\<C-^>"
endfunction

" lmapをオフにする
function! tcvime#DisableKeymap()
  call tcvime#InputReset()
  " 既にオフの場合は何もしない
  if &iminsert ==# 0
    return ''
  endif
  set iminsert=0
  if exists('*OnTcvimeDisableKeymap')
    call OnTcvimeDisableKeymap()
  endif
  return "\<C-^>"
endfunction

" g:tcvime_keymapを取得。未設定の場合は&keymapの値をg:tcvime_keymapに設定。
" (&keymapがtcvime.vimロード時に未設定で、
" 後から直接&keymapのみを設定された場合にも対応できるように)
function! tcvime#getkeymap()
  if g:tcvime_keymap != ''
    return g:tcvime_keymap
  endif
  if &l:keymap != ''
    let g:tcvime_keymap = &l:keymap
    return g:tcvime_keymap
  endif
  " &keymapや&l:keymapだと、:se keymap=tutcodepとしても空のままのようなので
  if &g:keymap != ''
    let g:tcvime_keymap = &g:keymap
    return g:tcvime_keymap
  endif
  echoerr 'g:tcvime_keymapが未設定。g:tcvime_keymapを設定してください'
  return ''
endfunction

" insert mode時に、直前の指定された文字数のひらがな→カタカナ変換を行う
" ための文字列を返す。
"
" 文字数として0を指定すると、
" g:tcvime#hira2kata_patにマッチする文字が続く間はカタカナ変換を行う。
" (tutcode keymapの場合、以下のようにカタカナ入力が可能。
"  「RKtltugiehe siqljflall」アぷりけーしょん→アプリケーション
" 最初の文字だけシフトキーを押しながら打鍵してカタカナで入力して、
" 後はシフトキー無しでひらがなで入力して、最後に後置型カタカナ変換で、
" 最初にカタカナで入力した文字までをまとめてカタカナ変換)
" (カタカナモードに切り替えたり「'rktltugiehe siqljfl'」、
" 全てシフトキーを押しながら打鍵したり「RKTLTUGIEHe SIQLJFL」よりも楽かも)
"
" 文字数として負の値を指定すると、ひらがなとして残す文字数の指定とみなす。
" (カタカナに変換する文字列が長くて文字数を数えるのが面倒な場合向け)
" 「例えばあぷりけーしょん」j2→「例えばアプリケーション」
function! tcvime#InputConvertKatakana(n)
  return tcvime#InputConvertKatakanaPos(col('.'), a:n)
endfunction

function! tcvime#InputConvertHiragana(n)
  return tcvime#InputConvertHiraganaPos(col('.'), a:n)
endfunction

" 後置型でカタカナ文字列を伸ばす
function! tcvime#InputConvertKatakanaExtend(n)
  let line = getline('.')
  let col = col('.')
  let pat = '\([ァ-ヶー]*\)\%' . col . 'c' " 現位置以前の連続するカタカナ
  if a:n == 0
    " 連続するカタカナ以前の連続するひらがなをカタカナに
    let pat = '\([ぁ-ん][ぁ-んー]*\)' . pat
  else
    " 現位置以前に位置する、連続するカタカナと指定文字数以下のひらがなを取得
    let pat = '\([ぁ-んー]\{,' . a:n . '}\)' . pat
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

" 直前の後置型カタカナ変換を縮める
function! tcvime#InputConvertKatakanaShrink(n)
  if s:prev_str == ''
    return ''
  endif
  " カーソル位置前が、直前に変換したカタカナ文字列でない場合は、何もしない。
  " カタカナ変換後に別の文字を入力した後で間違ってこの関数が呼ばれて、
  " 古いカタカナ変換の内容をもとに上書きすると困るので。
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
  " Shrinkを繰り返し呼んだ際に1文字ずつカタカナを縮めるため、prev_strを縮める
  let s:prev_str = strlist[2]
  " undo用にprev_strに対応するcommit_strをセット
  let s:commit_str = kata
  return substitute(str, '.', "\<BS>", 'g') . newstr
endfunction

" 直前の変換を取り消す
function! tcvime#InputConvertUndo()
  if s:prev_str == ''
    return ''
  endif
  " カーソル位置前が、直前に変換確定した文字列でない場合は、何もしない。
  " 変換確定後に別の文字を入力した後で間違ってこの関数が呼ばれて、
  " 古い変換の内容をもとに上書きすると困るので。
  let cnt = strlen(substitute(s:commit_str, '.', 'x', 'g'))
  let chars = matchstr(getline('.'), '.\{' . cnt . '}\%' . col('.') . 'c')
  if chars != s:commit_str
    let s:prev_str = ''
    return ''
  endif
  let str = s:commit_str
  let prev = s:prev_str
  " XXX: 多段undoは未対応
  let s:prev_str = ''
  let s:commit_str = prev
  return substitute(str, '.', "\<BS>", 'g') . prev
endfunction

" insert mode時に、指定位置から指定された文字数の文字列を取得して、
" ひらがな→カタカナ変換を行うための文字列を返す。
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

" insert mode時に、指定位置から指定された文字数の文字列を取得して、
" カタカナ→ひらがな変換を行うための文字列を返す。
function! tcvime#InputConvertHiraganaPos(col, n)
  let chars = s:AcquireYomi(g:tcvime#kata2hira_pat, a:col, a:n)
  if strlen(chars) == 0
    return ''
  endif
  let s:prev_str = chars
  let s:commit_str = tcvime#kata2hira(chars)
  if exists('g:tcvime#yomimarkchar')
    let s:prev_str = substitute(s:prev_str, '^' . g:tcvime#yomimarkchar . '\=', '', '')
    let s:commit_str = substitute(s:commit_str, '^' . g:tcvime#yomimarkchar . '\=', '', '')
  endif
  return substitute(chars, '.', "\<BS>", 'g') . s:commit_str
endfunction

" insert mode時に、指定位置から指定された文字数の文字列を取得する
function! s:AcquireYomi(pat, col, n)
  if a:n > 0
    return matchstr(getline('.'), '.\{,' . a:n . '}\%' . a:col . 'c')
  endif
  let col = a:col
  if a:n == 0
    " 前置型交ぜ書き変換の読みとして指定された文字列があれば、変換対象とする
    let yomi = s:StatusGet('.', col)
    if yomi != ''
      return yomi
    endif
  endif
  let line = getline('.')
  if a:n >= 0 && s:insert_line == line('.') && s:insert_col < a:col
    " Insert mode開始位置以降を変換対象とする。
    " (除外する文字数指定の場合は除く。どこからInsert modeを開始したかよりも、
    " 表示を見て残す文字数を指定したいので)
    " XXX: CTRL-Dでインデントを減らした場合には未対応
    let line = strpart(line, s:insert_col - 1)
    let col = a:col - s:insert_col + 1
  endif
  " patにマッチする文字を取得
  let chars = matchstr(line, a:pat . '\%' . col . 'c')
  if a:n < 0 " 除外する文字数
    let excnt = -a:n
    let chars = matchstr(chars, '.\{' . excnt . '}\zs.*$')
  endif
  return chars
endfunction

" 文字列をカタカナに変換する
function! tcvime#hira2kata(str)
  return tr(a:str, g:tcvime#hiragana, g:tcvime#katakana)
endfunction

" 文字列をひらがなに変換する
function! tcvime#kata2hira(str)
  return tr(a:str, g:tcvime#katakana, g:tcvime#hiragana)
endfunction

" 入力シーケンスを漢字に変換する。
" lmap無効のまま入力した文字列を、lmap有効にした直後に漢字に変換するため。
"   lmap t0 <C-R>=tcvime#InputConvertSeq2Kanji(0)<CR>
" 入力シーケンス中に後置型部首合成変換等があってもOK。
function! tcvime#InputConvertSeq2Kanji(n)
  let chars = s:AcquireYomi(g:tcvime#seq2kanji_pat, col('.'), a:n)
  if chars == ''
    return ''
  endif
  " "dlk<Esc>gaz0"で"だ"に変換された後で、"あ"を入力後、文字数指定無しの
  " カタカナ変換や交ぜ書き変換ができない問題を回避するため、insert_colを更新。
  " 元のinsert_colだと文字の途中のバイトでstrpart()されて壊れるのが原因。
  " "tltk<Esc>gaz0rkrik0"だと元のinsert_col以降が対象になって"ぱあイ"になる。
  let s:insert_col -= strlen(chars)
  call feedkeys(chars, 't')
  return substitute(chars, '.', "\<BS>", 'g')
endfunction

" 入力シーケンスを漢字に変換する。
" 入力シーケンス中の後置型部首合成変換等には未対応。
" tcvime#InputConvertSeq2KanjiShrink()により、後から変換を縮める操作に対応。
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

" 直前の入力シーケンス→漢字変換を縮める
" @param drop 縮めた文字を削除するかどうか
function! tcvime#InputConvertSeq2KanjiShrink(drop)
  if s:prev_str == ''
    return ''
  endif
  " カーソル位置前が、直前に変換した文字列でない場合は、何もしない
  let cnt = strlen(substitute(s:commit_str, '.', 'x', 'g'))
  let chars = matchstr(getline('.'), '.\{,' . cnt . '}\%' . col('.') . 'c')
  if chars != s:commit_str
    let s:prev_str = ''
    return ''
  endif
  let str = s:prev_str
  let strlist = matchlist(str, '\(.\)\(.*\)')
  " 縮めた1文字は削除。CTRL-Jでオンにしそこねてjだけ入った場合に削除したい。
  let kanji = s:Seq2Kanji(strlist[2])
  let newstr = kanji
  if !a:drop
    let newstr = strlist[1] . kanji
  endif
  " Shrinkを繰り返し呼んだ際に1文字ずつ縮めるため、prev_strを縮める
  let s:prev_str = strlist[2]
  " undo用にprev_strに対応するcommit_strをセット
  let commitprev = s:commit_str
  let s:commit_str = kanji
  return substitute(commitprev, '.', "\<BS>", 'g') . newstr
endfunction

" 入力シーケンスを漢字文字列に置換するための文字列を返す。
function! s:Seq2Kanji(str)
  if a:str == ''
    return ''
  endif
  let hassetkeymap = tcvime#EnableKeymap()

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
      " XXX: <Plug>や<C-R>=等には未対応
      let kstr .= kanji
    endif
    let s = strpart(s, i)
  endwhile
  if hassetkeymap != ''
    call tcvime#DisableKeymap()
  endif
  return kstr
endfunction

" 入力シーケンスを漢字文字列に置換する。feedkeys()を使用。
function! s:Seq2KanjiFeedkeys(str)
  if a:str == ''
    return
  endif
  let imonseq = tcvime#EnableKeymap()
  call feedkeys('gvc' . imonseq . a:str . "\<ESC>", 't')
endfunction

" 漢字文字列を入力シーケンスに変換する。
" 文字数を指定しない場合、英単語入力前にスペースを入力しておくと、
" スペース以降の文字を英字に変換して、区切り用に入力したスペースを削除。
" 例:" code "と打鍵すると" 演各 "と表示され、開始キーで、"code"に変換。
function! tcvime#InputConvertKanji2Seq(n)
  " "undo "→"趣・"、"code "→"演各 "
  let chars = s:AcquireYomi(' \=[^ ]\+ \=', col('.'), a:n)
  let seq = s:Kanji2Seq(chars, 1)
  let s:commit_str = seq
  return substitute(chars, '.', "\<BS>", 'g') . s:commit_str
endfunction

" 漢字文字列を入力シーケンスに変換する。
" 対象文字列は、Insert mode開始位置以降もしくは現在行全て。
" lmap有効になっているのに、URL等をペーストした場合に、元に戻すため。
function! tcvime#InputConvertKanji2SeqAll()
  let line = getline('.')
  let col = col('.')
  if s:insert_line == line('.') && s:insert_col < col
    " Insert mode開始位置以降を変換対象とする
    " XXX: CTRL-Dでインデントを減らした場合には未対応
    let line = strpart(line, s:insert_col - 1)
    let col = col - s:insert_col + 1
  endif
  let chars = matchstr(line, '.*' . '\%' . col . 'c')
  let seq = s:Kanji2Seq(chars, 0)
  let s:commit_str = seq
  return substitute(chars, '.', "\<BS>", 'g') . s:commit_str
endfunction

" 漢字文字列を入力シーケンスに置換するための文字列を返す。
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

" 漢字1文字を入力シーケンスに変換する。
function! s:Kanji2SeqChar(ch)
  if char2nr(a:ch) < 0x80
    return a:ch
  endif
  let seq = tcvime#kanji2seq#get(a:ch)
  if seq == ''
    return a:ch
  endif
  return seq
endfunction

" 設定
let s:candidate_file = globpath($VIM.','.&runtimepath, 'mazegaki.dic')
let s:bushuhelp_file = globpath($VIM.','.&runtimepath, 'bushu.help')
let s:kanjitable_file = globpath($VIM.','.&runtimepath, 'kanjitable.txt')
let s:helpbufname = fnamemodify(tempname(), ':p:h') . '/__TcvimeHelp__'
let s:helpbufname = substitute(s:helpbufname, '\\', '/', 'g')
let s:candbufname = fnamemodify(tempname(), ':p:h') . '/__TcvimeCand__'
let s:candbufname = substitute(s:candbufname, '\\', '/', 'g')

" keymapを設定する
function! tcvime#SetKeymap(keymapname)
  if &l:keymap !=# a:keymapname
    let g:tcvime_keymap = a:keymapname
    execute 'set keymap=' . a:keymapname
    if exists('*TcvimeCustomKeymap')
      call TcvimeCustomKeymap()
    endif
    return 2
  endif
  " 旧版のSetKeymap()と動作を合わせておくためiminsert=1にする処理も残しておく
  if &iminsert ==# 0
    setlocal iminsert=1
    return 1
  endif
  return 0
endfunction

let s:insert_line = 0
let s:insert_col = 1

" 後置型変換用に、挿入開始位置を記録
function! tcvime#OnInsertEnter()
  let s:insert_line = line('.')
  let s:insert_col = col('.')
endfunction

"==============================================================================
"				    入力制御

" 読みの入力を開始
function! tcvime#InputStart()
  call s:StatusSet()
  return ''
endfunction

function! tcvime#InputReset()
  call s:StatusReset()
  return ''
endfunction

" ASCII読みの入力を開始
function! tcvime#InputAsciiStart()
  call s:StatusSet()
  if &iminsert ==# 0
    return ''
  endif
  set iminsert=0
  return "\<C-^>"
endfunction

let s:completeyomi = ''
let s:completeop = 0

" Insert modeで後置型交ぜ書き変換を行う。
" 活用する語の変換の場合は、
" 変換対象文字列の末尾に「―」を追加して交ぜ書き辞書を検索する。
"
" tc2同様の後置型交ぜ書き変換を行うための設定例:
"     " 活用しない語
"     lmap <silent> 18 <C-R>=tcvime#InputPostConvert(1, 0)<CR>
"     lmap <silent> 28 <C-R>=tcvime#InputPostConvert(2, 0)<CR>
"     lmap <silent> 38 <C-R>=tcvime#InputPostConvert(3, 0)<CR>
"     lmap <silent> 48 <C-R>=tcvime#InputPostConvert(4, 0)<CR>
"     " 活用する語(ただしtc2と違って、読みの文字数には活用語尾は含まない)
"     lmap <silent> 29 <C-R>=tcvime#InputPostConvert(2, 1)<CR>
"     lmap <silent> 39 <C-R>=tcvime#InputPostConvert(3, 1)<CR>
"     lmap <silent> 49 <C-R>=tcvime#InputPostConvert(4, 1)<CR>
"     lmap <silent> 59 <C-R>=tcvime#InputPostConvert(5, 1)<CR>
" @param count 交ぜ書き変換の対象にする読みの文字数
" @param katuyo 活用する語の変換かどうか。0:活用しない, 1:活用する
function! tcvime#InputPostConvert(count, katuyo)
  let col = col('.')
  let s:status_line = line(".")
  let yomi = matchstr(getline('.'), '.\{' . a:count . '}\%' . col . 'c')
  let len = strlen(yomi)
  if len == 0
    let s:last_keyword = ''
    let s:last_count = 0
    call s:StatusReset()
    return ''
  endif
  let s:status_column = col - len
  return s:InputConvertSub(yomi, a:katuyo, 1)
endfunction

" 後置型交ぜ書き変換で、文字数が指定されていない際に、
" このパターンにマッチする文字を読みとして取得する。
let g:tcvime#yomi_pat = '[^	-~、。，．・「」（）]'
let s:mazegaki_yomi_max = 10

" Insert modeで後置型交ぜ書き変換を開始する。読み文字数指定無し。
function! tcvime#InputPostConvertStart(katuyo)
  let col = col('.')
  " 前置型交ぜ書き変換の読みとして指定された文字列があれば、変換対象とする
  let yomi = s:StatusGet('.', col)
  if yomi == ''
    let line = getline('.')
    let c = col
    if s:insert_line == line('.') && s:insert_col < col
      " Insert mode開始位置以降を変換対象とする
      " XXX: CTRL-Dでインデントを減らした場合には未対応
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
    " 候補が見つかった場合は終了
    if ret != '' || s:completeyomi != ''
      return ret
    endif
    " 候補が見つからなかったら、読みを1文字減らして検索
    let strlist = matchlist(yomi, '.\(.*\)')
    let yomi = strlist[1]
  endwhile
  let s:last_keyword = ''
  let s:last_count = 0
  call s:StatusReset()
  return ''
endfunction

" Insert modeで、直前が' 'の場合、英字変換を行う。
"   imap <silent> <unique> ; <C-R>=tcvime#InputPostConvertAscii(';')<CR>
" @param ch 直前が' 'でない場合に挿入する文字
function! tcvime#InputPostConvertAscii(ch)
  if s:IsPrevSpace() <= 0
    return a:ch
  endif
  let col = col('.') - 1
  let line = getline('.')
  let c = col
  if s:insert_line == line('.') && s:insert_col < col
    " Insert mode開始位置以降を変換対象とする
    " XXX: CTRL-Dでインデントを減らした場合には未対応
    let line = strpart(line, s:insert_col - 1)
    let c = col - s:insert_col + 1
  endif
  let yomi = matchstr(line, g:tcvime#asciiconv_pat . '\%' . c . 'c')
  if yomi == ''
    return a:ch
  endif
  let s:status_line = line('.')
  let len = strlen(yomi)
  let s:status_column = col - len
  " 交ぜ書き変換は現在colまでを対象にする想定なので、それと整合性を合わせるため
  let yomi .= ' '
  let ret = s:InputConvertSub(yomi, 0, 1)
  if ret != ''
    return ret . tcvime#EnableKeymap()
  endif
  if s:completeyomi != ''
    return ret
  endif
  let s:last_keyword = ''
  let s:last_count = 0
  call s:StatusReset()
  return "\<BS>" . tcvime#EnableKeymap()
endfunction

" 交ぜ書き変換の読みを縮める
function! tcvime#InputConvertShrink()
  if !pumvisible()
    return '>'
  endif
  return s:InputConvertShrinkPum()
endfunction

" 交ぜ書き変換の読みを縮める。popup menuが表示されている場合の処理。
function! s:InputConvertShrinkPum()
  let ret = s:InputConvertShrink()
  " 候補複数の場合、<C-E>をreturnしてpopupを閉じた後OnCursorMovedI()から再popup
  if ret == ''
    let s:completeop = 1
  endif
  return "\<C-E>" . ret
endfunction

" 交ぜ書き変換の読みを縮める。
function! s:InputConvertShrink()
  let yomi = s:completeyomi
  let oldlen = strlen(yomi)
  " 読みを1文字減らして検索
  let strlist = matchlist(yomi, '.\(.*\)')
  let yomi = strlist[1]
  while yomi != ''
    let len = strlen(yomi)
    let s:status_column += oldlen - len
    let ret = s:InputConvertSub(yomi, s:is_katuyo, 0)
    " 候補が見つかった場合は終了
    if s:last_candidate != ''
      return ret
    endif
    " 候補が見つからなかったら、読みを1文字減らして検索
    let oldlen = strlen(yomi)
    let strlist = matchlist(yomi, '.\(.*\)')
    let yomi = strlist[1]
  endwhile
  let s:last_keyword = ''
  let s:last_count = 0
  call s:StatusReset()
  return ''
endfunction

" 直前の後置型交ぜ書き変換を縮める。
" 候補1個のため自動確定された場合用。
function! tcvime#InputConvertShrinkLatest()
  if pumvisible()
    return s:InputConvertShrinkPum()
  endif
  let col = col('.')
  " カーソル位置前が、直前に変換した文字列でない場合は、何もしない。
  " 変換後に別の文字を入力した後で間違ってこの関数が呼ばれて、
  " 古い変換の内容をもとに上書きすると困るので。
  let cnt = strlen(substitute(s:commit_str, '.', 'x', 'g'))
  let chars = matchstr(getline('.'), '.\{,' . cnt . '}\%' . col . 'c')
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
    let s:status_column = col - len
    let ret = s:InputConvertSub(yomi, s:is_katuyo, 0)
    " 候補が見つかった場合は終了
    if ret != '' || s:completeyomi != ''
      return ret
    endif
    " 候補が見つからなかったら、読みを1文字減らして検索
    let strlist = matchlist(yomi, '.\(.*\)')
    let yomi = strlist[1]
  endwhile
  let s:last_keyword = ''
  let s:last_count = 0
  call s:StatusReset()
  return ''
endfunction

" コントロールキーを伴わないモード切り替え用。
" Insert modeで、直前が' 'の場合、lmapをオンにする
"   imap <silent> <unique> , <C-R>=tcvime#EnableKeymapOrInsertChar(',',1)<CR>
" (<Space>,にimapすると<Space>を押した際にtimeout待ちになるのが嫌なので。)
" @param ch 直前が' 'でない場合に挿入する文字
" @param removespace 直前が' 'の場合に、' 'を削除したい場合は1
function! tcvime#EnableKeymapOrInsertChar(ch, removespace)
  let prevspace = s:IsPrevSpace()
  if prevspace == 0
    return a:ch
  endif
  if prevspace == 1 && a:removespace == 1
    return "\<BS>" . tcvime#EnableKeymap()
  endif
  return tcvime#EnableKeymap()
endfunction

" カーソル位置直前が行頭か' 'かどうかを返す
" @return 1: カーソル位置直前が空白の場合。-1: 行頭の場合。0: それ以外
function! s:IsPrevSpace()
  let col = col('.')
  if col == 1
    return -1
  endif
  if s:insert_line == line('.') && s:insert_col >= col
    " Insert mode開始直後はそのまま入力
    " XXX: CTRL-Dでインデントを減らした場合には未対応
    return 0
  endif
  let prevch = matchstr(getline('.'), '.\{,1}\%' . col . 'c')
  if prevch == ' '
    return 1
  endif
  return 0
endfunction

" Insert modeで、読みがあれば交ぜ書き変換を開始し、無ければ' 'を返す。
function! tcvime#InputConvertOrSpace()
  let status = s:StatusGet('.', col('.'))
  if status == ''
    let s:last_keyword = ''
    return ' '
  endif
  let lastyomi = s:last_keyword
  let ret = s:InputConvertSub(status, 0, 1)
  " 候補無し && 前回と同じ読み→前回も変換不可。再度<Space>なので' 'を返す。
  " でないと、' 'を挿入できなくなったように見えるので。
  " <Plug>TcvimeIStartキーを押して読み開始位置リセットすれば挿入できるけど。
  " XXX: 再検索無しに、前回と同じ読みと位置s:status_columnかを確認した方が良い?
  if ret == '' && s:completeyomi == '' && lastyomi == status
    call s:StatusReset()
    return ' '
  endif
  if s:completeyomi != ''
    return ret
  endif
  return ret . tcvime#EnableKeymap()
endfunction

" Insert modeで交ぜ書き変換を行う。読みが無い場合は読み開始マークを付ける。
" @param katuyo 活用する語の変換かどうか。0:活用しない, 1:活用する
function! tcvime#InputConvertOrStart(katuyo)
  let status = s:StatusGet('.', col('.'))
  if status == ''
    let s:last_keyword = ''
    return tcvime#InputStart()
  endif
  let ret = s:InputConvertSub(status, a:katuyo, 1)
  if s:completeyomi != ''
    return ret
  endif
  return ret . tcvime#EnableKeymap()
endfunction

" Insert modeで交ぜ書き変換を行う。
" 活用する語の変換の場合は、
" 変換対象文字列の末尾に「―」を追加して交ぜ書き辞書を検索する。
" @param katuyo 活用する語の変換かどうか。0:活用しない, 1:活用する
" @param finish 候補が見つからなかった時にechoするかどうか。
function! s:InputConvertSub(yomi, katuyo, finish)
  let s:completeyomi = ''
  let inschars = ''
  let ncands = s:CandidateSearch(a:yomi, a:katuyo, a:finish)
  if ncands == 1
    if !pumvisible()
      let inschars = s:InputFix(col('.'))
    else
      " InputConvertShrink()から呼び出された場合。
      " さらにShrinkするためのs:commit_str更新や自動ヘルプ表示を
      " OnCursorMovedI()内でやるため、s:completeyomiを更新
      let s:completeyomi = a:yomi
      let inschars = substitute(a:yomi, '.', "\<BS>", 'g') . s:last_candidate
    endif
  elseif ncands > 0
    if !pumvisible()
      call s:InputConvertShowPopup(a:yomi)
    endif
  elseif ncands == 0
    if a:finish
      echo '交ぜ書き辞書中には見つかりません: <' . a:yomi . '>'
    endif
  else
    echo '交ぜ書き変換辞書ファイルのオープンに失敗しました: ' . s:candidate_file
  endif
  return inschars
endfunction

" 候補選択用ポップアップメニューを表示する
function! s:InputConvertShowPopup(yomi)
  let s:completeyomi = a:yomi
  inoremap > <C-R>=tcvime#InputConvertShrink()<CR>
  autocmd Tcvime CursorMovedI * call <SID>OnCursorMovedI()
  " 候補選択用menuキー追加
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

" complete()で選択された候補を取得して、自動ヘルプを表示する
function! s:OnCursorMovedI()
  if s:completeyomi == ''
    return
  endif
  autocmd! Tcvime CursorMovedI *

  " ポップアップメニュー操作用の一時mapを削除
  silent! iunmap >
  let i = 0
  let len = len(s:last_candidate_list)
  while i < len
    if i < len(g:tcvime#selectkeys)
      silent! execute 'iunmap ' . g:tcvime#selectkeys[i]
    endif
    let i += 1
  endwhile

  " 読みの伸縮操作による再検索で複数候補が見つかった場合、再度popup menuを表示
  if s:completeop == 1
    let s:completeop = 0
    call s:InputConvertShowPopup(s:StatusGet('.', col('.')))
    return
  endif

  let col = col('.')
  if col == 1
    " <CR>で確定して改行が挿入されて行頭になった場合。TODO: autoindent対応
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
    " XXX: ポップアップメニュー無効の場合、自動ヘルプ表示できない
    call s:ShowAutoHelp(s:completeyomi, status)
  endif
  let s:completeyomi = ''
  call s:StatusReset()
endfunction

" ポップアップメニュー表示時に、指定された番号の候補を確定する
function! tcvime#InputConvertSelectCand(idx)
  if !pumvisible()
    return g:tcvime#selectkeys[a:idx]
  endif
  let s:last_candidate = s:last_candidate_list[a:idx]
  let bs = substitute(s:completeyomi, '.', "\<BS>", 'g')

  " tcvime#InputAsciiStart()によるASCII読み入力後の変換確定時は、
  " EnableKeymapしたい。EnableKeymap()内でInputReset()されるが、
  " そうするとOnCursorMovedI()でのヘルプ表示ができないので、一時保存して再設定
  let save_status_line = s:status_line
  let save_status_column = s:status_column
  let save_status_colend = s:status_colend
  let enableseq = tcvime#EnableKeymap()
  let s:status_line = save_status_line
  let s:status_column = save_status_column
  let s:status_colend = save_status_colend
  return "\<C-E>" . bs . s:last_candidate . enableseq
endfunction

" 候補を確定して、確定した文字列を返す
function! s:InputFix(col)
  let inschars = ''
  let str = s:StatusGet('.', a:col)
  let inschars = s:last_candidate
  if strlen(inschars) > 0
    if g:tcvime_movecandto >= 0
      call s:LearnCand(inschars)
    endif
    call s:ShowAutoHelp(str, inschars)
    let bs = substitute(str, '.', "\<BS>", "g")
    let inschars = bs . inschars
  endif
  call s:StatusReset()
  return inschars
endfunction

" 直前の2文字の部首合成変換を行う
function! tcvime#InputConvertBushu(col)
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
    echo '部首合成変換ができませんでした: <' . char1 . '>, <' . char2 . '>'
    return ''
  endif
  call s:ShowAutoHelp(chars[0], retchar)
  let inschars = "\<BS>\<BS>" . retchar
  return inschars
endfunction

" operatorfuncとして、選択された文字列を交ぜ書き変換する
function! tcvime#ConvertOp(type, ...)
  let visual = 0
  if a:0  " Invoked from Visual mode
    let visual = 1
  endif
  call s:ConvertOpSub(a:type, visual, 0)
endfunction

" operatorfuncとして、選択された文字列を活用する語として交ぜ書き変換する
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

" operatorfuncとして、選択された文字列をカタカナに変換する
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
  " XXX: undoすると行頭に移動するのでいまいち
  "execute 's/\%' . a:beg . 'c.*\%' . col("'^") . 'c/\=tcvime#hira2kata(submatch(0))/'
  " XXX: 最後の文字が変換に含まれない。\%>'>にすると行末まで変換される
  "s/\%'<.*\%'>/\=tcvime#hira2kata(submatch(0))/
  call cursor(0, col)
endfunction

" operatorfuncとして、選択された文字列をひらがなに変換する
function! tcvime#ConvertOpHiragana(type, ...)
  let sel_save = &selection
  let &selection = "inclusive"

  if a:0  " Invoked from Visual mode, use '< and '> marks.
    call s:ConvertOpHiraganaSub(col("'<"), col("'>"))
  elseif a:type == 'char'
    call s:ConvertOpHiraganaSub(col("'["), col("']"))
  endif

  let &selection = sel_save
endfunction

function! s:ConvertOpHiraganaSub(beg, end)
  let col = col('.')
  call cursor(0, a:end)
  execute "normal! a\<ESC>"
  let chars = matchstr(getline('.'), '\%' . a:beg . 'c.*\%' . col("'^") . 'c')
  let inschars = substitute(chars, '.', "\<BS>", 'g') . tcvime#kata2hira(chars)
  call s:InsertString(inschars)
  call cursor(0, col)
endfunction

" operatorfuncとして、選択された文字列を入力シーケンスに変換する
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

" operatorfuncとして、選択された文字列を入力シーケンスとみなして漢字に変換する
function! tcvime#ConvertOpSeq2Kanji(type, ...)
  let sel_save = &selection
  let &selection = "inclusive"
  let reg_save = @@

  if a:0  " Invoked from Visual mode, use '< and '> marks.
    silent exe "normal! `<" . a:type . "`>y"
    call s:Seq2KanjiFeedkeys(@@)
  elseif a:type == 'char'
    silent exe "normal! `[v`]y"
    call s:Seq2KanjiFeedkeys(@@)
  endif

  let &selection = sel_save
  let @@ = reg_save
endfunction

" operatorfuncとして、選択された文字列の入力シーケンスをずらして漢字に変換。
" シーケンスがずれて意味不明な漢字文字列になったものを修復するため。
" 例: 「電地給月分動田新同 」→「うかもしれません。」
function! tcvime#ConvertOpShiftSeq(type, ...)
  let sel_save = &selection
  let &selection = "inclusive"
  let reg_save = @@

  if a:0  " Invoked from Visual mode, use '< and '> marks.
    silent exe "normal! `<" . a:type . "`>y"
    call s:ConvertOpShiftSeqSub(@@)
  elseif a:type == 'char'
    silent exe "normal! `[v`]y"
    call s:ConvertOpShiftSeqSub(@@)
  endif

  let &selection = sel_save
  let @@ = reg_save
endfunction

function! s:ConvertOpShiftSeqSub(chars)
  let seq = s:Kanji2Seq(a:chars, 0)
  let m = matchlist(seq, '.\(.*\)')
  if !empty(m)
    call s:Seq2KanjiFeedkeys(m[1])
  endif
endfunction

" 以前のConvertCount()に渡されたcount引数の値。
" countが0で実行された場合に以前のcount値を使うようにするため。
let s:last_count = 0

" 今の位置以前のcount文字を変換する
" @param count 変換する文字列の長さ
" @param katuyo 活用する語の変換かどうか。0:活用しない, 1:活用する
function! tcvime#ConvertCount(count, katuyo)
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
  if a:yomi == ''
    let s:last_keyword = ''
    let s:last_count = 0
    call s:StatusReset()
    return
  endif
  let ncands = s:CandidateSearch(a:yomi, a:katuyo, 1)
  if ncands > 1
    call s:Candwin_SetCands(s:last_candidate_list)
    call s:SelectWindowByName(s:candbufname)
  elseif ncands == 1
    call s:FixCandidate()
  elseif ncands == 0
    echo '交ぜ書き辞書中には見つかりません: <' . a:yomi . '>'
  else
    echo '交ぜ書き変換辞書ファイルのオープンに失敗しました: ' . s:candidate_file
  endif
endfunction

" ConvertCount()で変換を開始した候補を確定する
function! s:FixCandidate()
  call cursor(s:status_line, s:status_colend)
  execute "normal! a\<ESC>"
  let inschars = s:InputFix(col("'^"))
  let s:last_count = 0
  call s:InsertString(inschars)
endfunction

" 今の位置以前のcount文字をカタカナに変換する
" @param count 変換する文字列の長さ
function! tcvime#ConvertKatakana(count)
  execute "normal! a\<ESC>"
  let inschars = tcvime#InputConvertKatakanaPos(col("'^"), a:count)
  call s:InsertString(inschars)
endfunction

" 今の位置以前のcount文字をひらがなに変換する
" @param count 変換する文字列の長さ
function! tcvime#ConvertHiragana(count)
  execute "normal! a\<ESC>"
  let inschars = tcvime#InputConvertHiraganaPos(col("'^"), a:count)
  call s:InsertString(inschars)
endfunction

" 今の位置以前の2文字を部首合成変換する
function! tcvime#ConvertBushu()
  execute "normal! a\<ESC>"
  let inschars = tcvime#InputConvertBushu(col("'^"))
  call s:InsertString(inschars)
endfunction

" 指定された文字列をバッファにappendする
function! s:InsertString(inschars)
  if strlen(a:inschars) > 0
    let save_bs = &backspace
    set backspace=2
    execute "normal! a" . a:inschars . "\<ESC>"
    let &backspace = save_bs
  endif
endfunction

"==============================================================================
"			     未確定文字管理用関数群

"   未確定文字列が存在するかチェックする
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

"   未確定文字列を開始する
function! s:StatusSet()
  let s:status_line = line('.')
  let s:status_column = col('.')
  call s:StatusEcho()
endfunction

"   未確定文字列をリセットする
function! s:StatusReset()
  let s:status_line = 0
  let s:status_column = 0
  let s:status_colend = 0
endfunction

"   未確定文字列を「状態」として取得する
function! s:StatusGet(lnum, col)
  if !s:StatusIsEnable(a:lnum, a:col)
    return ''
  endif

  " 必要なパラメータを収集
  let stpos = s:status_column - 1
  let len = a:col - s:status_column
  let str = getline(a:lnum)

  return strpart(str, stpos, len)
endfunction

"   未確定文字列の開始位置と終了位置を表示(デバッグ用)
function! s:StatusEcho(...)
  echo '読み入力開始;<Leader><Space>:変換,<Leader>o:活用する語の変換'
  "echo "New conversion (line=".s:status_line." column=".s:status_column.")"
endfunction

" 状態リセット
call s:StatusReset()

"==============================================================================
" ヘルプ表示

" ヘルプ用バッファを開く
function! s:OpenHelpBuffer()
  if s:SelectWindowByName(s:helpbufname) < 0
    silent execute 'sp ' . s:helpbufname
    set buftype=nofile
    set bufhidden=delete
    set noswapfile
    set winfixheight
    set nobuflisted
    if g:tcvime_use_helptbl
      set filetype=tcvimehelp
      if g:tcvime_hide_helptbl_mark && has('conceal')
	setlocal conceallevel=2 concealcursor=nc
      endif
    endif
    nnoremap <buffer> <silent> q :<C-U>quit<CR>
  endif
  silent! %d _
  5wincmd _
endfunction

" ヘルプ用バッファを閉じる
function! tcvime#CloseHelpBuffer()
  if s:SelectWindowByName(s:helpbufname) > 0
    bwipeout!
  endif
endfunction

" カーソル位置の文字のヘルプ表を表示する
function! tcvime#ShowStrokeHelp()
  let ch = matchstr(getline('.'), '\%' . col('.') . 'c.')
  call s:ShowHelp([ch], 0)
endfunction

" Visual modeで選択されている文字列のヘルプ表を表示する
function! tcvime#ShowHelpVisual()
  let save_reg = @@
  silent execute 'normal! `<' . visualmode() . '`>y'
  call tcvime#ShowHelpForStr(substitute(@@, '\n', '', 'g'), 0)
  let @@ = save_reg
endfunction

" 変換で確定した文字列のヘルプ表を表示する
function! s:ShowAutoHelp(yomi, str)
  let s:prev_str = a:yomi
  let s:commit_str = a:str
  if matchstr(a:yomi, '[^\x00-\x7f]') == '' " ASCII変換の場合はヘルプ表示しない
    return
  endif
  let yomichars = split(a:yomi, '\zs')
  let chars = split(a:str, '\zs')
  " 読みで入力した漢字はヘルプ表示不要なので取り除く
  call filter(chars, 'index(yomichars, v:val) == -1')
  call s:ShowHelp(chars, 0)
endfunction

" 指定された文字列の各文字のヘルプ表を表示する
function! tcvime#ShowHelpForStr(str, forcebushu)
  let ar = split(a:str, '\zs')
  call s:ShowHelp(ar, a:forcebushu)
endfunction

" 指定された文字配列のヘルプ表を表示する
function! s:ShowHelp(ar, forcebushu)
  let save_hls = &hlsearch
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
      " echo '文字ヘルプ表表示に指定された文字が空です。無視します'
      continue
    endif
    call cursor(line('$'), 1)
    if a:forcebushu == 1
      let ret = s:ShowHelpBushuDic(ch)
    else
      let ret = s:ShowHelpChar(ch)
    endif
    if ret == -1 " ストローク表も部首合成辞書も表示できなかった場合
      call add(skipchars, ch)
      continue
    endif
    let numch += 1
    if ret == 0 " ShowHelpBushuDic
      continue
    endif
    " 表を横に並べる
    if lastcol == 0 " 最初の表の場合は変数初期化だけ
      let lastcol = col('$')
      let lastfrom = line('.')
      let width = lastcol + 2
      continue
    endif
    if lastcol + width >= winwidth " さらに並べるとはみ出す場合はそのままに
      let lastcol = col('$')
      let lastfrom = line('.')
      continue
    endif
    let ln = line('.')
    silent .,$-1g/^/s//　/
    call histdel('/', -1)
    call cursor(ln, 1)
    let save_reg = @@
    silent! execute "normal! \<C-V>Gk$x" . lastfrom . "G$p"
    let @@ = save_reg
    let lastcol = col('$')
    silent! execute ln . ',$-1g/^$/d _'
    call histdel('/', -1)
  endfor
  if numch == 0
    call tcvime#CloseHelpBuffer()
  else
    silent! $g/^$/d _ " 末尾の余分な空行を削除
    call histdel('/', -1)
    normal 1G
    " wincmd p
    execute bufwinnr(curbuf) . 'wincmd w'
  endif
  if len(skipchars) > 0
    redraw
    echo 'ヘルプ情報無し: <' . join(skipchars, ',') . '>'
  endif
  let &hlsearch = save_hls
endfunction

" 指定された文字のヘルプ表を表示する
function! s:ShowHelpChar(ch)
  let keyseq = tcvime#kanji2seq#get(a:ch)
  if strlen(keyseq) > 0
    call s:SelectWindowByName(s:helpbufname)
    if g:tcvime_use_helptbl
      let ret = s:ShowHelpTable(a:ch, keyseq)
      if ret >= 0
	return ret
      endif
    endif
    return s:ShowHelpSequence(a:ch, keyseq)
  else
    return s:ShowHelpBushuDic(a:ch)
  endif
endfunction

" 指定された文字とそのストロークを表にして表示する
function! s:ShowHelpSequence(ch, keyseq)
  let from = line('$')
  call append(line('.') - 1, split(g:tcvime_keyboard, "\<CR>"))
  let to = line('$') - 1 " 最終行は区切り用の空行なのでそれより前まで
  let range = from . ',' . to
  let keys = split(a:keyseq, '\zs')
  let i = 0
  for key in keys
    let i += 1
    silent! execute range . 's@\V' . escape(key, '\') . ' @' . i . '@'
  endfor
  silent! execute range . 's@^\(....................\). . @\1@e'
  silent! execute range . 's@^\(................\). . @\1@e'
  silent! execute range . 's@\(.\)\(.\)@\1\2@ge'
  silent! execute range . 's@\(.\). @\1@ge'
  silent! execute range . 's@. . @・@g'
  silent! execute range . 's@@ @ge'
  call cursor(from, 1)
  if search('\d', 'c', to) == 0
    " 表内に表示するもの(何番目のキー位置かを示す文字)が何も無い
    silent! execute range . 'd _'
    return -1
  endif
  call append(to, '    ' . a:ch)
  call cursor(from, 1)
  return 1
endfunction

" 指定された文字を含む漢字表を表示する
function! s:ShowHelpTable(ch, keyseq)
  let commonseq = strpart(a:keyseq, 1)
  let km = tcvime#getkeymap()
  try
    let tbl = get(g:tcvime#helptbl_{km}#tbl, commonseq, '')
  catch /^Vim\%((\a\+)\)\=:E121/ " E121: Undefined variable
    let g:tcvime_use_helptbl = 0
    return -1
  endtry
  if tbl == ''
    return -1
  endif

  let from = line('$')
  call append(line('.') - 1, split(tbl, "\n", 1))
  let to = line('.')
  call cursor(from, 1)

  " 第1打鍵を示す'^'追加
  let pat = '\V' . escape(a:ch, '\')
  if search(pat, 'c', to) == 0
    return -1
  endif
  let line = line('.')
  let col = col('.')
  " 桁合わせ用' 'を入れる
  silent! execute from . ',' . to . 's/\%' . col . 'c/ /'
  let col += 1
  " 第1打鍵を示す'^'を入れる
  silent! execute line . 's/ \%' . col . 'c/^/'
  " $のための桁合わせ用に既に' 'が入ってたら元に戻す
  silent! execute from . ',' . to . 's/  / /'
  silent! execute from . ',' . to . 's/ \^/^/'
  silent! execute from . ',' . to . 's/\$ /$/'
  " 最終(第2)打鍵と第1打鍵が同じ
  silent! execute from . ',' . to . 's/\$\^/+/'
  call cursor(from, 1)
  return 1
endfunction

" 部首合成辞書から、指定された文字を含む行を検索して表示する
function! s:ShowHelpBushuDic(ch)
  let lines = s:ListBushuHelp(a:ch)
  call s:SelectWindowByName(s:helpbufname)
  if empty(lines)
    return -1
  endif
  let lnum = line('.')
  if lnum == 1
    let lnum = 0
  endif
  call add(lines, '') " 区切りの空行追加。複数行の部首辞書内容の時必要
  let failed = append(lnum, lines)
  if failed
    return -2
  endif
  return 0
endfunction

" 部首合成変換ヘルプに表示する行の配列を返す
function! s:ListBushuHelp(ch)
  let lines = s:SearchBushuHelp(a:ch)
  if !empty(lines)
    return lines
  endif
  return s:SearchBushuDic(a:ch)
endfunction

" bushu.helpファイルから、指定された文字を含む行を検索する
function! s:SearchBushuHelp(ch)
  let lines = []
  if !s:BushuHelp_FileOpen()
    return lines
  endif
  silent! normal! G$
  let pat = '^\V' . escape(a:ch, '\')
  if search(pat, 'w') != 0
    call add(lines, getline('.'))
    while search(pat, 'W') != 0
      call add(lines, getline('.'))
    endwhile
  endif
  quit!
  return lines
endfunction

" 部首合成辞書から、指定された文字を含む行を検索する
function! s:SearchBushuDic(ch)
  let lines = []
  let pat = 'v:key =~ "' . a:ch . '" || v:val =~ "' . a:ch . '"'
  let alts = filter(copy(g:tcvime#bushudic#altchar), pat)
  for [key, value] in items(alts)
    call add(lines, value . key)
  endfor
  let dict = filter(copy(g:tcvime#bushudic#bushudic), pat)
  for [key, value] in items(dict)
    call add(lines, value . key)
  endfor
  return lines
endfunction

"==============================================================================
"				    辞書検索

" SelectWindowByName(name)
"   Acitvate selected window by a:name.
function! s:SelectWindowByName(name)
  let num = bufwinnr(a:name)
  if num > 0 && num != winnr()
    try
      execute num . 'wincmd w'
    catch /^Vim\%((\a\+)\)\=:E523/
      " command lineからヘルプウィンドウを閉じようとした場合などに発生
      return 0
    endtry
  endif
  return num
endfunction

" 交ぜ書き変換辞書データファイルをオープン
function! s:Candidate_FileOpen(foredit)
  if s:SelectWindowByName(s:candidate_file) > 0
    if a:foredit
      set noreadonly
      if a:foredit == 2
	set buflisted
      endif
    endif
    return 1
  endif
  if filereadable(s:candidate_file) != 1
    return 0
  endif
  if a:foredit == 1
    let cmd = 'sp +se\ nobuflisted'
  elseif a:foredit == 2
    let cmd = 'sp'
  else
    let cmd = 'sv +se\ nobuflisted'
  endif
  silent execute cmd s:candidate_file
  nnoremap <buffer> <silent> <C-Y> :<C-U>call <SID>MazegakiDic_CandSelect()<CR>
  " 候補無し時、自動開始された辞書編集をキャンセルしたい場合用。
  nnoremap <buffer> <silent> <C-E> :<C-U>call <SID>MazegakiDic_Cancel()<CR>
  return 1
endfunction

" 検索に使用する状態変数
let s:last_keyword = ''
let s:last_candidate = ''
let s:last_candidate_list = []
let s:is_katuyo = 0

" 辞書から未確定文字列を検索
" @param katuyo 活用する語の変換かどうか。0:活用しない, 1:活用する
" @return -1:辞書が開けない場合, 0:文字列が見つからない場合,
"   1:候補が1つだけ見つかった場合, 2:候補が2つ以上見つかった場合
function! s:CandidateSearch(keyword, katuyo, finish)
  let s:is_katuyo = a:katuyo
  " tcvime#InputPostConvertAscii()の場合、最後に' 'があるので除去
  let key = substitute(a:keyword, ' \+$', '', '')
  if s:is_katuyo
    let key .= '―'
  endif
  return s:CandidateSearchSub(key, a:finish)
endfunction

function! s:CandidateSearchSub(keyword, finish)
  let s:last_keyword = a:keyword
  let s:last_candidate = ''
  let altbufnr = bufnr('')
  if !s:Candidate_FileOpen(0)
    return -1
  endif

  let origpos = getpos('.')
  let pat = '^\V' . escape(a:keyword, '\') . ' '
  if search(pat, 'cw') == 0
    let s:last_candidate_list = []
    let ret = 0
  else
    let candstr = substitute(getline('.'), pat, '', '')
    let s:last_candidate_list = split(candstr, '/')
    let ret = len(s:last_candidate_list)
    if ret > 0
      let s:last_candidate = s:last_candidate_list[0]
    endif
  endif
  " 候補無し→交ぜ書き辞書編集→交ぜ書き変換の場合に、編集中の位置に戻すため
  call setpos('.', origpos)
  if ret > 0
    if !&modified
      quit
    endif
    return ret
  endif
  " 候補無し
  " 交ぜ書き変換辞書編集を自動開始
  if a:finish && g:tcvime_mazegaki_edit_nocand
    if bufnr('') != altbufnr
      " 確定操作で元のバッファに戻れるように、直前にいたバッファ番号を取っておく
      let b:altbufnr = altbufnr
    " else 交ぜ書き辞書編集中にさらに交ぜ書き変換した場合はそのまま
    endif
    call tcvime#MazegakiDic_Edit(0)
  elseif !&modified
    quit
  endif
  return ret
endfunction

" 交ぜ書き辞書の編集を完了し、交ぜ書き辞書上のカーソル位置の候補を確定する
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
  " tcvime#InputPostConvertAscii()の場合、
  " 最後にある' 'はs:last_keywordに含まれないので。
  let pat = '\V' . escape(s:last_keyword, '\') . ' \*\%' . s:status_colend . 'c'
  let i = match(getline('.'), pat)
  if i == -1
    let s:status_column = s:status_colend - strlen(s:last_keyword)
  else
    let s:status_column = i + 1 " index to column number
  endif
  let inschars = s:InputFix(col("'^"))
  let s:last_count = 0
  call s:InsertString(inschars)
  call tcvime#EnableKeymap()
endfunction

" 交ぜ書き辞書を編集用に開いて、直前に変換した読みを検索する
function! tcvime#MazegakiDic_Edit(autoupdate)
  let altbufnr = bufnr('')
  if a:autoupdate
    let foredit = 1
  else
    let foredit = 2
  endif
  if !s:Candidate_FileOpen(foredit)
    return -2
  endif
  " :TcvimeEditMazegakiコマンド実行時用
  if !exists('b:altbufnr')
    let b:altbufnr = altbufnr
  endif
  " 直前が交ぜ書き変換でない場合も、辞書ファイルは開く
  if s:last_keyword == ''
    return -1
  endif
  let pat = '^\V' . escape(s:last_keyword, '\') . ' '
  let ret = search(pat, 'cw')
  if ret
    call search(' /', 'e')
    return ret
  endif
  " 読みが無ければ新たに挿入
  if !a:autoupdate
    execute 'normal! ggO' . s:last_keyword . ' /' . s:last_keyword . "/\<ESC>"
  endif
  return 0
endfunction

" 候補無し時、自動開始された辞書編集をキャンセルしたい場合用。
function! s:MazegakiDic_Cancel()
  " (新エントリ用の行挿入をundoしてquit。
  " :quit!だと、辞書を本当に編集中の場合に、誤って<C-E>を押すと作業が失われる)
  if &modified
    undo
  endif
  quit
endfunction

" 交ぜ書き変換で確定した候補を学習して、候補リスト内位置を移動して、辞書保存
function! s:LearnCand(str)
  let origpos = getpos('.')
  let ret = tcvime#MazegakiDic_Edit(1)
  if ret == -2
    return
  elseif ret <= 0
    quit
    return
  endif
  let editing = &modified " 辞書編集中の交ぜ書き変換の確定かどうか
  let candstr = strpart(getline('.'), col('.') - 1)
  let candlist = split(candstr, '/', 1)
  " ['', '候補1', '候補2', '候補3', ...., '']
  let i = index(candlist, a:str)
  let moveto = g:tcvime_movecandto + 1
  if i <= moveto " 学習対象外の位置にあるか、既に学習済みの位置の場合は変更不要
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

" 部首ヘルプファイルをオープン
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

" 部首合成変換
function! s:BushuConvert(char1, char2)
  let retchar = s:BushuHelpSearch(a:char1, a:char2)
  if s:BushuCharOK(retchar, a:char1, a:char2)
    return retchar
  endif
  return s:BushuSearch(a:char1, a:char2)
endfunction

" 部首ヘルプファイルを検索して部首合成変換
function! s:BushuHelpSearch(char1, char2)
  if !s:BushuHelp_FileOpen()
    return ''
  endif
  " 例: "傳イ専* 伝・" (*が後置されていれば逆順でもOK)
  let e1 = escape(a:char1, '\')
  let e2 = escape(a:char2, '\')
  if search('\%(^.\| \)\%(\V' . e1 . e2 . '*\?\|' . e2 . e1 . '*\)\%( \|\$\)', 'cw') != 0
    let retchar = matchstr(getline('.'), '^.')
  else
    let retchar = ''
  endif
  quit!
  return retchar
endfunction

" 等価文字を検索して返す。等価文字がない場合はもとの文字そのものを返す
function! s:BushuAlternative(ch)
  return get(g:tcvime#bushudic#altchar, a:ch, a:ch)
endfunction

" char1とchar2をこの順番で合成してできる文字を検索して返す。
" 見つからない場合は''を返す
function! s:BushuSearchCompose(char1, char2)
  return get(g:tcvime#bushudic#bushudic, a:char1 . a:char2, '')
endfunction

" 指定された文字を2つの部首に分解する。
" 分解した部首をListで返す。分解できなかった場合は、['', '']を返す。
function! s:BushuDecompose(ch)
  if !exists('s:revbushudic')
    let s:revbushudic = {}
    for [key, value] in items(g:tcvime#bushudic#bushudic)
      let s:revbushudic[value] = key
    endfor
  endif
  let chars = get(s:revbushudic, a:ch, '')
  if chars == ''
    return ['', '']
  endif
  return split(chars, '\zs')
endfunction

" 合成後の文字が空でなく、元の文字でもないことを確認
" @param ch 合成後の文字
" @param char1 元の文字
" @param char2 元の文字
" @return 1: chが空でもchar1でもchar2でもない場合。0: それ以外の場合
function! s:BushuCharOK(ch, char1, char2)
  if strlen(a:ch) > 0 && a:ch !=# a:char1 && a:ch !=# a:char2
    return 1
  else
    return 0
  endif
endfunction

" 部首合成変換辞書を検索
function! s:BushuSearch(char1, char2)
  let char1 = a:char1
  let char2 = a:char2
  let i = 0
  while i < 2
    " そのまま合成できる?
    let retchar = s:BushuSearchCompose(char1, char2)
    if s:BushuCharOK(retchar, char1, char2)
      return retchar
    endif

    " 等価文字どうしで合成できる?
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

    " 等価文字を部首に分解
    if !exists("ch1a1")
      let [ch1a1, ch1a2] = s:BushuDecompose(ch1alt)
    endif
    if !exists("ch2a1")
      let [ch2a1, ch2a2] = s:BushuDecompose(ch2alt)
    endif

    let lench1a1 = strlen(ch1a1)
    let lench1a2 = strlen(ch1a2)
    let lench2a1 = strlen(ch2a1)
    let lench2a2 = strlen(ch2a2)
    let lench1alt = strlen(ch1alt)
    let lench2alt = strlen(ch2alt)

    " 引き算
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

    " 一方が部品による足し算
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

    " 両方が部品による足し算
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

    " 部品による引き算
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

    " 文字の順を逆にしてやってみる
    let t = char1  | let char1  = char2  | let char2 = t
    let t = ch1alt | let ch1alt = ch2alt | let ch2alt = t
    let t = ch1a1  | let ch1a1  = ch2a1  | let ch2a1 = t
    let t = ch1a2  | let ch1a2  = ch2a2  | let ch2a2 = t
    let i = i + 1
  endwhile

  " 合成できなかった
  return ''
endfunction

"==============================================================================
"				  漢字テーブル

" 漢字テーブルファイルを開く
function! tcvime#KanjiTable_FileOpen()
  if filereadable(s:kanjitable_file) != 1
    echo '漢字テーブルファイルが読めません: <' . s:kanjitable_file . '>'
    return
  endif
  if s:SelectWindowByName(s:kanjitable_file) < 0
    silent execute 'sv '.s:kanjitable_file
  endif
  nnoremap <buffer> <silent> <CR> :<C-U>call <SID>KanjiTable_CopyChar()<CR>
  nnoremap <buffer> <silent> q :<C-U>quit<CR>
endfunction

" 漢字テーブルバッファから直近のバッファに漢字をコピーする
function! s:KanjiTable_CopyChar()
  let ch = matchstr(getline('.'), '\%' . col('.') . 'c.')
  execute "normal! \<C-W>pa" . ch . "\<ESC>\<C-W>p"
endfunction

"==============================================================================
" 候補選択バッファ

" 候補選択バッファを開く
function! s:Candwin_Open()
  if s:SelectWindowByName(s:candbufname) < 0
    execute "silent normal! :sp " . s:candbufname . "\<CR>"
    set buftype=nofile
    set bufhidden=delete
    set noswapfile
    set nobuflisted
  endif
  setlocal modifiable
  silent! %d _
  nnoremap <buffer> <silent> <CR> :<C-U>call <SID>Candwin_Select()<CR>
  nnoremap <buffer> <silent> <C-Y> :<C-U>call <SID>Candwin_Select()<CR>
  nnoremap <buffer> <silent> q :<C-U>quit<CR>
  nnoremap <buffer> <silent> <C-E> :<C-U>quit<CR>
endfunction

" 候補選択バッファを閉じる
function! s:Candwin_Close()
  if s:SelectWindowByName(s:candbufname) > 0
    bwipeout!
  endif
endfunction

" 候補をセットする
function! s:Candwin_SetCands(candlist)
  call s:Candwin_Open()

  " 候補選択用キーのラベルを追加
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
  call histdel('/', -1)
  setlocal nomodifiable
  call cursor(1, 1)
  wincmd p
endfunction

" 現在行の候補を確定する
function! s:Candwin_Select()
  let s:last_candidate = s:last_candidate_list[line('.') - 1]
  bwipeout!
  call s:FixCandidate()
endfunction

" 指定indexの候補を確定する
function! s:Candwin_SelectIndex(index)
  call cursor(a:index + 1, 1)
  call s:Candwin_Select()
endfunction

let &cpo = s:save_cpo
