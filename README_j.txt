VIme - SKK-IMEの説明書
					    Muraoka Taro <koron@tka.att.ne.jp>
						     Last Change: 07-Aug-2001.

解説
  vim6 + skk辞書 だけで日本語入力を行なおうというスクリプトです。日本語仮名入
  力はローマ字keymapで、漢字の変換は今回のスクリプト+skk辞書で行ないます。公開
  以来ほとんどいじってないのでα版ということでお願いします。今版は要望により
  SKK-JISYO.Lは同梱していません。別途入手してください。

  SKK-JISYO.Lは$VIMか'runtimepath'で示されるディレクトリに、japanese_cp932.vim
  はruntime/keymapに、vime.vimはruntime/pluginに置いてください。そしてvimを起
  動します。あとは下記の使用例に従ってください。

UNIXでの使用上の注意
  keymap、辞書、及びvime.vimの漢字コード、改行コードの変換を忘れないで下さい。
  またデフォルトでkeymap機能は無効になっています。
    ./configure --with-features=big
  でコンパイルし直してください。

使用例
  お試し用バッファで、なにも考えずに次のコマンドを実行します。
    :VImeOn
    :set cmdheight=2
    :set keymap=japanese
  コレで準備完了。

  インサートモードで、次に示すようにキータイプしてください。各行の先頭の「:」
  は打たないで下さい。<Space>と<Enter>はそれぞれスペースキーとエンターキーを意
  味します。複数行に渡っていますが、行と行の間でエンターキーを押す必要はありま
  せん。
    :<Space>ai<Space><Enter>wo<Enter>kudasai<Space><Enter><Enter>
    :<Space>hosi<Space><Enter>no<Enter>ouji<Space>sama<Space><Enter><Enter>
    :<Space>ik<Space><Space><Space><Space>tte<Enter>yos<Space><Space><Enter>si!!<Enter><Enter>
  なお空白を挿入するのはShift+Spaceに割当ててあります。

参考
  村岡の連絡先はこのファイルの先頭と最後に書いてあります。
  質問はVim掲示板でも受け付けます。

  - SKK-JISYO.L(sjis)
      http://ixeris.bios.ics.saitama-u.ac.jp/~koron/software/vim/SKK-JISYO.L.bz2
  - Vim掲示板
      http://ixeris.bios.ics.saitama-u.ac.jp/~koron/bbs/bbs.cgi
  - Vim日本語版情報
      http://ixeris.bios.ics.saitama-u.ac.jp/~koron/

-------------------------------------------------------------------------------
vime-1.0a(旧版)に向けての文章
凄いものが出来ちまったかもしれません。Vim 6+SKKの辞書だけで日本語入力をしち
まおう、というものです。日本語かな入力はローマ字lmapで、漢字への変換は今回の
スクリプト+SKK辞書で行ないます。つまり似非IMEです。出来たてホヤホヤのα版で
すが公開します。あ、gvim6.0aj以外での動作保証はしません。

まず次のファイルをダウンロードして解凍してください。SKKのデカい辞書が付いて
いるので結構あります(約974KB)。
http://ixeris.bios.ics.saitama-u.ac.jp/~koron/software/vim/vime-1.0a.tar.bz2
それから解凍したSKK-JISYO.Lをgvim.exeと同じディレクトリに置きます。次にgvim
を起動してvime.vimをsourceします。runtime/pluginに置いておけば起動時に自動的
にsourceされます。そしてお試し用バッファで、なにも考えずに次のコマンドを実行
します。
:VImeOn
:set cmdheight=2
:set keymap=japanese
コレで準備完了。

いよいよ本番です。インサートモードで、次に示すようにキータイプしてください。
各行の先頭の「:」は打たないで下さい。次のiはインサートモードに入るためのiで
す。<Space>と<Enter>はそれぞれスペースキーとエンターキーを意味します。複数行
に渡っていますが、行と行の間でエンターキーを押す必要はありません。
:<Space>ai<Space><Enter>wo<Enter>kudasai<Space><Enter><Enter>
:<Space>hosi<Space><Enter>no<Enter>ouji<Space>sama<Space><Enter><Enter>
:<Space>ik<Space><Space><Space><Space>tte<Enter>yos<Space><Space><Enter>si!!<Enter><Enter>
なお空白を挿入するのはShift+Spaceに割当ててあります。

-------------------------------------------------------------------------------
                  生きる事への強い意志が同時に自分と異なる生命をも尊ぶ心となる
                                    Muraoka Taro/村岡太郎<koron@tka.att.ne.jp>
 vi:set ts=8 sts=2 sw=2 tw=78:
