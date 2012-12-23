" vi:set ts=8 sts=2 sw=2 tw=0:
"
" tcvime.vim - tcode,tutcode等の漢字直接入力keymapでの入力補助機能:
"              交ぜ書き変換、部首合成変換、文字ヘルプ表表示機能。
"
" Maintainer: KIHARA Hideto <deton@m1.interq.or.jp>
" Last Change: 2012-12-23
" Original Plugin: vime.vim by Muraoka Taro <koron@tka.att.ne.jp>

scriptencoding cp932

" Description:
" コマンド:
"   :TcvimeOn         キーマッピングを有効化する
"   :TcvimeOff        キーマッピングを無効化する
"   :TcvimeHelp       指定した文字のヘルプ表を表示する
"   :TcvimeHelpBushu  指定した文字を含む行を部首合成変換辞書から検索して表示
"   :TcvimeSetKeymap  keymapをsetする
"   :TcvimeKanjiTable 漢字テーブルファイルを表示して、漢字を選んで入力
"   :TcvimeCloseHelp  ヘルプ用バッファを閉じる
"   :TcvimeEditMazegaki 交ぜ書き変換辞書を編集用に開いて直前に変換した読みを検索
"
" imap:
"   <Leader>q       交ぜ書き変換: 読みを開始
"   <Leader><Space> 交ぜ書き変換: 変換実行
"   <Leader>o       交ぜ書き変換: 活用する語の変換実行
"   <Leader>b       部首合成変換: 直前の2文字の部首合成変換実行
"
" nmap:
"   [count]<Leader><Space>  交ぜ書き変換: カーソル位置以前の[count]文字の変換
"   [count]<Leader>o        交ぜ書き変換: [count]文字の活用する語の変換
"   <Leader>b               部首合成変換: カーソル位置以前の2文字の部首合成変換
"   <Leader>?               打鍵ヘルプ表示: カーソル位置の文字のヘルプ表を表示
"   <Leader>t               漢字テーブルファイル表示
"
" vmap:
"   <Leader>?               打鍵ヘルプ表示: 選択中の(複数)文字のヘルプ表を表示
"   <Leader><Space>         交ぜ書き変換: 選択中の文字列の変換
"   <Leader>o               交ぜ書き変換: 選択中の文字列を活用する語として変換
"
" キー設定オプション:
"  imap:
"    '<Plug>TcvimeIStart'
"       交ぜ書き変換: 読みを開始するキー。省略値: <Leader>q
"       例(aljを指定する場合):
"         lmap <silent> alj <Plug>TcvimeIStart
"    '<Plug>TcvimeIConvOrStart'
"       交ぜ書き変換: 変換実行キー。省略値: <Leader><Space>
"       例(al<Space>を指定する場合):
"         lmap <silent> al<Space> <Plug>TcvimeIConvOrStart
"    '<Plug>TcvimeIConvOrSpace'
"       交ぜ書き変換: 変換実行キー。読みが無ければ' 'を挿入。
"       省略値: (無し: 未割当て)
"       例(<Space>を指定する場合):
"         imap <silent> <Space> <Plug>TcvimeIConvOrSpace
"       (lmapにすると、lmap有効時にfやtの後の<Space>が使用不可(<C-R>=なので))
"    '<Plug>TcvimeIKatuyo'
"       交ぜ書き変換: 活用する語の変換実行キー。省略値: <Leader>o
"       例(aloを指定する場合):
"         lmap <silent> alo <Plug>TcvimeIKatuyo
"    '<Plug>TcvimeIBushu'
"       部首合成変換: 直前の2文字の部首合成変換実行キー。省略値: <Leader>b
"       例(alaを指定する場合):
"         lmap <silent> ala <Plug>TcvimeIBushu
"
"  nmap:
"    '<Plug>TcvimeNConvert'
"       交ぜ書き変換: カーソル位置以前の[count]文字の変換を行うキー。
"       省略値: <Leader><Space>
"       <Leader><Space>を指定する場合の例:
"         nmap <silent> <Leader><Space> <Plug>TcvimeNConvert
"    '<Plug>TcvimeNKatuyo'
"       交ぜ書き変換: [count]文字の活用する語の変換を行うキー。
"       省略値: <Leader>o
"    '<Plug>TcvimeNBushu'
"       部首合成変換: カーソル位置以前の2文字の部首合成変換を行うキー。
"       省略値: <Leader>b
"    '<Plug>TcvimeNKatakana'
"       カタカナ変換: カーソル位置以前の[count]文字のカタカナへの変換を行うキー
"       省略値: (無し:未割当て)
"    '<Plug>TcvimeNKataHira'
"       カタカナ変換: カーソル位置以前でひらがなや「ー」が続く間カタカナに変換。
"       [count]で指定した文字数はひらがなとして残す。
"       省略値: (無し: 未割当て)
"    '<Plug>TcvimeNHelp'
"       打鍵ヘルプ表示: カーソル位置の文字のヘルプ表を表示するキー。
"       省略値: <Leader>?
"    '<Plug>TcvimeNKanjiTable'
"       漢字テーブルファイル表示を行うキー。省略値: <Leader>t
"     '<Plug>TcvimeNOpConvert'
"       交ぜ書き変換: このキーを押した後の{motion}で指定される文字列を変換。
"       注意: キーを押した際に|'operatorfunc'|を上書きします。
"       省略値: (無し: 未割当て)
"     '<Plug>TcvimeNOpKatuyo'
"       交ぜ書き変換: このキーを押した後の{motion}で指定される文字列を
"       活用する語として変換。
"       注意: キーを押した際に|'operatorfunc'|を上書きします。
"       省略値: (無し: 未割当て)
"     '<Plug>TcvimeNOpKatakana'
"       カタカナ変換: このキーを押した後の{motion}で指定される文字列を
"       カタカナ変換。
"       注意: キーを押した際に|'operatorfunc'|を上書きします。
"       省略値: (無し: 未割当て)
"
"  vmap:
"    '<Plug>TcvimeVHelp'
"       打鍵ヘルプ表示: 選択中の(複数)文字のヘルプ表を表示するキー。
"       省略値: <Leader>?
"       <Leader>? を指定する場合の例:
"         vmap <silent> <Leader>? <Plug>TcvimeVHelp
"    '<Plug>TcvimeVConvert'
"       交ぜ書き変換: 選択中の文字列の変換を行うキー。
"       省略値: <Leader><Space>
"    '<Plug>TcvimeVKatuyo'
"       交ぜ書き変換: 選択中の文字列を活用する語として変換を行うキー。
"       省略値: <Leader>o
"    '<Plug>TcvimeVKatakana'
"       カタカナ変換: 選択中の文字列をカタカナに変換するキー。
"       省略値: (無し: 未割当て)
"
" オプション:
"    'tcvime_keyboard'
"       文字ヘルプ表用のキーボード配列を表す文字列。
"       キーの後にスペース、を2回ずつ記述する。
"       例:
"         let tcvime_keyboard = "1 1 2 2 3 3 4 4 5 5 6 6 7 7 8 8 9 9 0 0 \<CR>q q w w e e r r t t y y u u i i o o p p \<CR>a a s s d d f f g g h h j j k k l l ; ; \<CR>z z x x c c v v b b n n m m , , . . / / "
"
"    'tcvime_keymap_for_help'
"       文字ヘルプ表示に使うkeymap。現在のバッファで&keymapが未設定の場合に使用
"
"    TcvimeCustomKeymap()
"       lmapのカスタマイズ用の関数。tcvime#SetKeymap()からコールバックされる。
"
"    'mapleader'
"       キーマッピングのプレフィックス。|mapleader|を参照。省略値: CTRL-K
"       CTRL-Kを指定する場合の例:
"         let mapleader = "\<C-K>"
"
"    'plugin_tcvime_disable'
"       このプラグインを読み込みたくない場合に次のように設定する。
"         let plugin_tcvime_disable = 1

if exists('plugin_tcvime_disable')
  finish
endif

" Mapping
if !exists(":TcvimeOn")
  command TcvimeOn :call tcvime#MappingOn()
endif
if !exists(":TcvimeOff")
  command TcvimeOff :call tcvime#MappingOff()
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
  command! TcvimeEditMazegaki call tcvime#MazegakiDic_Edit()
endif

TcvimeOn
