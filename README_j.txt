tcvime - 漢字直接入力補助機能プラグインスクリプトの説明書
					KIHARA, Hideto <deton@m1.interq.or.jp>
					$Id: README_j.txt,v 1.3 2003/05/24 14:30:35 deton Exp $

解説
  tcode,tutcode等の漢字直接入力keymap用の入力補助機能を提供する
  プラグインスクリプトです。
  次の3つの機能を提供します: 交ぜ書き変換、部首合成変換、文字ヘルプ表表示。

必要条件
  Vim 6.1以降。
  日本語の表示ができることと、tcode/tutcode keymapでの入力ができること。
  tcode/tutcodeのkeymapファイルは、香り屋版Vim<http://www.kaoriya.net/#VIM>
  に含まれています。

UNIXでの使用上の注意
  keymapを使うために、configure時に--with-features=bigを指定して
  コンパイルしておいてください。

  tcvime.vimやmazegaki.dic, bushu.revはcp932エンコーディングになっています。
  これらをそのまま使うには、Vimがiconv入りで作られており、
  かつ、(香り屋版に含まれているvimrcで設定されているように)、fileencodingsに
  cp932が含まれている必要があります。

  あるいは、これらのファイルのエンコーディングを
  euc-jpなどに変換しておいてください。
  (この場合、スクリプト(*.vim)中のscriptencoding cp932の変更もお忘れなく。)

準備
  アーカイブに含まれるファイルを次の場所に置いてください。

    ファイル            置く場所              ファイルの説明
  tcvime.vim          'runtimepath'/plugin  プラグインスクリプト本体
  tcvime.txt          'runtimepath'/doc     スクリプトの説明書
  mazegaki.dic        'runtimepath'か$VIM   交ぜ書き変換用辞書
  bushu.rev           'runtimepath'か$VIM   部首合成変換用辞書
  tutcodek_cp932.vim  'runtimepath'/keymap  'でひらがな/カタカナモード切り替え
					    ができるようにしたtutcodeのkeymap

  'runtimepath'や$VIMで示されるディレクトリは、Vim上で
  :echo &runtimepath や :echo $VIM を実行することで確認できます。

使い方
  tcvime.txtを参照してください。

謝辞
  - 村岡さんのvime.vimをベースにさせていただいています。
    tcvime.vimの交ぜ書き変換部分はほとんどvime.vimそのものです。

  - tservの部首合成アルゴリズムを使っています。
    もともとはEmacs用のTコード入力環境tcで使われていたアルゴリズムのようです。

  - mazegaki.dic, bushu.revはEmacs用のTコード入力環境tc2(tc-2.3.1)に
    含まれているものです。
