tcvime - 漢字直接入力補助機能プラグインスクリプト
							     Version: 1.2.2
							     Date: 2012-12-XX

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
  tcode/tutcodeのkeymapファイルは、香り屋版Vim
  http://www.kaoriya.net/software/vim に含まれています。
  なお、tutcode keymapはこのtcvimeのアーカイブにも含まれています。

UNIXでの使用上の注意
  keymapを使うために、configure時に--with-features=bigを指定して
  コンパイルしておいてください。

  tcvime.vim, mazegaki.dic, bushu.rev, kanjitable.txtはcp932エンコーディング
  になっています。
  これらをそのまま使うには、Vimがiconv入りで作られており、
  かつ、(香り屋版に含まれているvimrcで設定されているように)、fileencodingsに
  cp932が含まれている必要があります。

  あるいは、これらのファイルのエンコーディングを
  euc-jpなどに変換しておいてください。
  (その場合、スクリプト(*.vim)中のscriptencoding cp932の変更もお忘れなく。)

準備
  アーカイブに含まれるファイルを次の場所に置いてください。

    ファイル            置く場所              ファイルの説明
  plugin/tcvime.vim   'runtimepath'/plugin/ プラグインスクリプト本体
  doc/tcvime.txt      'runtimepath'/doc/    スクリプトの説明書
  mazegaki.dic        'runtimepath'か$VIM   交ぜ書き変換用辞書
  bushu.rev           'runtimepath'か$VIM   部首合成変換用辞書
  kanjitable.txt      'runtimepath'か$VIM   漢字テーブルファイル
  autoload/tcvime.vim 'runtimepath'/autoload/ 後置型カタカナ変換用関数
  keymap/tutcodek.vim 'runtimepath'/keymap/ 'でひらがな/カタカナモード切り替え
					    ができるようにしたtutcodeのkeymap

  'runtimepath'や$VIMで示されるディレクトリは、Vim上で
  :echo &runtimepath や :echo $VIM を実行することで確認できます。

使い方
  tcvime.txtを参照してください。

~/.vimrcの設定例
  <C-J>でtutcodeを有効にし、<C-L>でtutcodeを無効にする設定の例です。
  (<C-^>でのトグル操作における、現在の状態を意識する負担を無くしたい場合用)

  if has('keymap')
    set iminsert=0 imsearch=0
    " 切替時にインデントが解除されるのを回避するため、1<C-H>
    imap <C-J> 1<C-H><C-O>:call <SID>SetKeymap('tutcodek')<CR>
    imap <C-L> 1<C-H><C-O>:set iminsert=0<CR>
    imap <silent> <ESC> <ESC>:set imsearch=0<CR>
    " nmap <C-K>k <Plug>TcvimeNKatakana
  endif
  function! s:SetKeymap(keymapname)
    if &keymap !=# a:keymapname
      let &keymap = a:keymapname
      " alaで後置型部首合成変換(TUT-Code用)
      " lmap ala <Plug>TcvimeIBushu
      " 後置型カタカナ変換(TUT-Code用)
      " lmap al1 <C-R>=tcvime#InputConvertKatakana(1)<CR>
      " lmap al2 <C-R>=tcvime#InputConvertKatakana(2)<CR>
      " lmap al3 <C-R>=tcvime#InputConvertKatakana(3)<CR>
      " lmap al4 <C-R>=tcvime#InputConvertKatakana(4)<CR>
      " lmap al5 <C-R>=tcvime#InputConvertKatakana(5)<CR>
      " lmap al6 <C-R>=tcvime#InputConvertKatakana(6)<CR>
    else
      let &iminsert = 1
    endif
  endfunction

謝辞
  - 村岡さんのvime.vimをベースにさせていただいています。
    tcvime.vimの交ぜ書き変換部分はほとんどvime.vimそのものです。

  - tservの部首合成アルゴリズムを使っています。
    もともとはEmacs用のTコード入力環境tcで使われていたアルゴリズムのようです。

  - mazegaki.dic, bushu.revはEmacs用のTコード入力環境tc2(tc-2.3.1)に
    含まれているものです。

更新履歴
  - 1.2.2 (2012-12-XX)
   - Visual modeで選択した複数文字に対してヘルプ表を表示する機能を追加(issue #1)
   - 自動ヘルプ機能追加(issue #2):
     部首合成変換や交ぜ書き変換で確定した文字列のヘルプ表を表示。
   - :TcvimeHelpや:TcvimeHelpBushuの引数として文字列に対応(1文字だけでなく)
   - 'tcvime_keymap_for_help'オプション変数を追加:
     &keymapが未設定の場合にヘルプ表の表示に使うkeymap。
   - 変換開始等のキーを<Plug>で設定可能にした。
     (ただし、keymapファイル内に<Plug>を書いても効かないようなので、
     lmapで使いたい場合は、上記~/.vimrc設定例のように後で設定する必要あり)
   - 後置型カタカナ変換機能を追加:
     - insert mode用関数: tcvime#InputConvertKatakana()。上記~/.vimrc参照
     - normal mode用<Plug>TcvimeNKatakana
   - tutcodek_cp932.vimをtutcodek.vimに変更。
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
