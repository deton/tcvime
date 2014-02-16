tcvime - 漢字直接入力補助機能プラグインスクリプト
							     Version: 1.5.0
							     Date: 2014-02-XXX

解説
  tcode,tutcode等の漢字直接入力keymap用の入力補助機能を提供する
  プラグインスクリプトです。
  4つの機能を提供します:
   * 交ぜ書き変換: かな漢字変換で、かな部分に漢字が交じっていても変換
   * 部首合成変換: 口未→味 のように部首の足し算/引き算を行って漢字を合成
   * 文字ヘルプ表表示: ある文字を入力する際のキーの位置と入力順序を表示
   * 漢字テーブルファイルの表示と文字選択による入力

必要条件
  Vim 7以降。
  日本語の表示ができることと、tcode/tutcode keymapでの入力ができること。
  tcode/tutcodeのkeymapファイルは、このtcvimeのアーカイブに含まれています。

準備
  アーカイブに含まれるファイルを次の場所に置いてください。

    ファイル            置く場所              ファイルの説明
  plugin/tcvime.vim   'runtimepath'/plugin/ プラグインスクリプト本体
  autoload/tcvime.vim 'runtimepath'/autoload/ プラグインから呼び出す関数
  autoload/tcvime/bushudic.vim 'runtimepath'/autoload/tcvime/ 部首合成変換用辞書
  autoload/tcvime/helptbl_tcode.vim    'runtimepath'/autoload/tcvime/ ヘルプ表
  autoload/tcvime/helptbl_tutcode.vim  'runtimepath'/autoload/tcvime/ ヘルプ表
  autoload/tcvime/helptbl_tutcodep.vim 'runtimepath'/autoload/tcvime/ ヘルプ表
  autoload/tcvime/kanji2seq.vim        'runtimepath'/autoload/tcvime/
					    漢字から入力シーケンスへの変換。
					    部首合成変換やヘルプ表示時に使用。
  autoload/tcvime/kanji2seq_tcode.vim    'runtimepath'/autoload/tcvime/ 高速化用
  autoload/tcvime/kanji2seq_tutcode.vim  'runtimepath'/autoload/tcvime/ 高速化用
  autoload/tcvime/kanji2seq_tutcodep.vim 'runtimepath'/autoload/tcvime/ 高速化用
  doc/tcvime.jax      'runtimepath'/doc/    スクリプトの説明書
  mazegaki.dic        'runtimepath'         交ぜ書き変換用辞書
  bushu.help          'runtimepath'         ユーザ用部首合成辞書
  kanjitable.txt      'runtimepath'         漢字テーブルファイル
  keymap/tcode.vim    'runtimepath'/keymap/ T-Codeのkeymap
  keymap/tutcode.vim  'runtimepath'/keymap/ TUT-Codeのkeymap
  keymap/tutcodep.vim 'runtimepath'/keymap/ tutcodeに新常用漢字対応等63文字追加
  keymap/tutcodek.vim 'runtimepath'/keymap/ 'でひらがな/カタカナモード切り替え
					    ができるようにしたtutcodeのkeymap。
					    ただし、r,f,t等でひらがな使用不可

  'runtimepath'で示されるディレクトリは、Vim上で
  :echo &runtimepath を実行することで確認できます。
  (UNIXでは$HOME/.vim/、Windowsでは$HOME/vimfiles/)

  辞書ファイルや.txtファイルの漢字コードはUTF-8です。
  EUC-JPやCP932環境で、各ファイルをvimでそのまま開いても正しく読めない場合は、
  環境に合わせて漢字コードを変換しておいてください。
  (でないと各ファイルを使う部首合成変換や交ぜ書き変換が動作しません)

使い方
  tcvime.jaxを参照してください。

謝辞
  - 村岡さんのvime.vimをベースにさせていただいています。
    tcvime.vimの交ぜ書き変換部分はほとんどvime.vimそのものです。

  - tservの部首合成アルゴリズムを使っています。
    もともとはEmacs用のTコード入力環境tcで使われていたアルゴリズムのようです。

  - mazegaki.dicはEmacs用のTコード入力環境tc2(tc-2.3.1)に含まれているものです。
    bushudic.vimは、tc2に含まれるbushu.revから作ったものです。

