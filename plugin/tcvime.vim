" vi:set ts=8 sts=2 sw=2 tw=0:
scriptencoding utf-8
"
" tcvime.vim - tcode,tutcode等の漢字直接入力keymapでの入力補助機能:
"              交ぜ書き変換、部首合成変換、文字ヘルプ表表示機能。
"
" Maintainer: KIHARA Hideto <deton@m1.interq.or.jp>
" Last Change: 2014-02-22
" Original Plugin: vime.vim by Muraoka Taro <koron@tka.att.ne.jp>

if exists('plugin_tcvime_disable')
  finish
endif

" keymapを設定する
" 引数: keymap名
if !exists(":TcvimeSetKeymap")
  command -nargs=1 TcvimeSetKeymap :call tcvime#SetKeymap(<args>)
endif
" 指定された文字のヘルプ表を表示する
" 引数: 対象の文字
if !exists(":TcvimeHelp")
  command! -nargs=1 TcvimeHelp call tcvime#ShowHelpForStr(<q-args>, 0)
endif
" 指定された文字を含む行を部首合成変換辞書から検索して表示する
" 引数: 対象の文字
if !exists(":TcvimeHelpBushu")
  command! -nargs=1 TcvimeHelpBushu call tcvime#ShowHelpForStr(<q-args>, 1)
endif
" 漢字テーブルを表示する
if !exists(":TcvimeKanjiTable")
  command! TcvimeKanjiTable call tcvime#KanjiTable_FileOpen()
endif
" ヘルプ用バッファを閉じる
if !exists(":TcvimeCloseHelp")
  command! TcvimeCloseHelp call tcvime#CloseHelpBuffer()
endif
" 交ぜ書き変換辞書ファイルを編集用に開く
if !exists(":TcvimeEditMazegaki")
  command! TcvimeEditMazegaki call tcvime#MazegakiDic_Edit(1)
endif

inoremap <script> <silent> <Plug>TcvimeEnableKeymap <C-R>=tcvime#EnableKeymap()<CR>
inoremap <script> <silent> <Plug>TcvimeDisableKeymap <C-R>=tcvime#DisableKeymap()<CR>
inoremap <script> <silent> <Plug>TcvimeIStart <C-R>=tcvime#InputStart()<CR>
inoremap <script> <silent> <Plug>TcvimeIAsciiStart <C-R>=tcvime#InputAsciiStart()<CR>
inoremap <script> <silent> <Plug>TcvimeIConvOrStart <C-R>=tcvime#InputConvertOrStart(0)<CR>
inoremap <script> <silent> <Plug>TcvimeIConvOrSpace <C-R>=tcvime#InputConvertOrSpace()<CR>
inoremap <script> <silent> <Plug>TcvimeIKatuyo <C-R>=tcvime#InputConvertOrStart(1)<CR>
inoremap <script> <silent> <Plug>TcvimeIBushu <C-R>=tcvime#InputConvertBushu(col('.'))<CR>
inoremap <script> <silent> <Plug>TcvimeIShrink <C-R>=tcvime#InputConvertUndo()<CR><C-R>=tcvime#InputConvertShrinkLatest()<CR>
nnoremap <script> <silent> <Plug>TcvimeNConvert :<C-U>call tcvime#ConvertCount(v:count, 0)<CR>
nnoremap <script> <silent> <Plug>TcvimeNKatuyo :<C-U>call tcvime#ConvertCount(v:count, 1)<CR>
nnoremap <script> <silent> <Plug>TcvimeNKatakana :<C-U>call tcvime#ConvertKatakana(v:count)<CR>
nnoremap <script> <silent> <Plug>TcvimeNKataHira :<C-U>call tcvime#ConvertKatakana(-v:count)<CR>
nnoremap <script> <silent> <Plug>TcvimeNBushu :<C-U>call tcvime#ConvertBushu()<CR>
nnoremap <script> <silent> <Plug>TcvimeNHelp :<C-U>call tcvime#ShowStrokeHelp()<CR>
nnoremap <script> <silent> <Plug>TcvimeNKanjiTable :<C-U>call tcvime#KanjiTable_FileOpen()<CR>
nnoremap <script> <silent> <Plug>TcvimeNOpConvert :set opfunc=tcvime#ConvertOp<CR>g@
nnoremap <script> <silent> <Plug>TcvimeNOpKatuyo :set opfunc=tcvime#ConvertOpKatuyo<CR>g@
nnoremap <script> <silent> <Plug>TcvimeNOpKatakana :set opfunc=tcvime#ConvertOpKatakana<CR>g@
vnoremap <script> <silent> <Plug>TcvimeVHelp :<C-U>call tcvime#ShowHelpVisual()<CR>
vnoremap <script> <silent> <Plug>TcvimeVConvert :<C-U>call tcvime#ConvertOp(visualmode(), 1)<CR>
vnoremap <script> <silent> <Plug>TcvimeVKatuyo :<C-U>call tcvime#ConvertOpKatuyo(visualmode(), 1)<CR>
vnoremap <script> <silent> <Plug>TcvimeVKatakana :<C-U>call tcvime#ConvertOpKatakana(visualmode(), 1)<CR>
vnoremap <script> <silent> <Plug>TcvimeVKanji2Seq :<C-U>call tcvime#ConvertOpKanji2Seq(visualmode(), 1)<CR>
vnoremap <script> <silent> <Plug>TcvimeVSeq2Kanji :<C-U>call tcvime#ConvertOpSeq2Kanji(visualmode(), 1)<CR>
vnoremap <script> <silent> <Plug>TcvimeVShiftSeq :<C-U>call tcvime#ConvertOpShiftSeq(visualmode(), 1)<CR>

if !get(g:, 'tcvime_no_default_key_mappings', 0)
  let s:set_mapleader = 0
  if !exists('g:mapleader')
    let g:mapleader = "\<C-K>"
    let s:set_mapleader = 1
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

  if s:set_mapleader
    unlet g:mapleader
  endif
  unlet s:set_mapleader
endif

augroup Tcvime
autocmd!
autocmd InsertEnter * call tcvime#OnInsertEnter()
augroup END
