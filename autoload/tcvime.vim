" vi:set ts=8 sts=2 sw=2 tw=0:
scriptencoding cp932

" autoload/tcvime.vim - utility functions for tcvime.
"
" Maintainer: KIHARA Hideto <deton@m1.interq.or.jp>
" Last Change: 2012-12-09

let s:save_cpo = &cpo
set cpo&vim

" 後置型カタカナ変換で、文字数が指定されていない際に、
" このパターンにマッチする文字が続く間はカタカナに変換する。
let g:tcvime#hira2kata_pat = '[ぁ-んー・]*'

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
" tutcode keymapで後置型カタカナ変換を行うための設定例:
"     lmap all <C-R>=tcvime#InputConvertKatakana(0)<CR>
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
  let col = col('.')
  let cnt = a:n
  if cnt == 0
    " 前置型交ぜ書き変換の読みとして指定された文字列があれば、変換対象とする
    let yomi = s:StatusGet('.', col)
    if yomi != ''
      let cnt = strlen(substitute(yomi, '.', 'x', 'g'))
    endif
  endif
  return tcvime#InputConvertKatakanaPos(col, cnt)
endfunction

function! tcvime#InputConvertKatakanaPos(col, n)
  if a:n == 0
    " g:tcvime#hira2kata_patにマッチする文字を取得
    let chars = matchstr(getline('.'), g:tcvime#hira2kata_pat . '\%' . a:col . 'c')
  else
    let chars = matchstr(getline('.'), '.\{,' . a:n . '}\%' . a:col . 'c')
  endif
  if strlen(chars) == 0
    return ''
  endif
  let subst = substitute(chars, '.', '\=tcvime#hira2kata(submatch(0))', 'g')
  return substitute(chars, '.', "\<BS>", 'g') . subst
endfunction

function! tcvime#hira2kata(s)
  return get(g:tcvime#hira2kata_table, a:s, a:s)
endfunction

" 設定
let s:candidate_file = globpath($VIM.','.&runtimepath, 'mazegaki.dic')
let s:bushu_file = globpath($VIM.','.&runtimepath, 'bushu.rev')
let s:kanjitable_file = globpath($VIM.','.&runtimepath, 'kanjitable.txt')
let s:helpbufname = fnamemodify(tempname(), ':p:h') . '/__TcvimeHelp__'
let s:helpbufname = substitute(s:helpbufname, '\\', '/', 'g')
let s:candbufname = fnamemodify(tempname(), ':p:h') . '/__TcvimeCand__'
let s:candbufname = substitute(s:candbufname, '\\', '/', 'g')
" 辞書ファイルが:ls等で表示されるようにするかどうか。0:表示されない,1:表示する
let s:buflisted = 0

" keymapを設定する
function! tcvime#SetKeymap(keymapname)
  if &l:keymap !=# a:keymapname
    let &l:keymap = a:keymapname
    if exists('*TcvimeCustomKeymap')
      call TcvimeCustomKeymap()
    endif
  else
    let &l:iminsert = 1
  endif
endfunction

"   マッピングを有効化
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
  if !hasmapto('<Plug>TcvimeIConvert')
    silent! imap <unique> <silent> <Leader><Space> <Plug>TcvimeIConvert
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
  inoremap <script> <silent> <Plug>TcvimeIConvert <C-R>=<SID>InputConvert(0)<CR>
  inoremap <script> <silent> <Plug>TcvimeIKatuyo <C-R>=<SID>InputConvert(1)<CR>
  inoremap <script> <silent> <Plug>TcvimeIBushu <C-R>=<SID>InputConvertBushu(col('.'))<CR>
  nnoremap <script> <silent> <Plug>TcvimeNConvert :<C-U>call <SID>ConvertCount(v:count, 0)<CR>
  nnoremap <script> <silent> <Plug>TcvimeNKatuyo :<C-U>call <SID>ConvertCount(v:count, 1)<CR>
  nnoremap <script> <silent> <Plug>TcvimeNKatakana :<C-U>call <SID>ConvertKatakana(v:count)<CR>
  nnoremap <script> <silent> <Plug>TcvimeNBushu :<C-U>call <SID>ConvertBushu()<CR>
  nnoremap <script> <silent> <Plug>TcvimeNHelp :<C-U>call <SID>ShowStrokeHelp()<CR>
  nnoremap <script> <silent> <Plug>TcvimeNKanjiTable :<C-U>call tcvime#KanjiTable_FileOpen()<CR>
  nnoremap <script> <silent> <Plug>TcvimeNOpConvert :set opfunc=tcvime#ConvertOp<CR>g@
  nnoremap <script> <silent> <Plug>TcvimeNOpKatuyo :set opfunc=tcvime#ConvertOpKatuyo<CR>g@
  vnoremap <script> <silent> <Plug>TcvimeVHelp :<C-U>call <SID>ShowHelpVisual()<CR>
  vnoremap <script> <silent> <Plug>TcvimeVConvert :<C-U>call tcvime#ConvertOp(visualmode(), 1)<CR>
  vnoremap <script> <silent> <Plug>TcvimeVKatuyo :<C-U>call tcvime#ConvertOpKatuyo(visualmode(), 1)<CR>

  if set_mapleader
    unlet g:mapleader
  endif

  augroup Tcvime
  autocmd!
  execute "autocmd BufReadCmd ".s:helpbufname." call <SID>Help_BufReadCmd()"
  autocmd CursorMovedI * call <SID>OnCursorMovedI()
  augroup END
endfunction

"   マッピングを無効化
function! tcvime#MappingOff()
  let set_mapleader = 0
  if !exists('g:mapleader')
    let g:mapleader = "\<C-K>"
    let set_mapleader = 1
  else
    let save_mapleader = g:mapleader
  endif
  let g:mapleader = s:mapleader
  " TODO: tcvime以外でmapされたものをunmapしないようにする
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

"==============================================================================
"				    入力制御

" 読みの入力を開始
function! s:InputStart()
  call s:StatusSet()
  return ''
endfunction

let s:completeyomi = ''

" Insert modeで後置型交ぜ書き変換を行う。
" 活用する語の変換の場合は、
" 変換対象文字列の末尾に「―」を追加して交ぜ書き辞書を検索する。
"
" tc2同様の後置型交ぜ書き変換を行うための設定例:
"     " 活用しない語
"     lmap 18 <C-R>=tcvime#InputPostConvert(1, 0)<CR>
"     lmap 28 <C-R>=tcvime#InputPostConvert(2, 0)<CR>
"     lmap 38 <C-R>=tcvime#InputPostConvert(3, 0)<CR>
"     lmap 48 <C-R>=tcvime#InputPostConvert(4, 0)<CR>
"     " 活用する語(ただしtc2と違って、読みの文字数には活用語尾は含まない)
"     lmap 29 <C-R>=tcvime#InputPostConvert(2, 1)<CR>
"     lmap 39 <C-R>=tcvime#InputPostConvert(3, 1)<CR>
"     lmap 49 <C-R>=tcvime#InputPostConvert(4, 1)<CR>
"     lmap 59 <C-R>=tcvime#InputPostConvert(5, 1)<CR>
" @param count 交ぜ書き変換の対象にする読みの文字数
" @param katuyo 活用する語の変換かどうか。0:活用しない, 1:活用する
function! tcvime#InputPostConvert(count, katuyo)
  let s:is_katuyo = 0
  let s:completeyomi = ''
  let s:status_line = line(".")
  let yomi = matchstr(getline('.'), '.\{' . a:count . '}\%' . col('.') . 'c')
  let len = strlen(yomi)
  if len == 0
    let s:last_keyword = ''
    let s:last_count = 0
    call s:StatusReset()
    return ''
  endif
  let inschars = ''
  let s:status_column = col('.') - len
  let s:is_katuyo = a:katuyo
  if s:is_katuyo
    let key = yomi . '―'
  else
    let key = yomi
  endif
  let ncands = s:CandidateSearch(key)
  if ncands == 1
    let inschars = s:InputFix(col('.'))
  elseif ncands > 0
    let s:completeyomi = yomi
    call complete(s:status_column, s:last_candidate_list)
  elseif ncands == 0
    echo '交ぜ書き辞書中には見つかりません: <' . yomi . '>'
  else
    echo '交ぜ書き変換辞書ファイルのオープンに失敗しました: ' . s:candidate_file
  endif
  return inschars
endfunction

" Insert modeで交ぜ書き変換を行う。
" 活用する語の変換の場合は、
" 変換対象文字列の末尾に「―」を追加して交ぜ書き辞書を検索する。
" @param katuyo 活用する語の変換かどうか。0:活用しない, 1:活用する
function! s:InputConvert(katuyo)
  let inschars = ''
  let s:is_katuyo = 0
  let s:completeyomi = ''
  let status = s:StatusGet('.', col('.'))
  let len = strlen(status)
  if len > 0
    let s:is_katuyo = a:katuyo
    if s:is_katuyo
      let key = status . '―'
    else
      let key = status
    endif
    let ncands = s:CandidateSearch(key)
    if ncands == 1
      let inschars = s:InputFix(col('.'))
    elseif ncands > 0
      let s:completeyomi = status
      call complete(s:status_column, s:last_candidate_list)
    elseif ncands == 0
      echo '交ぜ書き辞書中には見つかりません: <' . status . '>'
    else
      echo '交ぜ書き変換辞書ファイルのオープンに失敗しました: ' . s:candidate_file
    endif
  else
    let s:last_keyword = ''
    call s:InputStart()
  endif
  return inschars
endfunction

" complete()で選択された候補を取得して、自動ヘルプを表示する
function! s:OnCursorMovedI()
  if s:completeyomi == ''
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
  if status == s:completeyomi
    return
  endif
  " XXX: ポップアップメニュー無効の場合、自動ヘルプ表示できない
  call s:ShowAutoHelp(s:completeyomi, status)
  let s:completeyomi = ''
  call s:StatusReset()
endfunction

" 確定しようとしている候補が問題ないかどうかチェック
function! s:IsCandidateOK(str)
  if strlen(a:str) > 0 && strlen(s:last_candidate) > 0
    if s:is_katuyo && s:last_keyword ==# (a:str . '―') || s:last_keyword ==# a:str
      return 1
    endif
  endif
  return 0
endfunction

" 候補を確定して、確定した文字列を返す
function! s:InputFix(col)
  let inschars = ''
  let str = s:StatusGet('.', a:col)
  if s:IsCandidateOK(str)
    let inschars = s:last_candidate
    if strlen(inschars) > 0
      call s:ShowAutoHelp(str, inschars)
      let bs = substitute(str, '.', "\<BS>", "g")
      let inschars = bs . inschars
    endif
  endif
  call s:StatusReset()
  return inschars
endfunction

" 直前の2文字の部首合成変換を行う
function! s:InputConvertBushu(col)
  let inschars = ''
  if a:col > 2
    let chars = matchstr(getline('.'), '..\%' . a:col . 'c')
    let char1 = matchstr(chars, '^.')
    let char2 = matchstr(chars, '.$')
    let retchar = s:BushuSearch(char1, char2)
    let len = strlen(retchar)
    if len > 0
      let inschars = "\<BS>\<BS>" . retchar
      call s:ShowAutoHelp(chars, retchar)
    else
      echo '部首合成変換ができませんでした: <' . char1 . '>, <' . char2 . '>'
    endif
  endif
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

" 以前のConvertCount()に渡されたcount引数の値。
" countが0で実行された場合に以前のcount値を使うようにするため。
let s:last_count = 0

" 今の位置以前のcount文字を変換する
" @param count 変換する文字列の長さ
" @param katuyo 活用する語の変換かどうか。0:活用しない, 1:活用する
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
      let chars = chars . '―'
    endif
    let ncands = s:CandidateSearch(chars)
    if ncands > 1
      call s:Candwin_SetCands(s:last_candidate_list)
      call s:SelectWindowByName(s:candbufname)
    elseif ncands == 1
      call s:FixCandidate()
    elseif ncands == 0
      echo '交ぜ書き辞書中には見つかりません: <' . chars . '>'
    else
      echo '交ぜ書き変換辞書ファイルのオープンに失敗しました: ' . s:candidate_file
    endif
  else
    let s:last_keyword = ''
    let s:last_count = 0
    call s:StatusReset()
  endif
endfunction

" ConvertCount()で変換を開始した候補を確定する
function! s:FixCandidate()
  call cursor(0, s:status_colend)
  execute "normal! a\<ESC>"
  let inschars = s:InputFix(col("'^"))
  let s:last_count = 0
  call s:InsertString(inschars)
endfunction

" 今の位置以前のcount文字をカタカナに変換する
" @param count 変換する文字列の長さ
function! s:ConvertKatakana(count)
  execute "normal! a\<ESC>"
  let inschars = tcvime#InputConvertKatakanaPos(col("'^"), a:count)
  call s:InsertString(inschars)
endfunction

" 今の位置以前の2文字を部首合成変換する
function! s:ConvertBushu()
  execute "normal! a\<ESC>"
  let inschars = s:InputConvertBushu(col("'^"))
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
  if s:status_line != ln || s:status_column <= 0 || s:status_column > a:col
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

" 空のヘルプ用バッファを作る
function! s:Help_BufReadCmd()
endfunction

" ヘルプ用バッファを開く
function! s:OpenHelpBuffer()
  if s:SelectWindowByName(s:helpbufname) < 0
    execute "silent normal! :sp " . s:helpbufname . "\<CR>"
    set buftype=nofile
    set bufhidden=delete
    set noswapfile
    set winfixheight
    if !s:buflisted
      set nobuflisted
    endif
    nnoremap <buffer> <silent> q :<C-U>quit<CR>
  endif
  %d _
  5wincmd _
endfunction

" ヘルプ用バッファを閉じる
function! tcvime#CloseHelpBuffer()
  if s:SelectWindowByName(s:helpbufname) > 0
    bwipeout!
  endif
endfunction

" カーソル位置の文字のヘルプ表を表示する
function! s:ShowStrokeHelp()
  let ch = matchstr(getline('.'), '\%' . col('.') . 'c.')
  call s:ShowHelp([ch], 0)
endfunction

" Visual modeで選択されている文字列のヘルプ表を表示する
function! s:ShowHelpVisual()
  let save_reg = @@
  silent execute 'normal! `<' . visualmode() . '`>y'
  call tcvime#ShowHelpForStr(substitute(@@, '\n', '', 'g'), 0)
  let @@ = save_reg
endfunction

" 変換で確定した文字列のヘルプ表を表示する
function! s:ShowAutoHelp(yomi, str)
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
  let keymap = &keymap
  if strlen(keymap) == 0
    let keymap = g:tcvime_keymap_for_help
    if strlen(keymap) == 0
      echo 'tcvime文字ヘルプ表示には、keymapオプションかg:tcvime_keymap_for_helpの設定要'
      return
    endif
  endif
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
      let ret = s:ShowHelpChar(ch, keymap)
    endif
    if ret == -1 " ストローク表も部首合成辞書も表示できなかった場合
      call add(skipchars, ch)
      continue
    elseif ret == -2 " XXX: ポップアップメニュー無効時
      call tcvime#CloseHelpBuffer()
      return
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
    let save_reg = @@
    execute "normal! \<C-V>GkI  \<ESC>\<C-V>Gk$x" . lastfrom . "G$p"
    let @@ = save_reg
    let lastcol = col('$')
    silent! execute ln . ',$-1d _'
  endfor
  if numch == 0
    call tcvime#CloseHelpBuffer()
  else
    silent! $g/^$/d _ " 末尾の余分な空行を削除
    normal 1G
    " wincmd p
    execute bufwinnr(curbuf) . 'wincmd w'
  endif
  if len(skipchars) > 0
    redraw
    echo '文字ヘルプで表示できる情報がありません: <' . join(skipchars, ',') . '>'
  endif
endfunction

" 指定された文字のヘルプ表を表示する
function! s:ShowHelpChar(ch, keymap)
  let keyseq = s:SearchKeymap(a:ch, a:keymap)
  if strlen(keyseq) > 0
    call s:SelectWindowByName(s:helpbufname)
    return s:ShowHelpSequence(a:ch, keyseq)
  else
    return s:ShowHelpBushuDic(a:ch)
  endif
endfunction

" 指定された文字とそのストロークを表にして表示する
function! s:ShowHelpSequence(ch, keyseq)
  let from = line('$')
  let v:errmsg = ''
  silent! execute 'normal! O' . g:tcvime_keyboard . "\<CR>\<ESC>"
  if v:errmsg != '' " XXX: ポップアップメニュー無効時、E523: Not allowed here
    return -2
  endif
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
  silent! execute range . 's@. . @・@g'
  silent! execute range . 's@@ @ge'
  call cursor(to - 1, 1)
  silent! execute 'normal! A    ' . a:ch . "\<ESC>"
  call cursor(from, 1)
  return 1
endfunction

" 部首合成辞書から、指定された文字を含む行を検索して表示する
function! s:ShowHelpBushuDic(ch)
  let lines = s:SearchBushuDic(a:ch)
  call s:SelectWindowByName(s:helpbufname)
  if strlen(lines) > 0
    " バッファ頭でなければ区切りの空行挿入。直前が複数行の部首辞書内容の時必要
    if line('.') > 1
      silent! execute "normal! o\<ESC>"
    endif
    let v:errmsg = ''
    silent! execute 'normal! O' . lines . "\<ESC>"
    if v:errmsg != '' " XXX: ポップアップメニュー無効時、E523: Not allowed here
      return -2
    endif
    return 0
  else
    return -1
  endif
endfunction

" 部首合成辞書から、指定された文字を含む行を検索する
function! s:SearchBushuDic(ch)
  if !s:Bushu_FileOpen()
    return ""
  endif
  let lines = ""
  silent! normal! G$
  if search(a:ch, 'w') != 0
    let lines = getline('.')
    while search(a:ch, 'W') != 0
      let lines = lines . "\<CR>" . getline('.')
    endwhile
  endif
  quit!
  return lines
endfunction

" 指定された文字を入力するためのストロークをkeymapファイルから検索する
function! s:SearchKeymap(ch, keymap)
  let kmfile = globpath(&rtp, "keymap/" . a:keymap . "_" . &encoding . ".vim")
  if filereadable(kmfile) != 1
    let kmfile = globpath(&rtp, "keymap/" . a:keymap . ".vim")
    if filereadable(kmfile) != 1
      return ""
    endif
  endif
  execute "silent normal! :sv " . kmfile . "\<CR>"
  if !s:buflisted
    set nobuflisted
  endif
  let dummy = search('loadkeymap', 'w')
  if search('^[^"].*[^ 	]\+[ 	]\+' . a:ch, 'w') != 0
    let keyseq = substitute(getline('.'), '[ 	]\+.*$', '', '')
  else
    let keyseq = ""
  endif
  quit!
  return keyseq
endfunction

"==============================================================================
"				    辞書検索

" SelectWindowByName(name)
"   Acitvate selected window by a:name.
function! s:SelectWindowByName(name)
  let num = bufwinnr('^' . a:name . '$')
  if num > 0 && num != winnr()
    execute num . 'wincmd w'
  endif
  return num
endfunction

" 交ぜ書き変換辞書データファイルをオープン
function! s:Candidate_FileOpen()
  if filereadable(s:candidate_file) != 1
    return 0
  endif
  if s:SelectWindowByName(s:candidate_file) < 0
    execute 'silent normal! :sv '.s:candidate_file."\<CR>"
    if !s:buflisted
      set nobuflisted
    endif
  endif
  return 1
endfunction

" 検索に使用する状態変数
let s:last_keyword = ''
let s:last_candidate = ''
let s:last_candidate_list = []
let s:is_katuyo = 0

" 辞書から未確定文字列を検索
" @return -1:辞書が開けない場合, 0:文字列が見つからない場合,
"   1:候補が1つだけ見つかった場合, 2:候補が2つ以上見つかった場合
function! s:CandidateSearch(keyword)
  let s:last_keyword = a:keyword
  if !s:Candidate_FileOpen()
    return -1
  endif

  let s:last_candidate = ''
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
  quit!
  return ret
endfunction

" 部首合成辞書データファイルをオープン
function! s:Bushu_FileOpen()
  if filereadable(s:bushu_file) != 1
    return 0
  endif
  if s:SelectWindowByName(s:bushu_file) < 0
    execute 'silent normal! :sv '.s:bushu_file."\<CR>"
    if !s:buflisted
      set nobuflisted
    endif
  endif
  return 1
endfunction

" 等価文字を検索して返す。等価文字がない場合はもとの文字そのものを返す
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

" char1とchar2をこの順番で合成してできる文字を検索して返す。
" 見つからない場合は''を返す
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

" 指定された文字を2つの部首に分解する。
" 分解した部首をs:decomp1, s:decomp2にセットする。
" @return 1: 分解に成功した場合、0: 分解できなかった場合
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
    execute 'silent normal! :sv '.s:kanjitable_file."\<CR>"
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
    if !s:buflisted
      set nobuflisted
    endif
  endif
  %d _
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
  execute 'normal! a' . join(a:candlist, "\n") . "\<ESC>"
  normal! 1G
  wincmd p
endfunction

" 現在行の候補を確定する
function! s:Candwin_Select()
  let s:last_candidate = getline('.')
  bwipeout!
  call s:FixCandidate()
endfunction

let &cpo = s:save_cpo