更新履歴
  - 1.5.0 (2014-02-XXX)
   - 文字ヘルプ表示時に、第1打鍵以外の打ち方が共通する文字のテーブル(文字表)を
     表示する機能を追加。デフォルトで有効化。'tcvime_use_helptbl'オプション。
     (ある漢字の打ち方を忘れて変換で入力した際は、ついでに近くの漢字の打ち方の
     復習をすることも多いので)
     例:
        桟頃 篇猿析|$△・・・・
        尉軟 辰祖彫| ・・・・・
        砦闇^鍵渓抄< ・・・・・
     例(従来):
        ・・・・  3 ・・・・
        ・・・・    ・・・・
        ・・1 2     ・・・・
            鍵
   - 前置型英字変換(SKK abbrev変換)機能追加。<Plug>TcvimeIAsciiStart。
     カタカナ入力が面倒で、英字変換する方が楽な場合があるので。
   - <Plug>TcvimeVSeq2Kanjiにおいて、入力シーケンス中で後置型カタカナ変換等を
     使っていると、"<C-R>=tcvime#InputConvertKatakana(3)"等がそのまま入る問題
     を修正。
   - 部首合成変換やヘルプ表示高速化のため、漢字から入力シーケンスへの変換用
     Dictionaryをautoload化。(毎回keymapファイルから生成するかわり。
     ただしkeymap変更時は手でautoload/tcvime/kanji2seq_tutcode.vim等の変更要)
   - 部首合成変換高速化のため、bushu.revをautoload/tcvime/bushudic.vimに変更。
   - keymap/tutcodep.vimに、Touch16+やTUT98.COMの拗音等の短縮ストロークを追加。
   - キーマッピングの登録・解除を行う:TcvimeOnと:TcvimeOffコマンドを削除し、
     デフォルトでキーマッピングが登録されるように変更。
     デフォルトのキーマッピングを使わず、自分で他のキーにmapしたい場合用に、
     'tcvime_no_default_key_mappings'オプションを追加。
     (従来、plugin/tcvime.vimで:TcvimeOnしておりautoload/tcvime.vimが常に読み
     込まれて、必要な時のみ読み込むようにautoload化した意味がなかったので)

  - 1.4.0 (2013-10-12)
   - スクリプトファイルや辞書ファイルの文字コードをUTF-8に変更。
   - 交ぜ書き変換候補選択バッファを開いたまま、
     再度交ぜ書き変換した際のエラーを修正。
   - Macの端末内Vimで__TcvimeHelp__が生成され続ける問題を修正(issue#3)
   - keymap/tcode.vimを追加。

  - 1.3.2 (2013-06-15)
   - 交ぜ書き変換辞書編集中の、交ぜ書き変換のバグを修正
   - 交ぜ書き変換で候補が無い場合の辞書編集に関するバグや動作修整
     - 交ぜ書き変換で候補が無い場合に辞書編集を開始するオプションを設定して
       いるのに、Normal modeの場合は辞書編集が開始されなかったバグを修正
     - 辞書編集をキャンセルするためのnmap <C-E>を追加。
     - 辞書編集中の<C-Y>による、編集完了・元バッファ上への確定動作の修整。
     - 新規追加エントリを辞書ファイル先頭に挿入するように修整。
   - 交ぜ書き変換の読みや、部首合成変換の部首に特殊文字(*.$\等)が
     含まれていても問題ないように修正

  - 1.3.1 (2013-04-07)
   - Insert modeでの後置型カタカナ変換で指定文字数伸ばす関数が
     動作していなかったバグを修正

  - 1.3.0 (2013-02-27)
   - 交ぜ書き変換の候補選択方法を改良:
     - Insert mode: Vimの補完ポップアップメニューで選択・確定
     - Normal mode: 変換候補選択用バッファで選択・確定
   - Insert mode用の後置型交ぜ書き変換関数を追加
     - 読みの文字数を指定
     - 読みの文字数を指定しない: ポップアップメニュー表示中に>で読みを縮める
     - 直前の交ぜ書き変換を縮める<Plug>
   - Visual modeで選択した文字列に対する交ぜ書き変換、カタカナ変換、
     漢字→入力シーケンス変換、入力シーケンス→漢字変換
   - 後置型カタカナ変換機能を追加:
     - カタカナに変換する文字数を指定
     - 文字数を指定しない: ひらがなや「ー」が続く間カタカナに変換
     - ひらがなとして残す文字数を指定
     - Insert mode用に、直前のカタカナ変換を縮める関数と取り消す関数
   - Insert mode用漢字→入力シーケンス変換、入力シーケンス→漢字変換関数を追加
   - 変換開始等のキーを<Plug>で設定可能にした。
     (ただし、keymapファイル内に<Plug>を書いても効かないようなので、
     lmapで使いたい場合は後で設定する必要あり。tcvime.txtの設定例参照)
     - Insert modeでの前置型交ぜ書き変換で、<Space>キーでの変換開始用<Plug>追加
       (tc2と同じ操作が可能: aljで読み入力開始後、<Space>キーで変換開始)
   - 交ぜ書き変換の学習機能を追加
     (確定した候補の、候補リスト内の移動先位置を指定するオプション)
   - 交ぜ書き変換辞書を編集用に開いて直前に変換した読みを検索するコマンドを追加
     (交ぜ書き変換辞書への単語登録・削除用)
     - Normal mode交ぜ書き変換で候補が無い場合に辞書編集を開始するオプション追加
   - ユーザ用部首合成辞書(bushu.help)ファイルがあれば
     優先して部首合成変換や部首合成ヘルプ表示に使用
   - bushu.helpを同梱(tc-2.3.1-22.6のbushu34h.helpをJIS X 0208のみにしたもの)
   - 自動ヘルプ機能追加(issue #2):
     部首合成変換や交ぜ書き変換で確定した文字列のヘルプ表を表示。
   - Visual modeで選択した複数文字に対してヘルプ表を表示する機能を追加(issue #1)
   - :TcvimeHelpや:TcvimeHelpBushuの引数として文字列に対応(1文字だけでなく)
   - 'tcvime_keymap_for_help'オプション変数を追加:
     &keymapが未設定の場合にヘルプ表の表示に使うkeymap。
   - {motion}で対象文字列を指定した変換を行うためのopfuncや<Plug>を追加:
     - 交ぜ書き変換: <Plug>TcvimeNOpConvert, <Plug>TcvimeNOpKatuyo
     - カタカナ変換: <Plug>TcvimeNOpKatakana
   - keymap/tutcodep.vimを追加。新常用漢字対応等63文字追加。
   - keymap/tutcodek_cp932.vimをtutcodek.vimに変更。
     (_cp932付きだと&encodingがcp932の場合しか読み込まれないので)
   - Vim6対応を終了。要Vim7

  - 1.2.1 (2011-12-13)
   - backspaceオプションが数値の場合にエラーが発生する問題を修正。
   - cmdheight値の退避は変更直前に行うように変更。
     tcvime読込後に設定値が変更された場合に対応するため。
   - カタカナ単語をシフトキーを使って入力する際に、単語中の
     「ー」もシフトキーを押しっぱなしで入力できるように以下の定義を
     tutcodek_cp932.vimに追加。
       e<S-Space>     ー
       E<S-Space>     ー
   - 香り屋版vimに含まれているtutcode_cp932.vimにある、
     シーケンス最初の文字のみが大文字のカタカナ定義(例:Rk	ア)を
     tutcodek_cp932.vimに追加。

  - 1.2 (2005-03-10)
   - 漢字テーブルファイルを表示して、文字を選択して入力する機能を追加。

  - 1.1 (2004-08-13)
   - タブのある行で部首合成変換等ができないバグを修正。

  - 1.0.1 (2003-09-04)
   - ヘルプバッファ名を"[TcvimeHelp]"から"__TcvimeHelp__"に変更。
   - TcvimeHelpBushuコマンドを追加:
     指定した文字を含む行を部首合成変換辞書から検索して表示。

  - 1.0 (2003-05-25)
    最初のリリース。
