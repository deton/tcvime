" vi:set ts=8 sts=2 sw=2 tw=0:
scriptencoding utf-8

" lmapcust.vim: lmapカスタマイズ用データ生成用スクリプト。
"
" tcvime#lmapcust#mkverbose():
" 1打鍵目をそのまま入力するlmapの生成用関数。
" (1打鍵目を入力後timeoutを待つのはかったるいので。)
" (参考: tc.elのtcode-verbose-stroke-list)
"
" 2打鍵以上あるシーケンスに対して、
" そのまま確定用シーケンス(2打鍵目がverbosekey)を生成。
" :call append(line('.'), tcvime#lmapcust#mkverbose(':', tcvime#mkhelptbl#keymap2dict('tutcodep')))
function! tcvime#lmapcust#mkverbose(verbosekey, keymapdict)
  let seqdict = {}
  for [k, v] in items(a:keymapdict)
    if strlen(k) >= 2
      let firstkey = k[0]
      let seqdict[firstkey] = ''
    endif
  endfor

  let list = []
  for k in keys(seqdict)
    call add(list, k . a:verbosekey . "\t" . k)
  endfor
  return list
endfunction

" 'Wi マ'等、最初が大文字のシーケンスのlunmapを生成。
" カタカナは後置型で変換するか、シフトキー押しっぱなしで入力するので、
" このようなシーケンスはほとんど使わない一方で、
" 'WiFi'等をそのまま入力できる方がうれしいので。
" :call append(line('.'), tcvime#lmapcust#unmapcapital(tcvime#mkhelptbl#keymap2dict('tutcodep')))
function! tcvime#lmapcust#unmapcapital(keymapdict)
  let list = []
  for [k, v] in items(a:keymapdict)
    if k =~ '^\u\l\+'
      call add(list, '  lunmap <buffer> ' . k)
    endif
  endfor
  return list
endfunction

" ひらがな定義から、最初が大文字のカタカナ定義を生成。
" 例: 'wi ま'から'Wi マ'を生成。
" :call append(line('.'), tcvime#lmapcust#mkcapitalkatalist(tcvime#mkhelptbl#keymap2dict('tutcodep')))
function! tcvime#lmapcust#mkcapitalkatalist(keymapdict)
  let dict = {}
  for [k, v] in items(a:keymapdict)
    if v =~ '[ぁ-ん]' && k =~ '^\l\+$'
      let capk = substitute(k, '^\(.\)\(.*\)', '\u\1\L\2', '')
      let kata = tcvime#hira2kata(v)
      let dict[capk] = kata
    endif
  endfor

  let list = []
  for [k, v] in items(dict)
    call add(list, '  lmap ' . k . "\t" . v)
  endfor
  return list
endfunction
